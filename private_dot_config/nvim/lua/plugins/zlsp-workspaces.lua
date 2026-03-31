-- This file has z prefix in order to put it at the end in alphabetical order
-- This file should always be kept after eevery other file that tweaks nvim-lspconfig
-- and sets server.opts.reuse_client_add_workspace to true
local find_workspace_root = function(config, path)
  if not config.root_markers then return nil end
  return vim.fs.dirname(vim.fs.find(
    config.root_markers,
    { upward = true, path = vim.fs.dirname(path) }
  )[1])
end

local function add_workspace(client, root)
  if not root then return true end
  for _, folder in ipairs(client.workspace_folders or {}) do
    if folder.name == root then  -- workspace already added -- reuse it
      return true
    end
  end
  client.workspace_folders = client.workspace_folders or {}
  table.insert(client.workspace_folders, {
    uri = vim.uri_from_fname(root),
    name = root,
  })

  if not client.initialized then return true end -- client is not initialized yet, but request with worspaces is sent on init
  client.notify("workspace/didChangeWorkspaceFolders", {
    event = {
      added = { { uri = vim.uri_from_fname(root), name = root } },
      removed = {},
    },
  })

  return true
end

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    for server, server_opts in pairs(opts.servers or {}) do
      if not server_opts.reuse_client_add_workspace then
        goto continue
      end

      -- here instead if just returning bool we decide whether to attach workspace
      -- to and existing lsp instance, the workspace is added to client object
      -- anyway, but in case client is not yet initialized notification is not sent
      -- because in that case responsibility to attach workspaces is on 'before_init'
      server_opts.reuse_client = function(client, config)
        if client.name ~= server then return false end -- don't reuse servers for other langs
        return add_workspace(client, config.root_dir)
      end

      -- gather worspaces for all open buffers and set them on init
      server_opts.before_init = function(params, config)
        params.rootPath = nil
        params.rootUri = nil
        params.workspaceFolders = {}
        local seen = {}

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if not vim.api.nvim_buf_is_loaded(buf) then goto continue end
          local path = vim.api.nvim_buf_get_name(buf)
          if path == "" then goto continue end
          -- skip buffers whose filetype is not handled by this server
          -- this prevents attaching workspace when no files with corresponding filetype
          -- are open, but there exists at least one with not corresponding filetype
          local ft = vim.bo[buf].filetype
          if not vim.tbl_contains(config.filetypes or {}, ft) then goto continue end

          local root = find_workspace_root(config, path)

          if root and not seen[root] then
            seen[root] = true
            table.insert(params.workspaceFolders, { uri = vim.uri_from_fname(root), name = root })
          end

          ::continue::
        end
      end
      ::continue::
    end
  end,
}

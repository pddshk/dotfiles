-- This file has z prefix in order to put it at the end in alphabetical order
-- This file should always be kept after eevery other file that tweaks nvim-lspconfig
-- and sets server.opts.reuse_client_add_workspace to true
return {
  "neovim/nvim-lspconfig",
  priority = 40,
  opts = function(_, opts)
    for server, server_opts in pairs(opts.servers or {}) do
      if not server_opts.reuse_client_add_workspace then
        goto continue
      end

      server_opts.reuse_client = function(client, config)
        if client.name ~= server then return false end -- don't reuse servers for other langs

        local root = config.root_dir
        for _, folder in ipairs(client.workspace_folders or {}) do
          if folder.name == root then  -- workspace already added -- reuse it
            return true
          end
        end

        client.notify("workspace/didChangeWorkspaceFolders", {
          event = {
            added = { { uri = vim.uri_from_fname(root), name = root } },
            removed = {},
          },
        })

        client.workspace_folders = client.workspace_folders or {}
        table.insert(client.workspace_folders, {
          uri = vim.uri_from_fname(root),
          name = root,
        })

        return true
      end
      ::continue::
    end
  end,
}

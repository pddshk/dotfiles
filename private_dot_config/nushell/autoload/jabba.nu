# run jabba init first, then rollback changes made to ../config.nu
# or overwrite by chezmoi apply
const jabba_integration = $nu.home-dir | path join '.jabba' 'jabba.nu'
const jabba_integration_file = if ($jabba_integration | path type) == "file" { $jabba_integration } else { null }

source $jabba_integration_file

if $jabba_integration_file == null {
    print -e "warning: no jabba integration file is found. Consider running jabba init"
}

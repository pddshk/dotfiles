# https://github.com/Jabba-Team/jabba
# TODO: remove when templating supported

def --env jabba [...params:string] {
    $env.JABBA_HOME = 'C:\Users\p_dydyshka\scoop\apps\jabba\current'
    let fd3 = mktemp -t jabba-fd3.XXXXXX.env
    nu -c $"$env.JABBA_SHELL_INTEGRATION = 'ON'
      ($env.JABBA_HOME)/bin/jabba ...($params) --fd3 ($fd3)"
    let exit_code = $env.LAST_EXIT_CODE
    if ( ls $fd3 | where size > 0B | is-not-empty ) {
       (
            open $fd3
            | str trim
            | lines
            | parse 'export {name}="{value}"'
            | transpose --header-row --as-record)| load-env
    }
    if $exit_code != 0 {
        return $exit_code
    }
}

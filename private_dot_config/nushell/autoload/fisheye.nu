def apply-patches [start_from: int = 1] {
    let repo   = $env.FISHEYE_REPO
    let branch = $env.FISHEYE_BRANCH
    let id     = $env.FISHEYE_ID

    let files = ls | where type == file | get name | sort | skip ($start_from - 1)
    for file in $files {
        ^py -2 ~/bin/crucible.py $id -r $repo -b $branch -f $file
    }
}

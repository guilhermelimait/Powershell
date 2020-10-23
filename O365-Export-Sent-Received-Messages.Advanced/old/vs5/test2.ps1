Get-ChildItem -Recurse -File |
Group-Object -Property Directory |
ForEach-Object {
    @(
        $_.Group |
        Resolve-Path -Relative |   # make relative path
        ForEach-Object Substring 2 # cut '.\' part
    )-join'; '
}



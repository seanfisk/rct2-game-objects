# Install RCT2 Tracks
# Run as Administrator from project root directory

Import-Module Pscx # For New-SymLink

$destDir = "${env:ProgramFiles(x86)}\GOGcom\RollerCoaster Tycoon 2 Triple Thrill Pack"

Push-Location Objects

ForEach ($objType in @('Tracks', 'Scenarios')) {
    Push-Location $objType

    $objTypeSrcDir = $PWD.ToString()

    ForEach ($objSrcPath in $(Get-ChildItem -Recurse -Include *.TD6, *.SC6)) {

        # Extract the track's relative filename components into an array.
        $objSrcPathIter = $objSrcPath.FullName
        $objPathComponents = @()

        While ($objSrcPathIter -ne $objTypeSrcDir) {
            $objPathComponents += Split-Path -Leaf $objSrcPathIter
            $objSrcPathIter = Split-Path -Parent $objSrcPathIter
        }

        # Reverse the array inline. It is now in filesystem order: general to most specific.
        [array]::Reverse($objPathComponents)

        # Use the top-level directory and base name to determine the filename.
        $prefix = $objPathComponents[0]
        $basename = $objPathComponents[-1]
        $objDestName = "${prefix} - ${basename}"

        # Create the symlink.
        $objDestPath = Join-Path $destDir $(Join-Path $objType $objDestName)
        # echo $objDestPath $objSrcPath.FullName
        If (Test-Path $objDestPath) {
            Remove-Item $objDestPath
        }
        New-SymLink -LiteralPath $objDestPath -TargetPath $objSrcPath.FullName
    }

    Pop-Location # $objType
}

Pop-Location # Objects

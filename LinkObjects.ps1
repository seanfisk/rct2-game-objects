# Install RCT2 Tracks
# Run from project root directory

[CmdletBinding()]
Param(
	[Parameter(Mandatory=$true, Position=1)]
	[string]$rct2RootPath
)

Import-Module Pscx # For New-Symlink and New-Hardlink

Push-Location Objects

$destDir = Resolve-Path -Path $rct2RootPath

# For linking the files, we can use symbolic links or hard links. Symbolic links require administrator permission (for some reason) but hard links do not. Hard links do not work across filesystem boundaries. Therefore, we'll use hard links if we don't need to cross a filesystem boundary.
$needsSymlink = (Split-Path -Qualifier $destDir) -ne (Split-Path -Qualifier (Get-Location))

ForEach ($objType in @('Tracks', 'Scenarios')) {
    Push-Location $objType

    $objTypeSrcDir = $PWD.ToString()

    ForEach ($objSrcPath in (Get-ChildItem -Recurse -Include *.TD6, *.SC6)) {

        # Extract the track's relative filename components into an array.
        $objSrcPathIter = $objSrcPath.FullName
        $objPathComponents = @()

        While ($objSrcPathIter -ne $objTypeSrcDir) {
            $objPathComponents += Split-Path -Path $objSrcPathIter -Leaf
            $objSrcPathIter = Split-Path -Path $objSrcPathIter -Parent
        }

        # Reverse the array inline. It is now in filesystem order: general to most specific.
        [array]::Reverse($objPathComponents)

        # Use the top-level directory and base name to determine the filename.
        $prefix = $objPathComponents[0]
        $basename = $objPathComponents[-1]
        $objDestName = "${prefix} - ${basename}"

        # Create the symlink.
        $objDestPath = Join-Path $destDir (Join-Path -Path $objType -ChildPath $objDestName)
        # echo $objDestPath $objSrcPath.FullName
        If (Test-Path $objDestPath) {
            Remove-Item $objDestPath
        }
		If ($needsSymlink) {
        	New-Symlink -LiteralPath $objDestPath -TargetPath $objSrcPath.FullName
		}
		Else {
			New-Hardlink -LiteralPath $objDestPath -TargetPath $objSrcPath.FullName
		}
    }

    Pop-Location # $objType
}

Pop-Location # Objects

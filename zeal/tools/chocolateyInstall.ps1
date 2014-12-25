$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# Add additional functions for packaging
. $(Join-Path $dest "functions.ps1")

# Install Zip
$packageName = 'zeal'
$url = 'https://github.com/jkozera/zeal/releases/download/20141123/zeal-20141123.zip'
$url64 = 'hhttps://github.com/jkozera/zeal/releases/download/20141123/zeal-20141123.zip'
$checksum = 'ecd6fcfa6d9bc0111597dc7ea3a22e54'
$checksum64 = 'ecd6fcfa6d9bc0111597dc7ea3a22e54'
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64" -checksum $checksum -checksum64 $checksum64
$exePath = $dest + '\zeal.exe'

# Install desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$desktopLink = Join-Path $desktop "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $desktopLink -targetPath $exePath

# Install start menu shortcut
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Programs))
$StartMenuGroup = Join-Path $startMenu "zeal"
New-Item $StartMenuGroup -type directory -force
$startMenuLink = Join-Path $StartMenuGroup "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $startMenuLink -targetPath $exePath

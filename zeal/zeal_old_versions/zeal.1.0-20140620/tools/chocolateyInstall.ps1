$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# Add additional functions for packaging
. $(Join-Path $dest "functions.ps1")

# Install Zip
$packageName = 'zeal'
$url = 'https://bitbucket.org/jerzykozera/zeal-win32-binary-downloads/downloads/zeal-20140620.zip'
$url64 = 'https://bitbucket.org/jerzykozera/zeal-win32-binary-downloads/downloads/zeal-20140620.zip'
$checksum = '4744af705a957f6576c62f7435898929'
$checksum64 = '4744af705a957f6576c62f7435898929'
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

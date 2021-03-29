New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
New-Item -Path "HKCR:\Directory\Background\shell"  -Name "Sora Technologies Network Test"
New-Item -Path "HKCR:\Directory\Background\shell\Sora Technologies Network Test" -Name "command"
New-ItemProperty -Path "HKCR:\Directory\Background\shell\Sora Technologies Network Test\command" -Name "(Default)" -Value "powershell.exe C:\scripts\test-network.ps1" -PropertyType string
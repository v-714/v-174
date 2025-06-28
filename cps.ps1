# Overclock CPU and GPU
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 1
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000' -Name 'PowerPolicy' -Value 1

# Disable thermal throttling and shutdown
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 0

# Clear RAM
Invoke-Expression "powershell -Command `"Clear-Memory -Confirm:$false`"" -NoProfile -ExecutionPolicy Bypass

# Remove all Microsoft apps
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Microsoft*" } | ForEach-Object { $_.UninstallString } | ForEach-Object { Invoke-Expression $_ }

# Debloat system
Disable-WindowsOptionalFeature -Online -FeatureName "MediaFeatures"
Disable-WindowsOptionalFeature -Online -FeatureName "Printing-Features"
Disable-WindowsOptionalFeature -Online -FeatureName "InternetExplorer"
Disable-WindowsOptionalFeature -Online -FeatureName "PowerShellRoot"

# Set paging file to 4000MB
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys 4000 4000"

# Optimize system
Optimize-Volume -DriveLetter C -ReTrim -Verbose
Defrag C: -V

# Overclock everything else (example: increase process priority)
[System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High

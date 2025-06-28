# Function to download and install Malwarebytes
function Install-Malwarebytes {
    $malwarebytesUrl = "https://downloads.malwarebytes.com/file/mb3"
    $malwarebytesInstaller = "mb3-setup-consumer.exe"
    $outputPath = "$env:TEMP$malwarebytesInstaller"

    Invoke-WebRequest -Uri $malwarebytesUrl -OutFile $outputPath
    Start-Process -FilePath $outputPath -ArgumentList "/silent" -Wait
}

# Install Malwarebytes
Install-Malwarebytes

# Overclock CPU to maximum
function Overclock-CPU {
    # Set CPU maximum state to 100%
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238c9fa8-0aad-41ed-83f4-97be242c8f20\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 1

    # Set CPU maximum processor state to 100%
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238c9fa8-0aad-41ed-83f4-97be242c8f20\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 1

    # Set CPU minimum processor state to 100%
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238c9fa8-0aad-41ed-83f4-97be242c8f20\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 1

    # Remove CPU clock max limit
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238c9fa8-0aad-41ed-83f4-97be242c8f20\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 0
}

# Overclock GPU to maximum
function Overclock-GPU {
    # Set GPU maximum state to 100%
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000' -Name 'PowerPolicy' -Value 1

    # Remove GPU clock max limit
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000' -Name 'PowerPolicy' -Value 0
}

# Disable thermal throttling and shutdown
function Disable-ThermalManagement {
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-8013-46e3-8249-9e6552e2a40a' -Name 'Attributes' -Value 0
}

# Clear RAM
function Clear-RAM {
    Invoke-Expression "powershell -Command `Clear-Memory -Confirm:$false`"
}

# Remove all Microsoft apps and bloatware
function Remove-Bloatware {
    $bloatwareApps = @(
        "Microsoft 3D Viewer",
        "Microsoft Office Hub",
        "Microsoft OneDrive",
        "Microsoft OneNote",
        "Microsoft Solitaire Collection",
        "Microsoft Teams",
        "Microsoft To Do",
        "Microsoft Your Phone",
        "Microsoft Xbox",
        "Microsoft Xbox Game Bar",
        "Microsoft Xbox Identity Provider",
        "Microsoft Xbox Live",
        "Microsoft Xbox Networking",
        "Microsoft Xbox Speech",
        "Microsoft Xbox System",
        "Microsoft Xbox Trophies",
        "Microsoft Xbox Video",
        "Microsoft Xbox Wireless Controller"
    )

    foreach ($app in $bloatwareApps) {
        $uninstallString = (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName -eq $app }).UninstallString
        if ($uninstallString) {
            Invoke-Expression $uninstallString
        }
    }
}

# Set paging file to 4000MB
function Set-PagingFile {
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys 4000 4000"
}

# Optimize system
function Optimize-System {
    Optimize-Volume -DriveLetter C -ReTrim -Verbose
    Defrag C: -V
}

# Overclock everything else (example: increase process priority)
function Overclock-EverythingElse {
    [System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
}

# Execute all functions
Install-Malwarebytes
Overclock-CPU
Overclock-GPU
Disable-ThermalManagement
Clear-RAM
Remove-Bloatware
Set-PagingFile
Optimize-System
Overclock-EverythingElse

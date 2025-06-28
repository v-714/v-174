# Function to download and install Malwarebytes
function Install-Malwarebytes {
    $malwarebytesUrl = "https://downloads.malwarebytes.com/file/mb3"
    $malwarebytesInstaller = "mb3-setup-consumer.exe"
    $outputPath = Join-Path -Path $env:TEMP -ChildPath $malwarebytesInstaller

    Invoke-WebRequest -Uri $malwarebytesUrl -OutFile $outputPath
    Start-Process -FilePath $outputPath -ArgumentList "/silent" -Wait
}

# Install Malwarebytes
Install-Malwarebytes

# Overclock CPU to maximum
function Overclock-CPU {
    $path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238c9fa8-0aad-41ed-83f4-97be242c8f20\0b2d69d7-8013-46e3-8249-9e6552e2a40a'
    Set-ItemProperty -Path $path -Name 'Attributes' -Value 1
}

# Overclock GPU to maximum
function Overclock-GPU {
    $gpuPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000'
    Set-ItemProperty -Path $gpuPath -Name 'PowerPolicy' -Value 1
}

# Disable thermal throttling and shutdown
function Disable-ThermalManagement {
    $thermalPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-8013-46e3-8249-9e6552e2a40a'
    Set-ItemProperty -Path $thermalPath -Name 'Attributes' -Value 0
}

# Clear RAM function (using .NET GC to collect and free memory)
function Clear-RAM {
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

# Remove bloatware Microsoft Store apps (modify the list as needed)
function Remove-Bloatware {
    $appsToRemove = @(
        "*3DViewer*",
        "*OfficeHub*",
        "*OneDrive*",
        "*OneNote*",
        "*SolitaireCollection*",
        "*Teams*",
        "*ToDo*",
        "*YourPhone*",
        "*Xbox*"
    )

    foreach ($app in $appsToRemove) {
        Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -Like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }
}

# Set paging file to 4000MB (fixed string terminator)
function Set-PagingFile {
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys 4000 4000"
}

# Optimize system by trimming and defragging
function Optimize-System {
    Optimize-Volume -DriveLetter C -ReTrim -Verbose
    Defrag C: -V
}

# Increase current process priority to High
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

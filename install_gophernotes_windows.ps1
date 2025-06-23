Write-Host "`n=== Gophernotes Windows Installer ===" -ForegroundColor Cyan

# 1. Check if pip is installed
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Host "[Error] pip is not installed" -ForegroundColor Red
    exit 1
}

# 2. Installing Jupyter Notebook
Write-Host "Installing Jupyter Notebook..."
pip install --upgrade pip
pip install jupyter

# 3. Installing Gophernotes kernel for Jupyter
Write-Host "Installing Gophernotes kernel for Jupyter..."
go install github.com/gopherdata/gophernotes@latest

# 4. Set up paths
$gopath = "$env:USERPROFILE\go"
$kernelPath = "$gopath\github.com\gopherdata\gophernotes\kernel"
$jupyterKernelPath = "$env:APPDATA\jupyter\kernels\gophernotes"

# 5. Check if GOPATH exists
if (-not (Test-Path $gopath)) {
    Write-Host "[Error] GOPATH not found at $gopath. Please ensure Go is installed correctly." -ForegroundColor Red
    exit 1
}

# 6. Check if the kernel directory exists and move files to Jupyter's kernels path
if (Test-Path $kernelPath) {
    Write-Host "Setting up Gophernotes kernel..."
    if (-not (Test-Path $jupyterKernelPath)) {
        Write-Host "Creating kernel directory at $jupyterKernelPath..."
        New-Item -ItemType Directory -Path $jupyterKernelPath -Force
    }
    Move-Item -Path "$kernelPath\*" -Destination $jupyterKernelPath -Force
} else {
    Write-Host "[Error] Kernel files not found at $kernelPath. Installation of Gophernotes may have failed." -ForegroundColor Red
    exit 1
}

Write-Host "`nInstallation completed!"
Write-Host "To run, use: jupyter notebook"
Write-Host "Choose the kernel named 'Go' from the kernel selection menu."

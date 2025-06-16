# install_gophernotes_windows.ps1
# Jalankan script ini dengan Run as Administrator

Write-Host "`n=== Gophernotes Windows Installer ===" -ForegroundColor Cyan

# 1. Cek & Install Chocolatey jika belum ada
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "⚙️ Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "✅ Chocolatey sudah terpasang"
}

# 2. Install dependensi
choco install golang python git -y
choco install zeromq -y

# Refresh env
$env:Path += ";$env:ProgramFiles\Go\bin"

# 3. Install Jupyter via pip
Write-Host "`n📦 Menginstal Jupyter Notebook..."
pip install --upgrade pip
pip install notebook

# 4. Clone dan install gophernotes
Write-Host "`n🐹 Clone dan install Gophernotes..."
$gopath = "$env:USERPROFILE\go"
$gophernotesDir = "$env:USERPROFILE\gophernotes"

git clone https://github.com/gopherdata/gophernotes.git $gophernotesDir
cd $gophernotesDir
go install .

# 5. Copy kernel ke jupyter
$kernelPath = "$env:APPDATA\jupyter\kernels\gophernotes"
mkdir $kernelPath -Force
Copy-Item "$gophernotesDir\kernel\*" $kernelPath -Recurse -Force

Write-Host "`n✅ Instalasi selesai!"
Write-Host "🚀 Jalankan dengan: jupyter notebook"
Write-Host "📓 Pilih kernel bernama 'gophernotes'"

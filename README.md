# script-install-gophernotes

Instalasi otomatis Jupyter + Gophernotes (Go Kernel untuk Jupyter Notebook).

## Cara Instalasi

```bash
wget https://raw.githubusercontent.com/mrbagir/script-install-gophernotes/main/install_gophernotes.sh -O install_gophernotes.sh
bash install_gophernotes.sh
```

## Menjalankan Jupyter

```bash
jupyter notebook
```

Lalu pilih kernel bernama gophernotes dan mulai koding Go langsung di notebook.

## 🪟 Untuk Windows

Jalankan PowerShell dengan hak administrator, lalu:

```powershell
iwr -useb https://raw.githubusercontent.com/mrbagir/script-install-gophernotes/main/install_gophernotes_windows.ps1 | iex
```

Atau unduh file dan klik kanan Run with PowerShell.


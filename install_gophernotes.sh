#!/bin/bash

echo -e "\n=== Gophernotes Linux Installer ==="

# 1. Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo -e "[Error] pip is not installed" >&2
    exit 1
fi

# 2. Installing Jupyter Notebook
echo "Installing Jupyter Notebook..."
pip install --upgrade pip
pip install jupyter

# 3. Installing Gophernotes kernel for Jupyter
echo "Installing Gophernotes kernel for Jupyter..."
GO111MODULE=on go install github.com/gopherdata/gophernotes@latest

# 4. Set up paths
GOPATH="$HOME/go"
KERNEL_PATH="$GOPATH/github.com/gopherdata/gophernotes/kernel"
JUPYTER_KERNEL_PATH="$HOME/.local/share/jupyter/kernels/gophernotes"

# 5. Check if GOPATH exists
if [ ! -d "$GOPATH" ]; then
    echo -e "[Error] GOPATH not found at $GOPATH. Please ensure Go is installed correctly." >&2
    exit 1
fi

# 6. Check if the kernel directory exists and move files to Jupyter's kernels path
if [ -d "$KERNEL_PATH" ]; then
    echo "Setting up Gophernotes kernel..."
    if [ ! -d "$JUPYTER_KERNEL_PATH" ]; then
        echo "Creating kernel directory at $JUPYTER_KERNEL_PATH..."
        mkdir -p "$JUPYTER_KERNEL_PATH"
    fi
    cp -r "$KERNEL_PATH"/* "$JUPYTER_KERNEL_PATH"
else
    echo -e "[Error] Kernel files not found at $KERNEL_PATH. Installation of Gophernotes may have failed." >&2
    exit 1
fi

echo -e "\nInstallation completed!"
echo "To run, use: jupyter notebook"
echo "Choose the kernel named 'gophernotes' from the kernel selection menu."

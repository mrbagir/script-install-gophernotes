#!/bin/bash

set -e

echo "🛠️ Menginstal Jupyter + Gophernotes..."

# Install dependencies
sudo apt update
sudo apt install -y golang git pkg-config libzmq3-dev gcc g++ python3-pip

# Setup Go path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
grep -q "GOPATH" ~/.bashrc || echo -e '\n# GOPATH\nexport GOPATH=$HOME/go\nexport PATH=$PATH:$GOPATH/bin' >> ~/.bashrc

# Install Jupyter
pip3 install --upgrade pip
pip3 install notebook

# Install gophernotes
mkdir -p ~/dev && cd ~/dev
git clone https://github.com/gopherdata/gophernotes.git || (cd gophernotes && git pull)
cd gophernotes
go install .

# Setup Jupyter kernel
mkdir -p ~/.local/share/jupyter/kernels/gophernotes
cp -r kernel/* ~/.local/share/jupyter/kernels/gophernotes
chmod +x ~/.local/share/jupyter/kernels/gophernotes/kernel

echo -e "\n✅ Gophernotes berhasil diinstal!"
echo "🚀 Jalankan dengan: jupyter notebook"

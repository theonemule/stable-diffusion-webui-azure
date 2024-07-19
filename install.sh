#!/bin/bash

# Assign the first parameter to ACTIVEUSER
ACTIVEUSER=$1

# Update and install necessary packages
apt update
apt upgrade -y
apt install -y ubuntu-drivers-common wget
ubuntu-drivers install

# Install CUDA
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
apt install -y ./cuda-keyring_1.1-1_all.deb
apt update
apt -y install cuda-toolkit-12-5 git python3 build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev python3-pip python3-venv

# Set up the stable diffusion web UI
cd /
mkdir stable-diffusion-webui
chown $ACTIVEUSER:$ACTIVEUSER stable-diffusion-webui
su -c "git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git" $ACTIVEUSER

# Create a virtual environment and install requirements
su -c "python3 -m venv /stable-diffusion-webui/venv && source /stable-diffusion-webui/venv/bin/activate && pip install -r /stable-diffusion-webui/requirements.txt" $ACTIVEUSER

# Create the systemd service file
cat <<EOF > /etc/systemd/system/stable-diffusion-webui.service
[Unit]
Description=Stable Diffusion Web UI
After=network.target

[Service]
User=$ACTIVEUSER
Group=$ACTIVEUSER
WorkingDirectory=/stable-diffusion-webui
ExecStart=/stable-diffusion-webui/webui.sh
Restart=always
Environment="PATH=/usr/bin:/usr/local/bin:/stable-diffusion-webui/venv/bin"

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon and enable the service
systemctl daemon-reload
systemctl enable stable-diffusion-webui.service

reboot
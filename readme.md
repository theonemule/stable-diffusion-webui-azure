# Stable Diffusion Web UI Deployment

## TL;DR

### [Deploy to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftheonemule%2Fstable-diffusion-webui-azure%2Fmain%2Ftemplate.json)

This repository contains a script and an Azure Resource Manager (ARM) template to deploy a virtual machine (VM) with the Stable Diffusion Web UI. The script installs all necessary dependencies and sets up the environment for the Stable Diffusion Web UI, while the ARM template provisions the VM and executes the script.

## Contents

- `install.sh`: A bash script to install necessary packages and set up the Stable Diffusion Web UI.
- `template.json`: An ARM template to deploy an Ubuntu VM with the necessary resources and run the `install.sh` script.

## Prerequisites

- An Azure account with the necessary permissions to deploy resources.
- Azure CLI installed and configured on your local machine.

## Deployment Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-repo/stable-diffusion-webui-azure.git
cd stable-diffusion-webui-azure
```

### Step 2: Customize the ARM Template

Modify the `template.json` file if necessary to fit your deployment needs (e.g., change VM size, region, etc.).

### Step 3: Deploy the ARM Template

You can deploy the ARM template using the link below, which will open the Azure portal with the custom deployment option pre-configured:

[Deploy to Azure](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/theonemule/stable-diffusion-webui-azure/main/template.json)

Alternatively, you can use the Azure CLI to deploy the ARM template. Replace the placeholders with your desired values.

```bash
az deployment group create --resource-group <your-resource-group> --template-file template.json --parameters vmName=<your-vm-name> adminUsername=<your-admin-username> adminPassword=<your-admin-password>
```

### Step 4: Access the Stable Diffusion Web UI

Once the deployment is complete, the VM will automatically set up and run the Stable Diffusion Web UI. 

### Connecting to the Azure VM Using SSH

To access the VM via SSH, you can use the following command:

```bash
ssh <admin-username>@<public-ip-address>
```

Replace `<admin-username>` with the username specified during deployment and `<public-ip-address>` with the VM's public IP address.

### Port Forwarding to Access the Stable Diffusion Web UI

To access the Stable Diffusion Web UI on port 7860 of the remote machine, set up SSH port forwarding:

```bash
ssh -L 7860:localhost:7860 <admin-username>@<public-ip-address>
```

This command forwards your local port 7860 to port 7860 on the remote VM. After running the command, you can access the Stable Diffusion Web UI by opening `http://localhost:7860` in your web browser.

## Script Details

### `install.sh`

This script performs the following actions:

1. Assigns the first parameter to `ACTIVEUSER`.
2. Updates the package lists and installs necessary packages.
3. Installs the NVIDIA CUDA toolkit.
4. Sets up the Stable Diffusion Web UI by cloning the repository and installing dependencies in a virtual environment.
5. Creates a systemd service to manage the Stable Diffusion Web UI.
6. Reboots the VM to apply all changes.

### Usage

The script is executed automatically by the ARM template during VM provisioning. However, if you need to run it manually, use the following command:

```bash
bash install.sh <admin-username>
```

## ARM Template Details

### `template.json`

This ARM template provisions the following resources:

1. **Public IP Address**: For accessing the VM.
2. **Network Interface**: To connect the VM to the network.
3. **Virtual Machine**: An Ubuntu VM with a specified size and configuration.
4. **Custom Script Extension**: To run the `install.sh` script on the VM.
5. **Network Security Group**: With a rule to allow SSH access.
6. **Virtual Network**: With a specified address space and subnet.

### Parameters

- `vmName`: Name of the virtual machine.
- `adminUsername`: Username for the VM.
- `adminPassword`: Password for the VM.
- `location`: Azure region for the VM.

## Notes

- Ensure the `adminPassword` parameter meets Azure's complexity requirements.
- The script assumes you have a compatible GPU on your VM and necessary drivers are installed.
- Modify the script and template as needed for your specific use case.

## License

This project is licensed under the MIT License.

## Acknowledgements

- [Stable Diffusion Web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

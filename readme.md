# Stable Diffusion Web UI Deployment

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

Use the Azure CLI to deploy the ARM template. Replace the placeholders with your desired values.

```bash
az deployment group create --resource-group <your-resource-group> --template-file template.json --parameters vmName=<your-vm-name> adminUsername=<your-admin-username> adminPassword=<your-admin-password>
```

### Step 4: Access the Stable Diffusion Web UI

Once the deployment is complete, the VM will automatically set up and run the Stable Diffusion Web UI. You can access it via the public IP address of the VM on the default port.

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

Feel free to contribute to this project by submitting issues or pull requests. For any questions, please contact [your-email@example.com].
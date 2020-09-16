# OpenVPN Access Server + Let's Encrypt on Ubuntu VM

![Azure Public Test Date](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/PublicLastTestDate.svg)
![Azure Public Test Result](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/PublicDeployment.svg)

![Azure US Gov Last Test Date](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/FairfaxLastTestDate.svg)
![Azure US Gov Last Test Result](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/FairfaxDeployment.svg)

![Best Practice Check](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/BestPracticeResult.svg)
![Cred Scan Check](https://azurequickstartsservice.blob.core.windows.net/badges/openvpn-access-server-ubuntu/CredScanResult.svg)

[![Deploy To Azure](https://raw.githubusercontent.com/sabbour/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsabbour%2Fazure-quickstart-templates%2Fmaster%2Fopenvpn-access-server-ubuntu%2Fazuredeploy.json)  [![Visualize](https://raw.githubusercontent.com/sabbour/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fsabbour%2Fazure-quickstart-templates%2Fmaster%2Fopenvpn-access-server-ubuntu%2Fazuredeploy.json)

This template uses the Azure Linux CustomScript extension to deploy an OpenVPN Access Server. It creates an Ubuntu VM, does a silent install of OpenVPN Access Server. Certbot is also installed to generate Let's Encrypt certificates for the webserver.

The user is **openvpn**, and use the password defined during the deployment.

After deployment, you can go to `https://<dnsprefix>.<location>.cloudapp.azure.com` , then input the user and password, download the client software on your machine, connect to the VPN Server.

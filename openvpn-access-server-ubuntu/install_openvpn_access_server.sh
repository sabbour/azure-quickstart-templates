#!/bin/bash
userPassword=$1
dnsPrefix=$2
location=$3
domain=$2.$3.cloudapp.azure.com
email="admin@$domain"

# Adding official OpenVPN Access Server repository
sudo apt update && sudo apt -y install ca-certificates wget net-tools
wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | sudo apt-key add -
sudo sh -c 'echo "deb http://as-repository.openvpn.net/as/debian bionic main">>/etc/apt/sources.list.d/openvpn-as-repo.list'

# Adding Let's Encrypt certbot repository
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:certbot/certbot

# Installing the OpenVPN Server and Let's Encrypt certbot
sudo apt update && sudo apt -y install openvpn-as && sudo apt-get -y install certbot

# Update the password for user openvpn
sudo echo "openvpn:$userPassword"|sudo chpasswd

# Configure server network settings
PUBLICIP=$(curl -s ifconfig.me)
sudo apt-get install sqlite3
sudo sqlite3 "/usr/local/openvpn_as/etc/db/config.db" "update config set value='$PUBLICIP' where name='host.name';"

# Delete existing certificates
/usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle
/usr/local/openvpn_as/scripts/confdba -mk cs.priv_key
/usr/local/openvpn_as/scripts/confdba -mk cs.cert

# Generate certificates through Let's Encrypt
sudo certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --email $email \
  --domains $domain \
  --pre-hook 'sudo service openvpnas stop' \
  --post-hook 'sudo service openvpnas start'
  
# symlink the generated certificates to the OpenVPN certificate location
sudo ln -s -f /etc/letsencrypt/live/$domain/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt
sudo ln -s -f /etc/letsencrypt/live/$domain/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key
sudo ln -s -f /etc/letsencrypt/live/$domain/fullchain.pem /usr/local/openvpn_as/etc/web-ssl/ca.crt

# Configure hostname
/usr/local/openvpn_as/scripts/sacli --key "host.name" --value "$domain" ConfigPut

# Restart OpenVPN AS service
sudo service openvpnas stop && sudo service openvpnas start

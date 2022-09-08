#!/bin/bash

curl https://raw.githubusercontent.com/cuongpct109/sysbox-infra/main/shutdown.sh | sh -

if [ -d ~/Documents ] 
then
    :
else
    mkdir ~/Documents
fi

if [ -d ~/Downloads ] 
then
    :
else
    mkdir ~/Downloads
fi

# Create .env file in ~/Documents/utilities/ folder

curl https://raw.githubusercontent.com/cuongpct109/sysbox-infra/main/env-config.sh | sh -

# Killing port 3000, port 8080 and delete necessary folders

curl https://raw.githubusercontent.com/cuongpct109/sysbox-infra/main/prepare-port-folder.sh | sh -

# Update

sudo apt update;

# Installing apache-tomcat-8.0.53, apache-ant-1.9.16 and java1.8-272

curl https://raw.githubusercontent.com/cuongpct109/sysbox-infra/main/install-tomcat-ant-node.sh | sh -

curl https://raw.githubusercontent.com/cuongpct109/sysbox-infra/main/install-java.sh | sh -

# Clone common and kyc-api source

mkdir ~/Documents/skipid 
cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/backend/common.git && git clone https://gitlab.com/ultorex/skipid/backend/kyc-api.git 

# Change staging IP -> 127.0.0.1 (local IP)

cd ~/Documents/skipid/kyc-api/src/main/resources && sed -i s:54.179.113.12:127.0.0.1:g application-dev.properties

# Clone kyc-admin source

cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/backend/kyc-admin.git && cd ~/Documents/skipid/kyc-admin/config && sed -i s:54.179.113.12:127.0.0.1:g jdbc.properties && sed -i s:54.179.113.12:127.0.0.1:g redis.properties

# Clone skipid frontend and copy .env (previously add to ~/Documents/utilities folder) to skipid frontend base folder 

cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/frontend/skipid.git

cd ~/Documents/skipid/skipid && touch .env && cp /home/cuong/Documents/utilities/.env ~/Documents/skipid/skipid/
cd ~/Documents/skipid/skipid && sed -i s:'https\://staging-api.skipid.io':'http\://localhost\:8080/kyc-api':g .env


# Remove .env file in the utilities folder

rm -rf ~/Documents/utilities/.env

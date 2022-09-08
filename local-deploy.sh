#!/bin/bash

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

curl https://raw.githubusercontent.com/cuongpct109/skipid-infra/main/env-config.sh | sh -

# Killing port 3000, port 8080 and delete necessary folders

curl https://raw.githubusercontent.com/cuongpct109/skipid-infra/main/prepare-port-folder.sh | sh -

# Update

sudo apt update;

# Installing apache-tomcat-8.0.53, apache-ant-1.9.16 and java1.8-272

curl https://raw.githubusercontent.com/cuongpct109/skipid-infra/main/install-tomcat-ant-java-node.sh | sh -

# Clone common and kyc-api source

mkdir ~/Documents/skipid 
cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/backend/common.git && git clone https://gitlab.com/ultorex/skipid/backend/kyc-api.git 

# Change staging IP -> 127.0.0.1 (local IP)

cd ~/Documents/skipid/kyc-api/src/main/resources && sed -i s:54.179.113.12:127.0.0.1:g application-dev.properties

# Build kyc-api with gradlew then move file war into webapps folder of tomcat-8.0.53

cd ~/Documents/skipid/kyc-api && ./gradlew build && cd ~/Documents/skipid/kyc-api/build/libs && mv kyc-api-0.0.1-SNAPSHOT.war ~/apache-tomcat-8.0.53/webapps/ && mv ~/apache-tomcat-8.0.53/webapps/kyc-api-0.0.1-SNAPSHOT.war ~/apache-tomcat-8.0.53/webapps/kyc-api.war

# Clone kyc-admin source

cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/backend/kyc-admin.git && cd ~/Documents/skipid/kyc-admin/config && sed -i s:54.179.113.12:127.0.0.1:g jdbc.properties && sed -i s:54.179.113.12:127.0.0.1:g redis.properties

# Build kyc-admin with ant then move war file to webapps folder of tomcat-8.0.53

cd ~/Documents/skipid/kyc-admin && ~/apache-ant-1.9.16/bin/ant && cd ~/Documents/skipid/kyc-admin/dist && mv hibtc-back.war ~/apache-tomcat-8.0.53/webapps/

# Clone skipid frontend and copy .env (previously add to ~/Documents/utilities folder) to skipid frontend base folder 

cd ~/Documents/skipid && git clone https://gitlab.com/ultorex/skipid/frontend/skipid.git

cd ~/Documents/skipid/skipid && touch .env && cp /home/cuong/Documents/utilities/.env ~/Documents/skipid/skipid/
cd ~/Documents/skipid/skipid && sed -i s:'https\://staging-api.skipid.io':'http\://localhost\:8080/kyc-api':g .env

# Install skipid frontend with yarn


cd ~/Documents/skipid/skipid
npm install 
sudo chmod -R 777 ~/Documents/skipid/skipid/node_modules
npm install -g serve

# Start tomcat server at port 8080

~/apache-tomcat-8.0.53/bin/startup.sh

# Start skipid frontend server at port 3000

cd ~/Documents/skipid/skipid 
npm run build
serve -s build -p 3000 &

# Remove .env file in the utilities folder

rm -rf ~/Documents/utilities/.env

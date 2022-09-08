#!/bin/bash

# Build kyc-api with gradlew then move file war into webapps folder of tomcat-8.0.53

cd ~/Documents/skipid/kyc-api && ./gradlew build && cd ~/Documents/skipid/kyc-api/build/libs && mv kyc-api-0.0.1-SNAPSHOT.war ~/apache-tomcat-8.0.53/webapps/ && mv ~/apache-tomcat-8.0.53/webapps/kyc-api-0.0.1-SNAPSHOT.war ~/apache-tomcat-8.0.53/webapps/kyc-api.war

# Build kyc-admin with ant then move war file to webapps folder of tomcat-8.0.53

cd ~/Documents/skipid/kyc-admin && ~/apache-ant-1.9.16/bin/ant && cd ~/Documents/skipid/kyc-admin/dist && mv hibtc-back.war ~/apache-tomcat-8.0.53/webapps/

# Install skipid frontend with npm

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

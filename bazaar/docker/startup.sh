#!/bin/bash
#chmod -R 755 ./bazaar
service mysql start 
service apache2 start
echo "Staring Java App"
nohup java -Djava.net.useSystemProxies=true -server -jar dataturks-1.0-SNAPSHOT.jar server onprem.yml >> java.log 2>&1 & 
sleep 7
#Run node app
cd bazaar
echo "Staring npm run start-onprem"
npm run start-onprem

while true; do sleep 1; done


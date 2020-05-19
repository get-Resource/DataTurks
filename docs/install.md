## Steps to build from source

- Clone this repo first and `cd` into it.
- Was tested and successfully working on Ubuntu 16.04 GCP VM and Ubuntu 18.04 locally.
- If you're feeling lazy to build from scratch, use [this pre-built docker image](https://medium.com/@dataturks/dataturks-on-prem-a-fully-self-hosted-data-annotation-solution-86b455bf0634).

### hope：基于Java-mysql的后端

```
# Build:
# Its a maven project, please install maven and then:
cd hope
mvn package -DskipTests # <-- will build the .jar file.

# Run:
# The service is based on dropwizard and taken a config file on startup. This config file specifies the MYSQL end-points, 
# password and the port to run the service on.

# Setup mysql server as in: https://github.com/DataTurks/DataTurks/blob/master/hope/docker/mysqlInit.sql

java -Djava.net.useSystemProxies=true -server -jar target/dataturks-1.0-SNAPSHOT.jar server onprem.yml
```

### bazaar：基于React的前端。
```
# Mac安装程序：
brew install node@8
brew link node@8
conda create -n bazaar python=2.7 anaconda
conda activate bazaar
xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
rm -rf node_modules
npm rebuild node-sass
npm install
npm run dev 

# Linux安装程序：
sudo apt-get -y install build-essential 
curl -sL https://deb.nodesource.com/setup_8.x | bash 	  
apt-get install --yes nodejs 	  
node -v 	  
npm -v  	  
npm i -g nodemon 	  
nodemon -v	  
apt-get clean

# build：
cd bazaar
npm install && npm run build-onprem
# build：
npm run start-onprem
```

# 下载镜像,直接运行。
```
#Download the image file from the link
[ec2-user ~]$ curl -o dataturks_docker.tar.gz https://s3-us-west-2.amazonaws.com/images.onprem.com.dataturks/dataturks_docker_3_3_0.tar.gz
#Extract the docker
[ec2-user ~]$ tar -xvzf dataturks_docker.tar.gz
#Load dataturks docker image
[ec2-user ~]$ sudo docker load --input ./dataturks_docker.tar
#Start the docker image
[ec2-user ~]$ sudo docker run -d -p 80:80 dataturks/dataturks:3.3.0
```
### 注意事项：
- 无需许可证。图像的旧版本需要一些不再需要的许可证。[忽略显示用于输入许可证的表单的页面]
- 您上载的所有数据和所有元数据都存储在容器中。在销毁容器之前，请务必确保下载数据。
- 最好选择图像的URL，因为您直接上传的所有数据（如图像等）都存储在本地，因此需要足够的磁盘空间用于容器。


# 下载源码构建编译运行
```
git clone https://github.com/get-Resource/DataTurks.git
cd DataTurks
```
### 使用Java编译源码
```
cd hope
apt install -y openjdk-8-jdk openjdk-8-jre maven
java -version
mvn package -DskipTests
```
### 使用scratch构建基础镜像，主要下载软件
```
cd ../bazaar/docker
docker build -f ./Dockerfile_base . --tag=dataturks:base
```
### 负责构建所需文件
```
cp ../hope/target/dataturks-1.0-SNAPSHOT.jar ./docker/dataturks-1.0-SNAPSHOT.jar
cp ../hope/onprem.yml ./docker/onprem.yml
```
### 使用基础镜像，进行构建。
### 此处可运行基础镜像，逐步构建，以可追踪日志
### 直接构建运行:
```
docker build -t dataturks:1.0.0 -f ./docker/Dockerfile .
docker run -d -p 9090:9090 -p 3000:3000 -p 3001:3001 -p 80:80 dataturks:1.0.0
```
### 逐步构建:
```
docker run -d --name dataturks_buile dataturks:base /bin/bash -c 'while true; do sleep 1; done'
```
### 参考[Building_on_Linux.md](Building_on_Linux.md)或参考[Dockerfile](../bazaar/docker/Dockerfile)逐步进行构建。
```
docker cp ./ dataturks_buile:/home/dataturks/ # 复制所需文件到运行的容器，仅供参考。
docker exec -it dataturks_buile /bin/bash # 进入容器
```
### 将构建好的容器打包成dataturks:1.0.0镜像，并运行
```
docker commit dataturks_buile dataturks:1.0.0 
docker run -d -p 9090:9090 -p 3000:3000 -p 3001:3001 -p 80:80 dataturks:1.0.0 
```
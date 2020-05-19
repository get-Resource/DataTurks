FROM dataturks:base

ENV DEBIAN_FRONTEND noninteractive 
ENV BASE_DIR=/home/dataturks \
	BAZAR_PARENT_DIR=/home/dataturks \
	LOCAL_DOCKER_DIR=./docker \
	LOCAL_BAZAAR_DIR=.

WORKDIR $BASE_DIR
RUN mkdir $BASE_DIR/logs 

# Install basics
COPY $LOCAL_DOCKER_DIR/onprem-dataturks.com.conf /etc/apache2/sites-available/
COPY $LOCAL_DOCKER_DIR/onprem-dataturks.com.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod proxy_http && \
    a2enmod php7.0 && \
    a2ensite onprem-dataturks.com.conf 

#init mysql DB
COPY $LOCAL_DOCKER_DIR/mysqlInit.sql $BASE_DIR/mysqlInit.sql
COPY $LOCAL_DOCKER_DIR/init.sh $BASE_DIR/init.sh
# RUN mysql --help
RUN chmod +x ./init.sh && \
	./init.sh  && \
#Copy Bazaar.
	mkdir $BAZAR_PARENT_DIR/bazaar && \
	chmod -R 755 $BAZAR_PARENT_DIR/bazaar

COPY $LOCAL_BAZAAR_DIR $BAZAR_PARENT_DIR/bazaar

#allow local uploads.
WORKDIR $BAZAR_PARENT_DIR/bazaar

RUN rm -rf $BAZAR_PARENT_DIR/bazaar/uploads && \
	mkdir $BAZAR_PARENT_DIR/bazaar/uploadsrm && \
	rm -rf $BAZAR_PARENT_DIR/bazaar/node_modules && \
	npm install
RUN npm run build-onprem && \
	npm prune && \
#remove source.
	rm -rf $BAZAR_PARENT_DIR/bazaar/src/components && \
	rm -rf $BAZAR_PARENT_DIR/bazaar/src/containers && \
	rm -rf $BAZAR_PARENT_DIR/bazaar/src/theme && \
	rm -rf $BAZAR_PARENT_DIR/bazaar/src/utils

#set permissions for apache readable.
#RUN chmod -R 755 $BAZAR_PARENT_DIR/bazaar
WORKDIR $BASE_DIR

EXPOSE 9090
EXPOSE 3000
EXPOSE 3001
EXPOSE 80

COPY $LOCAL_DOCKER_DIR/dataturks-1.0-SNAPSHOT.jar $BASE_DIR/dataturks-1.0-SNAPSHOT.jar
COPY $LOCAL_DOCKER_DIR/onprem.yml $BASE_DIR/onprem.yml

COPY $LOCAL_DOCKER_DIR/startup.sh $BASE_DIR/startup.sh
RUN chmod +x ./startup.sh
CMD ./startup.sh > ./startup_log.log


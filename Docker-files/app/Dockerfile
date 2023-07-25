# Use the official Ubuntu base image
FROM ubuntu:latest

# Update the package index and install necessary tools
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget && \
    rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Download and install Tomcat 9
ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.50
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz && \
    tar -xzf apache-tomcat-$TOMCAT_VERSION.tar.gz && \
    mv apache-tomcat-$TOMCAT_VERSION /opt/tomcat && \
    rm apache-tomcat-$TOMCAT_VERSION.tar.gz

# Set Tomcat environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Copy vprofile.jar to Tomcat's webapps directory
COPY vprofile-1.0.4.war /opt/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
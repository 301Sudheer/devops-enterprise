FROM mysql:5.7.42
ENV MYSQL_ROOT_PASSWORD=admin123
ENV MYSQL_DATABASE=vprofiledb
ENV MYSQL_USER=vprofileapp
ENV MYSQL_PASSWORD=vprofileapp123
COPY accountsdb.sql /docker-entrypoint-initdb.d/accountsdb.sql
EXPOSE 3306

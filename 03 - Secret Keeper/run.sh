#!/bin/bash

dockerImg="mysql"
dbName="web400"
rootPsw="password"
mysqlPort=3306
dbUser="web400"
dbUserPsw="password"

#sudo docker pull $dockerImg
sudo docker run -d -p $mysqlPort:$mysqlPort -e "MYSQL_ROOT_PASSWORD=$rootPsw" --name $dbName $dockerImg

sudo docker exec -it $dbName bash -c "echo \"CREATE USER '$dbUser'@'localhost' IDENTIFIED WITH mysql_native_password BY '$dbUserPsw';\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"CREATE DATABASE $dbName;\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"CREATE USER '$dbUser'@'%' IDENTIFIED BY '$dbUserPsw';\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"GRANT ALL PRIVILEGES ON $dbName.* TO '$dbUser'@'%';\" >> /tmp/db_init.sql"

sudo docker exec -it $dbName bash -c "echo \"USE $dbName;\" >> /tmp/db_init.sql"

sudo docker exec -it $dbName bash -c "echo \"CREATE TABLE S3cr3t_Us3rs ( id INT AUTO_INCREMENT PRIMARY KEY, user VARCHAR(255) NOT NULL, psw VARCHAR(255) NOT NULL, date VARCHAR(255) NOT NULL, secret VARCHAR(255) NOT NULL );\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"CREATE TABLE _MyZupaH1ddenS3cr3t_ ( id INT AUTO_INCREMENT PRIMARY KEY, secret VARCHAR(255) NOT NULL );\" >> /tmp/db_init.sql"

sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (1, 'admin', 'admin', '2018-08-09 18:07:12', 'i&#39;m the admin');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (2, 'user', 'user', '2018-08-09 18:07:12', 'test user');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (3, 'Mr. B4dGuy', 'Mr. B4dGuy', '2018-09-04 17:29:03', 'No more secret here! *evil laugh*. REMINDER: merge the branch back to master');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (4, 'john', 'john', '2018-08-09 18:07:12', 'i love Pusheen');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (5, 'Kah shae', 'Kah shae', '2018-08-09 18:07:12', 'i never pulled over with my Golf to pick up strangers');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (6, 'Safe', 'Safe', '2018-08-09 18:07:12', 'watch out and fetch your knife');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (7, 'Low Latch Eh', 'Low Latch Eh', '2018-08-10 17:21:33', 'talking &#39;bout me, some remote day');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (8, 'spritz', 'spritz', '2018-08-10 17:24:29', 'stashing away some vinegar');\" >> /tmp/db_init.sql"
sudo docker exec -it $dbName bash -c "echo \"INSERT INTO S3cr3t_Us3rs(id, user, psw, date, secret) VALUES (9, 'foo', 'foo', '2018-08-10 17:28:28', 'committed to work');\" >> /tmp/db_init.sql"

sudo docker exec -it $dbName bash -c "echo \"INSERT INTO _MyZupaH1ddenS3cr3t_(id, secret) VALUES (1, '[FLG:Publ1cW3bs7t3URL]');\" >> /tmp/db_init.sql"

sudo docker exec -it $dbName bash -c 'echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf'
sudo docker exec -it $dbName bash -c 'echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/my.cnf'
sudo docker stop $dbName
sudo docker start $dbName

while ! sudo docker exec -it $dbName mysql -u root --password=$rootPsw -e 'SELECT 1'
do
  echo "Waiting for database..."
  sleep 5
done

sudo docker exec -it $dbName bash -c "mysql -u root --password=$rootPsw < /tmp/db_init.sql"

php -S localhost:8000
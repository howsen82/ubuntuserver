# Install MariaDB
sudo apt install mariadb-server
# Or
sudo apt install mysql-server

# Check status
systemctl status mariadb

# Configure root password for MariaDB
sudo mysql_secure_installation
# Switch to unix_socket authentication [Y/n] n
# Change the root password? [Y/n] n
# Remove anonymous users? [Y/n] y
# Disallow root login remotely? [Y/n] y
# Remove test database and access to it? [Y/n] y
# Reload privilege tables now? [Y/n] y

# Connect MariaDB
sudo mariadb
mariadb -u root -p

# Configuration file located at /etc/mysql
# The configuration file that MariaDB reads on startup is the /etc/mysql/mariadb.cnf file
conf.d
debian.cnf
debian-start
mariadb.cnf # Global defaults
mariadb.conf.d
my.cnf
my.cnf.fallback

# Manage user
mariadb -u root -p
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
# Create user from remote location
CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
CREATE USER 'admin'@'192.168.1.%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

# Connect using new user
mariadb -u admin -p
mariadb -u admin -p<password>

# Create read-only user
GRANT SELECT ON *.* TO 'readonlyuser'@'localhost' IDENTIFIED BY 'password';

CREATE DATABASE mysampledb;
SHOW DATABASES;

SELECT HOST, USER, PASSWORD FROM mysql.user;

GRANT SELECT ON mysampledb.* TO 'appuser'@'localhost' IDENTIFIED BY 'password'; # Read-Only access
GRANT ALL ON mysampledb.* TO 'appuser'@'localhost' IDENTIFIED BY 'password'; # Full access
SHOW GRANTS FOR 'appuser'@'localhost';

# Drop user
DROP USER 'myuser'@'localhost'

USE mysampledb;
CREATE TABLE Employees (Name char(15), Age int(3), Occupation char(15));
SHOW COLUMNS IN Employees;

# Insert record
INSERT INTO Employees VALUES ('Joe Smith', '26', 'Ninja');
SELECT * FROM Employees;

# Delete record
DELETE FROM Employees WHERE Name = 'Joe Smith';

DROP TABLE Employees;

DROP DATABASE mysampledb;

# Create backup
mysqldump -u admin -p --databases mysampledb > mysampledb.sql

# Restore from backup
sudo mariadb -u admin -p < mysampledb.sql

# -------------------------------------------

# Setting up a secondary database server (replication)
# Edit in primary database server for /etc/mysql/conf.d/mysql.cnf
sudo nano /etc/mysql/conf.d/mysql.cnf
[mysql]

[mysqld]
log-bin
binlog-do-db=mysampledb
server-id=1

# Edit /etc/mysql/mariadb.conf.d/50-server.cnf
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
bind-address = 127.0.0.1 # Change to bind-address = 0.0.0.0

# In primary database server, MariaDB Shell
# creating a replication user named replicate
# and allowing it to connect to our primary
# server from the IP address 192.168.1.204
GRANT REPLICATION SLAVE ON *.* to 'replicate'@'192.168.1.204' identified by 'password';

sudo systemctl restart mariadb

### Secondary server
# MariaDB shell
FLUSH TABLES WITH READ LOCK;

# Backup the primary server
mysqldump -u admin -p --databases mysampledb > mysampledb.sql
# Secondary server
mariadb -u root -p < mysampledb.sql

# Secondary
sudo nano /etc/mysql/conf.d/mysql.cnf

[mysql]

[mysqld]
server-id=2

sudo systemctl restart mariadb

# Synchronization
CHANGE MASTER TO MASTER_HOST="192.168.1.184", MASTER_USER='replicate', MASTER_PASSWORD='password';

# Primary
# Now that we’re finished configuring the synchronization, we can unlock the primary server’s tables.
# On the primary server, execute the following command within the MariaDB shell:
UNLOCK TABLES;

# Secondary
# Now, we can check the status of the secondary server to see whether or not it is running
SHOW SLAVE STATUS \G;
# Assuming all went well, we should see the following line in the output:
# Slave_IO_State: Waiting for master to send event

# If the secondary server isn’t running (Slave_IO_State is blank), execute the following command:
START SLAVE;

# Next, check the status of the secondary server process again to verify:
SHOW SLAVE STATUS \G;

# From this point forward, any data you add to your database on the primary server should be replicated
# to the secondary. To test, add a new record to the Employees table on the mysampledb database on the
# primary server:
USE mysampledb;
INSERT INTO Employees VALUES ('Optimus Prime', '100', 'Transformer');

# secondary server
USE mysampledb;
SELECT * FROM Employees;

# Check which port is using on MariaDB
ss -tulpn | grep mysqld

# Primary server
GRANT REPLICATION SLAVE ON *.* to 'replicate'@'192.168.1.204' identified by 'password';
FLUSH PRIVILEGES;
# Secondary server
CHANGE MASTER TO MASTER_HOST="192.168.1.184", MASTER_USER='replicate', MASTER_PASSWORD='password';

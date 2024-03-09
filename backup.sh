#!/bin/bash

read -p "Enter the credentials server username: " CRED_USERNAME
read -p "Enter the credentials server IP address: " CRED_IP
 
# Fetch credentials file using ssh
    	
FILE_LOCATION="/home/ubuntu/.env"
FILE_DEST="/home/ubuntu/"

scp $CRED_USERNAME@$CRED_IP:$FILE_LOCATION $FILE_DEST

source $FILE_LOCATION
# Define variables

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SQL_DUMP_NAME="${MySQL_Database}_dump.sql"
DEST_DIR="/home/ubuntu"
BACKUP_LOCATION="home/ubuntu/${MySQL_Database}_dump.sql"

# Create SQL dump of the database
mysql -u "$MySQL_Username" -p "$MySQL_Password" mysqldump "$MySQL_Database" > "$SQL_DUMP_NAME"
scp "$BACKUP_DIR/$SQL_DUMP_NAME" "$CRED_USERNAME@$CRED_IP:$DEST_DIR"
 
# Output success message
echo "MySQL dump completed. Dump stored at secured server"

sudo rm $BACKUP_LOCATION
sudo rm $FILE_LOCATION


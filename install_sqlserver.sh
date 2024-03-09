#!/bin/bash
 
# Get the machine's IP address
MySQL_Host=$(hostname -I | awk '{print $1}')
 
# Check if MySQL is installed
if ! command -v mysql &> /dev/null
then
    # MySQL is not installed, so install it
    echo "MySQL is not installed. Installing..."
    sudo apt update
    sudo apt install -y mysql-server
    sudo systemctl start mysql
    sudo systemctl enable mysql
    
    echo "MySQL installed and started successfully."
else
    # MySQL is already installed
    echo "MySQL is already installed."
fi

MySQL_Host=$(hostname -I | awk '{print $1}')

# Prompt user for MySQL info

read -sp "Enter MySQL root password: " MYSQL_ROOT_PASSWORD
echo

read -p "Enter MySQL database name: " MYSQL_DATABASE
 
read -p "Enter MySQL username: " MYSQL_USER
 
read -sp "Enter MySQL password: " MYSQL_PASSWORD
echo
 
# Create a MySQL database
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'$MySQL_Host' IDENTIFIED BY '$MYSQL_PASSWORD';" 
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'$MySQL_Host';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e  "FLUSH PRIVILEGES;"

echo "MySQL user '$MYSQL_USER' and database '$MYSQL_DATABASE' created successfully."
 
# Display the MySQL user information
#echo "MySQL User: $MYSQL_USER"
#echo "MySQL Password: $MYSQL_PASSWORD"
#echo "MySQL Database: $MYSQL_DATABASE"
# Display machine's IP address
#echo "Machine IP Address: $MySQL_Host"
 
# Generate a readable timestamp for the credentials file
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
CREDENTIALS_FILE=".env"


if sudo touch "$CREDENTIALS_FILE"; then
    echo "File created successtully."
else 
    echo "failed to create file"
    exit 1
fi 

sudo chmod 700 $CREDENTIALS_FILE

sudo tee "$CREDENTIALS_FILE" > /dev/null <<EOT
MySQL_User=$MYSQL_USER
MySQL_Password=$MYSQL_PASSWORD
MySQL_Database=$MYSQL_DATABASE
MySQL_Host=$MySQL_Host
MySQL_Root=$MYSQL_ROOT_PASSWORD
EOT


read -p "Enter the credentials machine IP address: " REMOTE_MACHINE_IP
read -p "Enter the remote machine name: " USERNAME

FILE_LOCATION="/home/ubuntu"
sudo -E scp $CREDENTIALS_FILE $USERNAME@$REMOTE_MACHINE_IP:$FILE_LOCATION



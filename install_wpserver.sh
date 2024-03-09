#!/bin/bash

WP_CONFIG_PATH=$(sudo find /var/www/html -type f -name "wp-config.php" 2>/dev/null | grep "wp-config.php") 

 
if [ -f "$WP_CONFIG_PATH" ] ; then

	echo "Wordpress is installed!"

   WP_CONFIG_PATH=$(sudo find /var/www/html -type f -name "wp-config.php" 2>/dev/null | grep "wp-config.php") 

	read -p "Enter the credentials server username: " CRED_USERNAME

	read -p "Enter the credentials server IP address: " CRED_IP
 
	# Fetch credentials file using ssh
    	
	FILE_LOCATION="/home/ubuntu/.env"
	FILE_DEST="/home/ubuntu/"

	scp $CRED_USERNAME@$CRED_IP:$FILE_LOCATION $FILE_DEST

	source $FILE_LOCATION
	
	sudo sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '$MySQL_Database' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '$MySQL_User' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '$MySQL_Password' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_HOST', '.*' );/define( 'DB_HOST', '$MySQL_Host' );/" $WP_CONFIG_PATH
	sudo rm $FILE_LOCATION
	echo "WordPress configuration updated successfully. You can now log in to your WordPress admin dashboard by visiting http://public_IP/wordpress/wp-admin"

else

	# Continue with the WordPress installation and update package lists

	sudo apt update
	sudo apt install -y apache2
	sudo systemctl start apache2
	sudo systemctl enable apache2

	sudo apt install -y php mysql-server php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	sudo mv wordpress /var/www/html/
	sudo chown -R www-data:www-data /var/www/html/wordpress
	sudo chmod -R 755 /var/www/html/wordpress
	cd /var/www/html/wordpress
	
	sudo mv wp-config-sample.php wp-config.php

	WP_CONFIG_PATH=$(sudo find /var/www/html -type f -name "wp-config.php" 2>/dev/null | grep "wp-config.php") 


	read -p "Enter the credentials server username: " CRED_USERNAME

	read -p "Enter the credentials server IP address: " CRED_IP
	 
	# Fetch credentials file using ssh
    	
	FILE_LOCATION="/home/ubuntu/.env"
	FILE_DEST="/home/ubuntu/"

	scp $CRED_USERNAME@$CRED_IP:$FILE_LOCATION $FILE_DEST

	source $FILE_LOCATION

	sudo sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '$MySQL_Database' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '$MySQL_User' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '$MySQL_Password' );/" $WP_CONFIG_PATH

	sudo sed -i "s/define( 'DB_HOST', '.*' );/define( 'DB_HOST', '$MySQL_Host' );/" $WP_CONFIG_PATH
	sudo rm $FILE_LOCATION
	echo "WordPress configuration updated successfully. You can now log in to your WordPress admin dashboard by visiting http://public_IP/wordpress/wp-admin"

fi



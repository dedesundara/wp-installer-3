#!/bin/bash

# sudo touch mysql.sh
# sudo chmod 755 mysql.sh
# ./mysql.sh

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then
	echo "Please enter the NAME of the new WordPress database! (example: database1)"
	dbname=$(< /dev/urandom tr -dc _A-Z-a-z | head -c12)
	echo "Please enter the WordPress database CHARACTER SET! (example: latin1, utf8, ...)"
	charset=utf8
	echo "Creating new WordPress database..."
	mysql -e "CREATE DATABASE $dbname /*\!40100 DEFAULT CHARACTER SET $charset */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -e "show databases;"
	echo ""
	echo "Please enter the NAME of the new WordPress database user! (example: user1)"
	username=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
	echo "Please enter the PASSWORD for the new WordPress database user!"
	userpass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16)
	echo "Creating new user..."
	mysql -e "CREATE USER $username@localhost IDENTIFIED BY $userpass;"
	echo "User successfully created!"
	echo ""
	echo "Granting ALL privileges on $dbname to $username"
	mysql -e "GRANT ALL PRIVILEGES ON $dbname.* TO '$username'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"
	exit
	echo "DBname: $dbname"
	echo "DBuser: $username"
	echo "DBpass: $userpass"
	
# If /root/.my.cnf doesn't exist then it'll ask for root password	
else
	echo "Please enter root user MySQL password!"
	read rootpasswd
	echo "Please enter the NAME of the new WordPress database! (example: database1)"
	dbname=$(< /dev/urandom tr -dc _A-Z-a-z | head -c12)
	echo "Please enter the WordPress database CHARACTER SET! (example: latin1, utf8, ...)"
	charset=utf8
	echo "Creating new WordPress database..."
	mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -uroot -p${rootpasswd} -e "show databases;"
	echo ""
	echo "Please enter the NAME of the new WordPress database user! (example: user1)"
	username=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
	echo "Please enter the PASSWORD for the new WordPress database user!"
	userpass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16)
	echo "Creating new user..."
	mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
	echo "User successfully created!"
	echo ""
	echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"
	exit
	echo "DBname: $dbname"
	echo "DBuser: $username"
	echo "DBpass: $userpass"
fi
	echo "DBname: $dbname"
	echo "DBuser: $username"
	echo "DBpass: $userpass"

#!/bin/bash
rm user_id.txt
# Run Task 6 script before executing Task 7
./c6.sh

echo ""
echo "--------------"
echo "--- TASK7 ---"
echo "--------------"
echo ""
# Create a new User and capture its ID
echo "#--> Creating a new User..."
user_output=$(echo 'create User email="gui@hbtn.io" password="guipwd" first_name="Guillaume" last_name="Snow"' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db .//console.py)
user_id=$(echo "$user_output" | grep -o -E '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
echo "#--> User ID: $user_id"

echo ""
# List all Users
echo "#--> Listing all Users..."
echo 'all User' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db .//console.py

echo ""
# Execute SQL query to list all Users
echo "#--> Executing SQL query to list all Users..."
echo 'SELECT * FROM users\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""
# Save the User ID to a file for Task 8
echo "$user_id" > user_id.txt
while [ ! -e user_id.txt ]; do
  sleep 1  # Wait for 1 second
done

echo ""

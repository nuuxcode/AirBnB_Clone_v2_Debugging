#!/bin/bash

# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set the path to c6.sh in the same directory as this script
c6_script="$script_dir/c6.sh"

# Check if c6.sh exists
if [ ! -f "$c6_script" ]; then
    echo "#--> Error: 'c6.sh' not found in the same directory as '$0'."
    exit 1
fi

# Set the "exit on error" option
set -e

# Run Task 6 script before executing Task 7
"$c6_script"

# Reset the "exit on error" option (optional, depending on your script)
set +e

rm user_id.txt

echo ""
echo "--------------"
echo "--- TASK7 ---"
echo "--------------"
echo ""
# Create a new User and capture its ID
echo "#--> Creating a new User..."
user_output=$(echo 'create User email="gui@hbtn.io" password="guipwd" first_name="Guillaume" last_name="Snow"' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db ~/AirBnB_clone_v2/console.py)
user_id=$(echo "$user_output" | grep -o -E '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
echo "#--> User ID: $user_id"

echo ""
# List all Users
echo "#--> Listing all Users..."
echo 'all User' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db ~/AirBnB_clone_v2/console.py

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

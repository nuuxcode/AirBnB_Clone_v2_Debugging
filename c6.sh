#!/bin/bash

# Get the current working directory (path from where the script is called)
current_path=$(pwd)

# Set the path to console.py and setup_mysql_dev.sql
console_path="$current_path/console.py"
sql_path="$current_path/setup_mysql_dev.sql"

# Check if the required files exist
if [ ! -f "$console_path" ]; then
    echo "#--> Error: 'console.py' not found in '$current_path'."
    exit 1
fi

if [ ! -f "$sql_path" ]; then
    echo "#--> Error: 'setup_mysql_dev.sql' not found in '$current_path'."
    exit 1
fi

rm city_id.txt
echo ""
# Drop the hbnb_dev_db database if it exists
echo "#--> Dropping hbnb_dev_db database if it exists..."
echo "DROP DATABASE IF EXISTS hbnb_dev_db;" | sudo mysql

echo ""
# Execute MySQL setup script
echo "#--> Executing MySQL setup script..."
cat "$sql_path" | sudo mysql

echo ""
echo "--------------"
echo "--- TASK6 ---"
echo "--------------"
echo ""
# Create a new State and capture its ID
echo "#--> Creating a new State..."
state_output=$(echo 'create State name="California"' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db "$console_path")
state_id=$(echo "$state_output" | grep -o -E '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
echo "#--> State ID: $state_id"
echo ""
# List all States
echo "#--> Listing all States..."
echo 'all State' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db "$console_path"

echo ""
# Execute SQL query to list all States
echo "#--> Executing SQL query to list all States..."
echo 'SELECT * FROM states\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""
# Create a new City with the captured State ID
echo "#--> Creating a new City with State ID: $state_id..."
city_output=$(echo "create City state_id=\"$state_id\" name=\"San_Francisco\"" | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db "$console_path")
city_id=$(echo "$city_output" | grep -o -E '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
echo "#--> City ID: $city_id"

echo ""
# List all Cities
echo "#--> Listing all Cities..."
echo 'all City' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db "$console_path"

echo ""
# Save the City ID to a file for Task 8
echo "$city_id" > city_id.txt
while [ ! -e city_id.txt ]; do
  sleep 1  # Wait for 1 second
done

echo ""

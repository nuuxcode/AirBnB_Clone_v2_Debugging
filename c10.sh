#!/bin/bash

# Get the current working directory (path from where the script is called)
current_path=$(pwd)

# Set the path to setup_mysql_dev.sql
sql_path="$current_path/setup_mysql_dev.sql"

# Check if the required file exists
if [ ! -f "$sql_path" ]; then
    echo "Error: 'setup_mysql_dev.sql' not found in '$current_path'."
    exit 1
fi

echo ""
echo "--------------"
echo "--- TASK10 ---"
echo "--------------"
echo ""
# Drop the hbnb_dev_db database if it exists
echo "#--> Dropping hbnb_dev_db database if it exists..."
echo "DROP DATABASE IF EXISTS hbnb_dev_db;" | sudo mysql

echo ""
# Execute MySQL setup script
echo "#--> Executing MySQL setup script..."
cat "$sql_path" | sudo mysql

echo ""
# Set environment variables and run the Python script
echo "#--> Running main_place_amenities.py..."
sudo -E HBNB_MYSQL_USER=hbnb_dev \
    HBNB_MYSQL_PWD=hbnb_dev_pwd \
    HBNB_MYSQL_HOST=localhost \
    HBNB_MYSQL_DB=hbnb_dev_db \
    HBNB_TYPE_STORAGE=db \
    ./main_place_amenities.py

echo ""
# Query amenities and places tables
echo "#--> Querying amenities table..."
echo 'SELECT * FROM amenities\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""
echo "#--> Querying places table..."
echo 'SELECT * FROM places\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""
echo "#--> Querying place_amenity table..."
echo 'SELECT * FROM place_amenity\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""

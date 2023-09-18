#!/bin/bash

# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set the path to c7.sh in the same directory as this script
c7_script="$script_dir/c7.sh"

# Check if c7.sh exists
if [ ! -f "$c7_script" ]; then
    echo "Error: 'c7.sh' not found in the same directory as '$0'."
    exit 1
fi

# Set the "exit on error" option
set -e

# Run Task 7 script before executing Task 8
"$c7_script"

# Reset the "exit on error" option (optional, depending on your script)
set +e

rm place_id.txt

# Run Task 7 script before executing Task 8

echo ""
echo "--------------"
echo "--- TASK8 ---"
echo "--------------"
echo ""
# Retrieve City ID from the file
city_id=$(cat city_id.txt)
echo "City ID: $city_id"
echo ""

# Retrieve User ID from the file
user_id=$(cat user_id.txt)
echo "User ID: $user_id"
echo ""

# Create a new Place using the captured City ID and User ID
echo "#--> Creating a new Place with City ID: $city_id and User ID: $user_id..."
place_output=$(echo 'create Place city_id="'$city_id'" user_id="'$user_id'" name="Lovely_place" number_rooms=3 number_bathrooms=1 max_guest=6 price_by_night=120 latitude=37.773972 longitude=-122.431297' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db ~/AirBnB_clone_v2/console.py)
place_id=$(echo "$place_output" | grep -o -E '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
echo "Place ID: $place_id"
echo ""

# List all Places
echo "#--> Listing all Places..."
echo 'all Place' | sudo -E HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db ~/AirBnB_clone_v2/console.py

echo ""
# Execute SQL query to list all Places
echo "#--> Executing SQL query to list all Places..."
echo 'SELECT * FROM places\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo ""
# Save the Place ID to a file for reference
echo "$place_id" > place_id.txt
while [ ! -e place_id.txt ]; do
  sleep 1  # Wait for 1 second
done

echo ""

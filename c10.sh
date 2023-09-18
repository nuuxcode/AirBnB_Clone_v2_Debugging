#!/bin/bash

# Drop the hbnb_dev_db database if it exists
echo "Dropping hbnb_dev_db database if it exists..."
echo "DROP DATABASE IF EXISTS hbnb_dev_db;" | sudo mysql

# Execute MySQL setup script
echo "Executing MySQL setup script..."
cat setup_mysql_dev.sql | sudo mysql

# Set environment variables and run the Python script
echo "Running main_place_amenities.py..."
sudo -E HBNB_MYSQL_USER=hbnb_dev \
    HBNB_MYSQL_PWD=hbnb_dev_pwd \
    HBNB_MYSQL_HOST=localhost \
    HBNB_MYSQL_DB=hbnb_dev_db \
    HBNB_TYPE_STORAGE=db \
    ./main_place_amenities.py

# Query amenities and places tables
echo "Querying amenities table..."
echo 'SELECT * FROM amenities\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo "Querying places table..."
echo 'SELECT * FROM places\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

echo "Querying place_amenity table..."
echo 'SELECT * FROM place_amenity\G' | sudo mysql -uhbnb_dev -phbnb_dev_pwd hbnb_dev_db

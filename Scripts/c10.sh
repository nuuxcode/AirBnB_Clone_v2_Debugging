clear
echo ""
echo "----------------------"
echo "---- Script Setup ----"
echo "----------------------"
echo ""
if sudo service mysql status >/dev/null 2>&1; then
    echo "#--| "
    echo "#--> MySQL is already running."
    echo "#--| "
else
    echo "#--| "
    echo "#--> MySQL is not running. Starting MySQL..."
    echo "#--| "
    echo ""
    sudo service mysql start

    if sudo service mysql status >/dev/null 2>&1; then
        echo "#--| "
        echo "#--> MySQL is now running."
        echo "#--| "
    else
        echo "#--| "
        echo "#-->Failed to start MySQL. Please check your MySQL installation."
        echo "#--| "
    fi
fi
current_path=$(pwd)
config="$current_path/config.txt"
amenities="$current_path/main_place_amenities.py"
if [ ! -f "$config" ]; then
    echo "#--| "
    echo "#--> Error: 'config.txt' not found in '$current_path'."
    echo "#--> when you did clone repo there was file config.txt"
    echo "#--> make sure to copy it to where console.py"
    echo "#--> also you can put your config there if you dont use default"
    echo "#--| "
    exit 1
fi
source $config
if [ ! -f "$amenities" ]; then
    echo "#--| "
    echo "#--> Error: 'main_place_amenities.py' not found in '$current_path'."
    echo "#--> its in task you can make it or copy it from repo"
    echo "#--| "
    exit 1
fi
console_path="$current_path/console.py"
if [ ! -f "$console_path" ]; then
    echo "#--| "
    echo "#--> Error: 'console.py' not found in '$current_path'."
    echo "#--> make sure you put this script in same path of console.py"
    echo "#--| "
    exit 1
fi
run_mysql_command() {
    command="$1"
    shift  # Shift to remove the first argument (the command)

    # Check if additional arguments are provided
    if [ $# -ge 1 ]; then
        mysql_command="sudo mysql"
        while [ $# -ge 1 ]; do
            mysql_command="$mysql_command $1"
            shift
        done
        result=$($mysql_command <<< "$command" 2>&1 | grep -v "Using a password on the command line interface can be insecure")
    else
        result=$(sudo mysql -h"$HBNB_MYSQL_HOST" -u"$YOUR_USER_MYSQL" -p"$YOUR_PASSWORD_MYSQL" <<< "$command" 2>&1 | grep -v "Using a password on the command line interface can be insecure")
    fi

    if [[ $result == *"Access denied"* ]]; then
        echo "$result"
        echo ""
        echo "Check config.txt and make sure you have"
        echo "  correct settings for your MySQL database."
        echo ""
        echo "It's possible that you changed the default password"
        echo "  when you installed MySQL."
        echo ""
        echo "If you've updated the password, update config.txt accordingly."
        echo ""
        exit 1
    fi
    if [[ -n "$result" ]]; then
        echo "$result"
    fi
}
echo "#--| "
echo "#--> Dropping hbnb_dev_db database if it exists"
echo "#--| "
run_mysql_command "DROP DATABASE IF EXISTS $HBNB_MYSQL_DB;"
# Execute MySQL setup script
echo "#--> Executing MySQL setup script to make database ready"
echo "#--| "
run_mysql_command "CREATE DATABASE IF NOT EXISTS $HBNB_MYSQL_DB;"
run_mysql_command "CREATE USER IF NOT EXISTS '$HBNB_MYSQL_USER'@'$HBNB_MYSQL_HOST' IDENTIFIED BY '$HBNB_MYSQL_PWD';"
run_mysql_command "GRANT SELECT ON performance_schema.* TO '$HBNB_MYSQL_USER'@'$HBNB_MYSQL_HOST';"
run_mysql_command "GRANT ALL PRIVILEGES ON $HBNB_MYSQL_DB.* TO '$HBNB_MYSQL_USER'@'$HBNB_MYSQL_HOST';"
echo ""
echo "---------------"
echo "---- TASK10 ---"
echo "---------------"
echo ""
echo "#--| "
echo "#--> Run main_place_amenities.py:"
echo "#--| "
echo ""
output=$(sudo -E HBNB_MYSQL_USER=$HBNB_MYSQL_USER \
    HBNB_MYSQL_PWD=$HBNB_MYSQL_PWD \
    HBNB_MYSQL_HOST=$HBNB_MYSQL_HOST \
    HBNB_MYSQL_DB=$HBNB_MYSQL_DB \
    HBNB_TYPE_STORAGE=$HBNB_TYPE_STORAGE \
    $amenities 2>&1 | grep -v "MYSQL_OPT_RECONNECT is deprecated and will be removed in a future version")
if [[ -n "$output" ]]; then
    echo "$output"
fi
echo ""
echo "#--| "
echo "#--> Querying amenities table:"
echo "#--| "
echo ""
run_mysql_command 'SELECT * FROM amenities\G' -h"$HBNB_MYSQL_HOST" -u"$HBNB_MYSQL_USER" -p"$HBNB_MYSQL_PWD" "$HBNB_MYSQL_DB"
echo ""
echo "#--| "
echo "#--> Querying places table:"
echo "#--| "
echo ""
run_mysql_command 'SELECT * FROM places\G' -h"$HBNB_MYSQL_HOST" -u"$HBNB_MYSQL_USER" -p"$HBNB_MYSQL_PWD" "$HBNB_MYSQL_DB"
echo ""
echo "#--| "
echo "#--> Querying place_amenity table:"
echo "#--| "
echo ""
run_mysql_command 'SELECT * FROM place_amenity\G' -h"$HBNB_MYSQL_HOST" -u"$HBNB_MYSQL_USER" -p"$HBNB_MYSQL_PWD" "$HBNB_MYSQL_DB"
echo ""
echo "#--| "
echo ""

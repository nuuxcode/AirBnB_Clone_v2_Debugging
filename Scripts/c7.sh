clear
echo ""
echo "----------------------"
echo "---- Script Setup ----"
echo "----------------------"
echo ""
current_path=$(pwd)
config="$current_path/config.txt"
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
        result=$(sudo mysql <<< "$command" 2>&1 | grep -v "Using a password on the command line interface can be insecure")
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
run_console_command() {
    command="$1"
    shift  # Shift to remove the first argument (the command)

    # Check if additional arguments are provided
    if [ $# -ge 1 ]; then
        full_command="echo '$command' | sudo -E HBNB_MYSQL_USER=$HBNB_MYSQL_USER HBNB_MYSQL_PWD=$HBNB_MYSQL_PWD HBNB_MYSQL_HOST=$HBNB_MYSQL_HOST HBNB_MYSQL_DB=$HBNB_MYSQL_DB HBNB_TYPE_STORAGE=$HBNB_TYPE_STORAGE $console_path $@"
    else
        full_command="echo '$command' | sudo -E HBNB_MYSQL_USER=$HBNB_MYSQL_USER HBNB_MYSQL_PWD=$HBNB_MYSQL_PWD HBNB_MYSQL_HOST=$HBNB_MYSQL_HOST HBNB_MYSQL_DB=$HBNB_MYSQL_DB HBNB_TYPE_STORAGE=$HBNB_TYPE_STORAGE $console_path"
    fi

    result=$(eval "$full_command" 2>&1)

    if [[ -n "$result" ]]; then
        echo "$result"
    fi
}
echo "#--| "
echo "#--> Dropping hbnb_dev_db database if it exists:"
echo "#--| "
run_mysql_command "DROP DATABASE IF EXISTS $HBNB_MYSQL_DB;"
echo "#--| "
# Execute MySQL setup script
echo "#--> Executing MySQL setup script to make database ready:"
echo "#--| "
run_mysql_command "CREATE DATABASE IF NOT EXISTS $HBNB_MYSQL_DB;"
run_mysql_command "CREATE USER IF NOT EXISTS '"$HBNB_MYSQL_USER"'@'"$HBNB_MYSQL_HOST"' IDENTIFIED BY '"$HBNB_MYSQL_PWD"';"
run_mysql_command "GRANT SELECT ON performance_schema.* TO '"$HBNB_MYSQL_USER"'@'"$HBNB_MYSQL_HOST"';"
run_mysql_command "GRANT ALL PRIVILEGES ON $HBNB_MYSQL_DB.* TO '"$HBNB_MYSQL_USER"'@'"$HBNB_MYSQL_HOST"';"
echo ""
echo "--------------"
echo "--- TASK7 ---"
echo "--------------"
echo ""
echo "#--| "
echo "#--> Creating a new User:"
echo "#--| "
echo ""
user_output=$(run_console_command 'create User email="gui@hbtn.io" password="guipwd" first_name="Guillaume" last_name="Snow"' | tee /dev/tty)
echo ""
user_id=$(echo "$user_output" | grep -E "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$" | tail -1)
if [ -z "$user_id" ]; then
    echo "#--| "
    echo "#--> Couldn't find a valid User id"
    echo "#--> Your console is not printing User id"
    echo "#--> Check do_create"
    echo "#--| "
  exit 1
fi
echo "#--| "
echo "#--> User ID: $user_id"
echo "#--| "
echo "#--> Listing all Users:"
echo "#--| "
echo ""
run_console_command 'all User'
echo ""
echo "#--| "
echo "#--> Executing SQL query to list all Users:"
echo "#--| "
echo ""
run_mysql_command 'SELECT * FROM users\G' -h"$HBNB_MYSQL_HOST" -u"$HBNB_MYSQL_USER" -p"$HBNB_MYSQL_PWD" "$HBNB_MYSQL_DB"
echo ""
echo "#--| "
echo ""

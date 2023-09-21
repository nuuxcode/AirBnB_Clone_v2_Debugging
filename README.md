# AirBnB v2 Debugging with Bash Scripts



https://github.com/nuuxcode/AirBnB_Clone_v2_Debugging/assets/24565896/a4f7643e-51dc-4690-a8a2-6afe669cc863



## Introduction

Debugging AirBnB projects can become challenging as you progress through related tasks. To make the process easier, we've created a set of Bash scripts that allow you to test and verify various tasks effortlessly. Currently, we have scripts for tasks 6, 7, 8, and 10.

## Usage

To get started, follow these steps:

1. Clone this repository to your local machine using the following command (outside of AirBnB_Clone_v2):
```shell
   git clone https://github.com/nuuxcode/AirBnB_Clone_v2_Debugging.git
 ```
2. Change your working directory to the cloned repository:
```shell
cd AirBnB_Clone_v2_Debugging
```
3. Copy all the files inside Scripts folder to the AirBnB directory:
```shell
cd Scripts
cp * /Your/AirBnb/Path
```
4. Change your working directory to the AirBnB project
```shell
cd /Your/AirBnb/Path
```
5. Run the desired script by executing
```shell
./c10.sh  (example for task10)
```

The config.txt file contains default MySQL configuration.
```SQL
HBNB_MYSQL_USER=hbnb_dev
HBNB_MYSQL_PWD=hbnb_dev_pwd
HBNB_MYSQL_HOST=localhost
HBNB_MYSQL_DB=hbnb_dev_db
HBNB_TYPE_STORAGE=db
YOUR_MYSQL_SERVER=localhost
YOUR_USER_MYSQL=root
YOUR_PASSWORD_MYSQL=root
```
Ensure that you copy scripts to the correct directory where the python file console.py exists.

## Task Execution

When you execute a script for a specific task, it will execute all commands and provide the results, you have to compare it to the task examples.

## Automation

When you run the script for task 8 or 9, it automatically creates a City and a User because creating a Place requires both a User ID and a City ID, and creating a review needs them too.

## Benefits

- **Simplified Testing:** These scripts simplify the process of testing and verifying different tasks, reducing the likelihood of errors.
- **Efficiency:** By automating the setup and execution of related tasks, you save time and effort.
- **Consistency:** The scripts ensure that each task is executed consistently, minimizing variations in testing.

With these Bash scripts, debugging your AirBnB project becomes more efficient and less error-prone. Happy debugging!

## Debugging Videos Playlist for AirBnB v2:

[YouTube Link](https://www.youtube.com/playlist?list=PLQ2qWwUzKtGS7YufaE8xDT3cqGUVW-wGC)

## Authors

- [Mounssif BOUHLAOUI](https://twitter.com/nuux_tv)
- [Nyangasi Mhozya](https://github.com/Fuzzworth)

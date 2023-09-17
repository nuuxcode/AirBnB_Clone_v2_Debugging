# AirBnB v2 Debugging with Bash Scripts

https://github.com/nuuxcode/AirBnB_Clone_v2_Test/assets/24565896/7fc6c299-9052-4af0-8c7e-0975d73c9ef5

## Introduction

Debugging AirBnB projects can become challenging as you progress through related tasks. 
To make the process easier, we've created a set of Bash scripts that allow you to test and verify various tasks effortlessly.
Currently, we have scripts for tasks 6, 7, and 8, and we plan to add more for upcoming tasks.

## Usage

To get started, follow these steps:

1. Place all the script files in the same folder where you have your `console.py` and `setup_mysql_dev.sql` files.
2. Give executable permissions to the scripts using `chmod +x script_name.sh`.

## Task Execution

When you execute a script for a specific task, it will perform the necessary actions and provide the expected results, just like the task examples.

## Task 8 Automation

Notably, when you run the script for task 8, it automatically calls scripts for tasks 6 and 7.
This is because creating a place in task 8 requires both a user ID and a city ID, which are obtained from tasks 6 and 7.

## Benefits

- **Simplified Testing:** These scripts simplify the process of testing and verifying different tasks, reducing the likelihood of errors.
- **Efficiency:** By automating the setup and execution of related tasks, you save time and effort.
- **Consistency:** The scripts ensure that each task is executed consistently, minimizing variations in testing.

With these Bash scripts, debugging your AirBnB project becomes more efficient and less error-prone. Happy debugging!

## Authors

- [Mounssif BOUHLAOUI](https://twitter.com/nuux_tv)
- [Nyangasi Mhozya](https://github.com/Fuzzworth)

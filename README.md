# AirBnB v2 Debugging with Bash Scripts

## Introduction

Debugging AirBnB projects can become challenging as you progress through related tasks. To make the process easier, we've created a set of Bash scripts that allow you to test and verify various tasks effortlessly. Currently, we have scripts for tasks 6, 7, 8, and 10, and we plan to add more for upcoming tasks.

## Usage

To get started, follow these steps:

1. Ensure that you have the necessary Python files (`console.py` and `main_place_amenities.py`) and the SQL setup file (`setup_mysql_dev.sql`) in the same folder as the scripts.

2. Give executable permissions to the scripts using `chmod +x script_name.sh`.

3. Run the desired script by executing `./script_name.sh`.

## Task Execution

When you execute a script for a specific task, it will perform the necessary actions and provide the expected results, just like the task examples.

## Task 8 Automation

When you run the script for task 8, it automatically calls scripts for tasks 6 and 7. This is because creating a place in task 8 requires both a user ID and a city ID, which are obtained from tasks 6 and 7.

## Task 10 Note

**Important Note for Task 10:**

Before executing the Task 10 script, ensure that you have created the file `main_place_amenities.py` in the root directory of the project following the example provided in the task.

If you encounter import-related issues, consider the following modifications:

- Remove the line: `from models import *`
- Add the following individual import statements:

```python
from models.user import User
from models.place import Place
from models.state import State
from models.city import City
from models.amenity import Amenity
from models import storage
```
These changes should help resolve any import problems when running the script for Task 10.

## Benefits

- **Simplified Testing:** These scripts simplify the process of testing and verifying different tasks, reducing the likelihood of errors.
- **Efficiency:** By automating the setup and execution of related tasks, you save time and effort.
- **Consistency:** The scripts ensure that each task is executed consistently, minimizing variations in testing.

With these Bash scripts, debugging your AirBnB project becomes more efficient and less error-prone. Happy debugging!

## Authors

- [Mounssif BOUHLAOUI](https://twitter.com/nuux_tv)
- [Nyangasi Mhozya](https://github.com/Fuzzworth)

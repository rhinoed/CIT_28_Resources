# Shell Scripts
[Running a shell script](#running-a-script)

[Using generate_ERD.sh](#using-generate_erdsh)

## Introduction
Shelll scripts can be used to automate tasks that you would normally input manually into the command line. There are numerous different shells, but the most common are `bash`, `zsh`, and `fish`. On Unix-like operating systems Linux, and macOS, `bash` is installed by default. On macOS the default shell is `zsh`. Which is very similar to `bash`.

 The scripts in this directory are written in `bash` and are meant to be used in the `bash` shell.
Usally, the first line of a script will begin with what is known as a `shebang` or `hashbang`. This tells the system what shell to use to run the script. So to begin a `bash` script the first line would be `#!/bin/bash` or whatever the path to the `bash` shell is on your system. To find the path you can use the `which` command like so:
```bash
which bash
```
> [!NOTE]
> On Windows systems, you can use the `bash` shell by installing the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install) and then installing a Linux distribution from the Microsoft Store. Once you have a Linux distribution installed, you can run the `bash` shell. (AI generated content)

> Scripting directly in the Windows Command Prompt is also possible using .bat files. 

#### **Running a script**
In order to run a script, you need to make sure that you have permission to execute the script. You can check this in the terminal by running the following command:
```bash
ls -l script_name.sh
```
On the left side of the output, you will see a permission string that looks something like this:
```bash
# This string is executable by everyone
-rwxr-xr-x
# While this string is only executable by the owner
-rwxrw-r--
# The first - would be a d if it was a directory
drwxr-xr-x
# The next three characters are the user permissions
# The next three characters are the group permissions
# The last three characters are the other permissions
```
You can change the permissions of the script by running the following command:
```bash
# This will give everyone permission to execute the script
chmod +x script_name.sh
# This will give only the owner permission to execute the script
chmod u+x script_name.sh
# This will give only the group permission to execute the script
chmod g+x script_name.sh
```
You can also use the octal notation to set the permissions:
```bash
# This will give everyone permission to execute the script
chmod 755 script_name.sh
# This will give only the owner permission to execute the script
chmod 700 script_name.sh
# This will give only the group permission to execute the script
chmod 770 script_name.sh
```
> [!NOTE]
> You can think of each`-` as a bit in a octal (base 8) number. An octal number can be 0-7. Each of the permission strings (group of three) represents an octal number. Going right to left, on each group the first `-` is the 1's place, the second `-` is the 2's place, the third `-` is the 4's place. If you see anything other than a `-` in the place, you add the value of the place to the total. So, if you see a `r` in the 4's place, you would add 4 to the total. If you see a `w` in the 2's place, you would add 2 to the total. If you see a `x` in the 1's place, you would add 1 to the total. If you see a `-` in the place, you would add 0 to the total. Then just repeat this process for the `group` and `other` permissions.

## Using `generate_ERD.sh`

Once you have permission to execute the script you can run it by using the following command:
```bash
./script_name.sh
```
If you add anythoing after the `./script_name.sh`, separated by a space, it will be passed as an argument(s) to the script. In the case of `generate_ERD.sh` you need to pass the path to the schema file you want to use to generate the ERD. Here is an example of how to run the script:
```bash
./generate_ERD.sh path_to_schema_file
# If you are in the same directory as the schema file you can use the following command
./generate_ERD.sh file_name.txt
# If you are in a different directory you can use the following command
./generate_ERD.sh /path/to/file_name.txt
```
- Ready to give it a try? [generate_ERD.sh](generate_ERD.sh)

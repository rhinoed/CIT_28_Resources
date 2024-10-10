# Shell Scripts

## Jump to:
[Preparing to run a shell script](#preparing-to-running-a-script)

[Using generate_ERD.sh](#using-generate_erdsh)

[Using convert_to_dbml.sh](#using-convert_to_dbmlsh)

[Using convert_to_dbml_folder_action.sh](#using-convert_to_dbml_folder_actionsh)

## Introduction
Shell scripts are a powerful tool for automating tasks that would otherwise require manual input into the command line. Among the various shells available, bash, zsh, and fish are the most commonly used. On Unix-like operating systems, such as Linux and macOS, bash is installed by default. On macOS, the default shell is zsh, which is quite similar to bash.

The scripts in this directory are written in bash and are intended to be executed in the bash shell. Typically, the first line of a script begins with a shebang or hashbang, which specifies the shell to be used for running the script. To initiate a bash script, the first line should be #!/bin/bash or the path to the bash shell on your system. To determine the path, you can use the which command, as shown below:
```bash
which bash
```
> [!NOTE]
> On Windows systems, you can use the `bash` shell by installing the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install) and then installing a Linux distribution from the Microsoft Store. Once you have a Linux distribution installed, you can run the `bash` shell. (AI generated content)
> You can also use the `git-bash` shell that comes with the [Git for Windows](https://git-scm.com/download/win) installation. (AI generated content)

#### **Preparing to Running a script**
In order to run a script, you need to make sure that you have permission to execute the script. You can check this in the terminal by running the following command:
```bash
ls -l script_name.sh
```
**Permissions**
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
**Changing Permissions**
You can change the permissions of the script by running the following command:
```bash
# This will give everyone permission to execute the script
chmod +x script_name.sh
# This will give only the user who owns the file permission to execute the script
chmod u+x script_name.sh
# This will give the group with ownership permission to execute the script
chmod g+x script_name.sh
```
**Octal Notation**

<details>
<summary>Setting permissions with octal notation</summary>

You can also use the octal notation to set the permissions:
```bash
# This will give everyone permission to execute the script
chmod 755 script_name.sh
# This will give only the owner permission to execute the script, It will also remove read and write permissions from the group and other
chmod 700 script_name.sh
# This will give only the group permission to execute the script, It will also remove read and write permissions from other, and give read, write, and execute permissions to the group
chmod 770 script_name.sh
```

> [!NOTE]
> You can think of each`-` as a bit in an octal (base 8) number. An octal number can be 0-7. Each of the permission strings (group of three) represents an octal number. Going right to left, on each group the first `-` is the 1's place, the second `-` is the 2's place, the third `-` is the 4's place. If you see anything other than a `-` in the place, you add the value of the place to the total. So, if you see a `r` in the 4's place, you would add 4 to the total. If you see a `w` in the 2's place, you would add 2 to the total. If you see a `x` in the 1's place, you would add 1 to the total. If you see a `-` in the place, you would add 0 to the total. Then just repeat this process for the `group` and `other` permissions.

</details>

## Using `generate_ERD.sh`

Once you have permission to execute the script you can run it by using the following command:
```bash
./script_name.sh
```
If you add anything after the `./script_name.sh`, separated by a space, it’ll be treated as an argument for the script. For example, with `generate_ERD.sh`, you need to give it the path to the schema file you want to use for generating the ERD. Here’s how you can run the script:
```bash
./generate_ERD.sh path_to_schema_file
# If you are in the same directory as the schema file you can use the following command
./generate_ERD.sh file_name.txt
# If you are in a different directory you can use the following command
./generate_ERD.sh /path/to/file_name.txt
```
I have made some changes to this script from the original version. I have removed the hard coded values I had for the models and instead get the desired model from user input. And now allow the user to set the name of the generated output file. This should make the script more flexible and easier for others to use. 

I have added two `--pattern`,`-p` for use with fabric called `create_erd` and `create_erd_ai`. You can find them [here](Tool/fabric/patterns). They both do the same thing, but `create_erd_ai` was created with the help of another pattern called `create_pattern` which is included with fabric. It has given me better results when generating the ERD using local AI.

> [!IMPORTANT]
> In order for this script to function `fabric` must be installed on your system. Also if you want to use local AI `ollama` must be installed on your system. See [fabric](https://github.com/danielmiessler/fabric/tree/main), and [ollama](https://ollama.com) for more information on how to install these programs.
- Ready to give it a try? 

    [generate_ERD.sh](generate_ERD.sh)

## Using convert_to_dbml.sh

This script will use `fabric` to convert a `sql` schema to a `dbml` schema. This script is very simple to use. You just need to provide the path to the `sql` schema file you want to convert. Here’s how you can run the script:
```bash
./convert_to_dbml.sh path_to_sql_schema_file
```
> [!IMPORTANT]
> Remember `fabric` must be installed on your system for this script, and `convert_to_dbml_folder_action.sh` to work. See [fabric](/Tools/fabric/)
## Using convert_to_dbml_folder_action.sh
This script is the same as `convert_to_dbml.sh` but it is intended to be used with the `Folder Action` feature on macOS. This script will convert any `sql` schema file that is added to the folder it is attached to. To use this script you need to attach it to a folder. Here’s a breakdown of how to do that:

1. Open the Automator app on your Mac.
2. Select `Folder Action` and click `Choose`.
3. In the Actions search bar, type `Run Shell Script` and drag it to the right side of the window.
![Folder Action Run Shell Script](/Scripts/Resources/Images/action_search.png)
4. From the `Service receives selected` dropdown, select `Other` then select the folder you want to run the action.
![Folder Action](/Scripts/Resources/Images/action_folder.png)
5. In the `Pass input` dropdown, select `as arguments`.
![Folder Action Input](/Scripts/Resources/Images/action_input.png)
6. In the shell dropdown, select `/bin/bash`.
7. Copy the contents of `convert_to_dbml_folder_action.sh` and paste it into the `Run Shell Script` window.
> [!IMPORTANT]
> Make sure to change the path to `fabric` within the script. I attempted to use a variable, but it did not work with the `Folder Action` feature.
> ```bash
> echo -e "$prompt\n$(/bin/cat "$schema_path")" | /replace/with/path/to/fabric --output "$output_path/$file_name_no_ext.dbml"
> ```
8. Save the script and give it a name.

Now, whenever you add a file to the folder you attached the script to, it will automatically convert the `sql` schema file to a `dbml` schema file. And output the file using the same name as the input file but with a `.dbml` extension, to a DBML folder in the same directory as the input file.

If you ever want to add the same action to another folder, you can right-click on the folder and follow these steps:

1. Select `Services` from the context menu.
2. Select `Folder Action Setup...`.
![Folder Action Context Menu](/Scripts/Resources/Images/folder_action.png)
3. On the `Confirm Service` dialog box that appears, select `Run Service`.
![Folder Action Confirm Service](/Scripts/Resources/Images/run_service.png)
4. From the `Choose Script to Attach` dialog box, select the folder action you created.
![Folder Action Choose Script](/Scripts/Resources/Images/action_attach.png)


>[!NOTE]
> For both `convert_to_dbml.sh` and `convert_to_dbml_folder_action.sh` if the outputed file is not what you expected you can try tweaking the `prompt` variable in the script. Or if you want you can create your own pattern for `fabric` to use. See [fabric GitHub page](https://github.com/danielmiessler/fabric/tree/main) for more information on how to create your own patterns.
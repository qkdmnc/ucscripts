# Scripts (!! Check with Shellcheck and VM !!)
## Using this repository
1. Clone this repository into any folder(usually the Downloads folder in user's home folder) with `git clone https://github.com/qkdmnc/ucscripts/`
2. Run `cd src`
3. Run the `main.sh` script, answer all of it's prompts and the script will configure a UNIX-like system.
	* On Linux run using: `bash main.sh`
4. Read the output once the script finishes and follow the instructions outlined in it.


## Repository Layout
* `scripts` - the directory containing all of the repository's scripts
	* `main.sh` - the main shell script of this repository which is able to configures different unix systems (e.g. Linux, MacOS)
	* `include/` - all scripts inside this folder are included into `main.sh` and are therefore run from the directory where `main.sh` is located which means that all of the file and directory paths inside them should be relative to `main.sh`
		* `application-configuration/` - directory containing scripts and configuration textfiles to configure the installed applications
		* `system-configuration/` - directory containing scripts and configuration textfiles to configure the system


## Script coding rules
* All scripts should have a comment directly below "#!" describing purpose of the script:
	 * ```
	 	## Script which ...
		(Miss 1 line)
		(Miss 1 line)
	 	<The script code itself>........
	    ```
* All scripts should be compatible with all POSIX shells
	* Always use exclusively ***#! /bin/sh*** as the start of sh scripts.
		* This works on all UNIX systems.
		* This will make shell check verify that syntax of shell script is POSIX compatible.  
* Double quotations should be used around ALL uses (not declarations) of variables:
	* Example: `"${variable}..."`
	* Declarations should not follow the rule: `variable="content"`
* Double quotations should be used around ALL plain text:
	*  Example: `variable="content"`
* All variables inside quotations should be use the `"${}"` syntax
	* Example: `"${variable}..."`
	* Never: `"$variable"
* All keywords such as `then`, which follow statements such as `if`, should be located on the same line as the statement they come after.
	* Examples
		* `if [ -f "${file}" ]; then` 
		* `for file in directory; do`


## Shell Script Checking Algorithm
* [ShellCheck](https://www.shellcheck.net/) - static shell script checker
	* ShellCheck [repository](https://github.com/koalaman/shellcheck)
* In case a ShellCheck warning is CERTAINLY 100% irrelevant, it can be ignored for that one specific instance (not for the entire file with: [ShellCheck Ignoring](https://github.com/koalaman/shellcheck/wiki/Ignore)
	* **ALWAYS** check if the warning is actually totally irrelevant and if it is, have a comment explanation why the warning is irrelvant in that particualr instance on the same line as code, NOT on the same line as the shell check ignore statement.
	* **ALWAYS** REMOVE the ignore statement if the line of code below it was edited or removed.
	* **ALWAYS** check all of the ShellCheck ignroe statements inside the file after it was changed.
	* **NEVER** have the ignore statement on the next line after a "#!" because it will disable all warnings in the [file](https://github.com/koalaman/shellcheck/wiki/Ignore#ignoring-all-instances-in-a-file-044) 
	* The explanations for all ShellCheck suggestions (e.g. SC...) are in ShellCheck [Wiki](https://github.com/koalaman/shellcheck/wiki)
1. Paste `scripts/main.sh` into ShellCheck
2. In the places where other scripts are being included into the `main.sh`, paste these scripts into the ShellCheck instance from the point above
	* Do not remove the `main.sh`'s file inclusion command as it may also contain an error and should be checked
3. Fix ALL errors and warnings and suggestions shown by ShellCheck to the furthest possible extent that does not brake the program in an unfixable way.
	* Make sure that all POSIX non-compliant code suggested by ShellCheck is removed.
4. Clone this repository and then run `scripts/main.sh` on a Linux VM to check if everything that was supposed to be done was done correctly.

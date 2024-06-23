# Scripts
## Using this repository
1. Clone this repository into any folder(usually the Downloads folder in user's home folder) with `git clone https://github.com/qkdmnc/ucscripts/`
2. Run the `main.sh` script and answer all of it's prompts, this script will configure a UNIX-like system.
3. Check if everything `main.sh` prints out in "Done" section of it's output, was done by it.
4. Read and do other recommendations printed out by the `main.sh` script after it has finished.


## Repository Layout
* `scripts` - the directory containing all of the repository's scripts
	* `main.sh` - the main shell script of this repository which is able to configures different unix systems (e.g. Linux, MacOS)
	* `configurators` - directory containing scripts to configure applications
		* All scripts inside this folder are included into `main.sh` and are therefore run from the directory where it is located 
	* `include` - directory containing scripts to configure the system
		* All scripts inside this folder are included into `main.sh` and are therefore run from the directory where it is located  


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
1. Paste `scripts/main.sh` into ShellCheck
2. In the places where other scripts are being included into the `main.sh`, paste these scripts into the ShellCheck instance from the point above
	* Do not remove the `main.sh`'s file inclusion command as it may also contain an error and should be checked
3. Fix ALL errors and suggestions shown by ShellCheck to the furthest possible extent (that does not brake the program).
	* Make sure that all POSIX non-compliant code suggested by ShellCheck is removed
4. Clone this repository and then run `scripts/main.sh` on a Linux VM to check if everything that was supposed to be done was done correctly.

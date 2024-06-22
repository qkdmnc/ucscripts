# Scripts
## Using this repository
1. Clone this repository into any folder(usually the Downloads folder in user's home folder) with `git clone https://github.com/qkdmnc/ucscripts/`
2. Run the `main.sh` script and answer all of it's prompts, this script will configure a UNIX-like system.
3. Check if everything `main.sh` prints out in "Done" section of it's output, was done by it.
4. Read and do other recommendations printed out by the `main.sh` script after it has finished.


## Repository Layout
* `scripts` - the directory containing all of the repository's scripts
	* `main.sh`- the main shell script of this repository which is able to configures different unix systems (e.g. Linux, MacOS)
	* `configurators`- directory containing scripts to configure applications


## Script coding rules
* All scripts should be compatible with all POSIX shells
	* Always use exclusively ***"#! /bin/sh"*** as the start of sh scripts.
		* This works on all UNIX systems.
		* This will make shell check verify that syntax of shell script is POSIX compatible.  
* Double quotations should be used around ALL uses (not declarations) of variables:
	* Example: `"${variable}..."`
	* Declarations should not follow the rule: `variable="content"`
* All variables inside quotations should be use the `"${}"` syntax
	* Example: `"${variable}..."`
	* Never: `"$variable" 
* All scripts should have a comment directly below "#!" describing purpose of the script:
	 * ```
	 	## Script which ...
		(Miss 1 line)
		(Miss 1 line)
	 	<The script code itself>........
	    ```


## Shell Script Checking Algorithm
1. Check all the changed files .sh with [ShellCheck](https://www.shellcheck.net/) and fix errors that show up
	* ShellCheck [developer's website](https://github.com/koalaman/shellcheck)
2. Make sure that all global varibales used by included scripts are present
3. Run the "scripts/main.sh" and any other script that was changed on a Linux VM and check if it does everything it is supposed to and that it does it correctly

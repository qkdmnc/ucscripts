#! /bin/sh
# Main file of the unix configuration scripts in this repository


# Variables
application_list="nano" # firefox - it is not present in this list because it's package name is different on different Linux distributions, so it is installed in the package manager specific section of package_management.sh included in this file
directory_creation_list="${HOME}/git-repos ${HOME}/.iso_images" # list of directories which will be created by this script


## Directories in this repository which are used in this script are being put into variables and checked for existance
include_directory="./include"
[ -d "${include_directory}" ] || exit # here "-d" checks if the directory exists and if it does not, the script finishes(exits)

system_configuration_directory="${include_directory}/system-configuration"
[ -d "${system_configuration_directory}" ] || exit

system_configuration_scriptfiles_directory="${system_configuration_directory}/script-files"
[ -d "${system_configuration_scriptfiles_directory}" ] || exit

system_configuration_textfiles_directory="${system_configuration_directory}/text-files"
[ -d "${system_configuration_textfiles_directory}" ] || exit

application_configuration_directory="${include_directory}/application-configuration"
[ -d "${application_configuration_directory}" ] || exit

application_configuration_textfiles_directory="${application_configuration_directory}/text-files"
[ -d "${application_configuration_textfiles_directory}" ] || exit


## File which will contain the output of this script after it finishes 
script_output_file="./output.txt"



# Script setup
## Get information about the system
### Get the name of the Operating System being used
current_os="none"
case "$(uname -s)" in
	Linux*) current_os="linux" ;;
	Darwin*) current_os="macos" ;;
	*) echo "Script Error: Type of the current UNIX operating system's kernel was not determined by this script, the script will not proceed." ;;
esac

### Get the name of the Desktop Environment being used
current_de="none"
case "${DESKTOP_SESSION}" in
	gnome*) current_de="gnome" ;;
	plasma*) current_de="kde" ;;
 	"") current_de="macos" ;;
	*) echo "Script Error: Desktop environment was not determined by this script, the script will not proceed." ;;
esac

### Get the name of the Package Manager being used
current_pm="none"
dnf --version && current_pm=dnf
apt --version && current_pm=apt
if [ "${current_pm}" = "none" ]; then
	echo "Script Error: Package manager was not determined by this script, the script will not proceed."
fi



# System-specific Configuration
## Include package_management.sh script that is responsible for installing and removing packages or exit if it does not exist
# shellcheck disable=SC1091
. "${system_configuration_scriptfiles_directory}/package_management.sh" || exit # "Not being able to follow the file" is irrelevant and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown


## Include platform/operating system-specific scripts
# shellcheck disable=SC1090
. "${system_configuration_scriptfiles_directory}/${current_os}_config.sh" || exit # "ShellCheck can't follow non-constant source" is irrelevant and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown


## Change the bash shell prompt
if [ "${SHELL}" = "/bin/bash" ]; then
	default_bashrc_file="${HOME}/.bashrc" 
 	custom_bashrc_file="${system_configuration_textfiles_directory}/.bashrc" # file that conatains bash configuration
	touch "${default_bashrc_file}"
	cat "${custom_bashrc_file}" >> "${default_bashrc_file}"
fi



# Cross-platform Configuration
## Create directories
# shellcheck disable=SC2086
mkdir -p ${directory_creation_list} # Double quotes SHOULD NOT be used around $dirs_list because it should expand to multiple directories (seperated by spaces) and not just one and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown


## Run the configuration scripts for some of the installed applications
# shellcheck disable=SC1091
. "${application_configuration_directory}/application-configurator.sh" || exit # "Not being able to follow the file" is irrelevant and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown



# End of script output
## Information outputted to the terminal for the user
clear # clear all of the output of the code above, to not clutter the terminal
echo "
--- Important Information ---
1. This script has finished, reboot the computer to make sure everything works fine
2. After rebooting the computer, go to this directory (src) and follow the instructions displayed after running: cat ${script_output_file}"


## GUI Configurations
if [ "${current_de}" != "none" ]; then
	echo "--- GUI Configuration ---" >> "${script_output_file}"
	cat "${system_configuration_textfiles_directory}/${current_de}-config.md" >> "${script_output_file}"
fi


## Final message
### Message telling the user what was supposed to be done by the script so they make sure it was done
echo "


--- Check if all of these points were done by the script ---
1. All of the following applications were installed by the package manager: ${application_list} vscode
	- No terminal emulator application was installed by this script, the desktop environment's pre-installed terminal emulator application should be used(GNOME terminal on GNOME and Konsole on KDE(and other QT desktop environments)).
	- Some or all applications from the list above might not be installed if APT package manager is used becuase it fails if any package from the list provided to it is missing in it's repositories(for example due to one package in the list having been written incorrectly).
2. Following directories were created: ${directory_creation_list}
3. The following applications were configured: ${configured_application_list}" >> "${script_output_file}"

#### Message specific to systems which utilize bash
if [ "${SHELL}" = "/bin/bash" ]; then
	echo "4. The default bash prompt was changed to a custom one by editing the default value of PS1 using bashrc." >> "${script_output_file}"
fi

#### Message specifc to the systems running linux OS
if [ "${current_os}" = "linux" ]; then
	echo "
-- Points to check that are specific to the installed Operating System, ${current_os} --
1. Default XDG directories (e.g. Music) were moved to a hidden directory inside the user home directory." >> "${script_output_file}"

	if [ "${current_de}" = "gnome ]; then
		echo "2. Desktop envrionment of this system was detected to be GNOME, therefore QEMU and virt manager were not installed as GNOME Boxes could be used for virtualization instead."
  	else
		echo "2. Desktop environment of this system was detected to not be gnome, therefore QEMU and virt manager were installed as GNOME Boxes is not pre-intalled."
	fi
fi

### Message listing the points which the user should do manually
echo "
--- To do manually ---
1. Remove pre-installed applications that will CERTAINLY NOT be required.
	* ONLY remove unneeded GUI applications, NEVER terminal applications or services as their removal could brake the system.
	* ONLY remove these unneeded GUI applications using a GUI package manager (e.g. GNOME Software), not a command line package manager.
	* In most cases, do not remove pre-installed applications.
2. Change browser settings according to configuration MarkDown file
* If the computer contains an NVIDIA GPU, install NVIDIA proprietary drivers for it.


Reboot the computer to make sure all of the settings have been applied." >> "${script_output_file}"

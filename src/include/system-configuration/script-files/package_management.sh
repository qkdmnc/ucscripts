#! /bin/sh
# Includes the code for package managers configuration for main configurations script


# Common Config
application_list="${application_list} curl wget gpg" # add any dependencies(needed for installations not from distribution's repositories, that require files to be donwloaded from the developers website(e.g. vscode)) to the application_list variable to be installed
if [ "${current_de}" = "gnome" ]; then
	application_list="${application_list} gnome-extensions-app" # add applications specific to the GNOME desktop environment to the applications list
fi



# Config for APT
if [ "${current_pm}" = "apt" ]; then
	## Update the Operating System(all packages)
	sudo apt -y update && sudo apt -y upgrade


	## Install applications
 	# shellcheck disable=SC2086
	sudo apt-get -y install ${application_list} # double quotes SHOULD NOT be used around ${application_list} because it should expand to multiple package-names(seperated by spaces) and not just one and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown


	## Install applications with platform specific names
	sudo apt -y install build-essential # install "make" and other GNU developer utilties

	### Install QEMU and Virt manager if GNOME Boxes aren't available (GNOME isn't installed)
	if [ "${current_de}" != "gnome" ]; then
		sudo apt -y install qemu-system virt-manager
	fi


	## Install applications that are absent from distribution's repositories
	### Install VS code - https://code.visualstudio.com/docs/setup/linux
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
	rm -f packages.microsoft.gpg
	sudo apt install apt-transport-https
 	sudo apt update
	sudo apt -y install code


	## Remove the ssh server to disable the ability of remote access to the computer(to prevent malicious unauthorized access)
	sudo apt-get --purge -y remove openssh-server
fi



# Config for DNF
if [ "${current_pm}" = "dnf" ]; then
	## Updating Fedora to a new release
		# Updating Fedora to a new release(e.g. Fedora 35 to F36) without re-installing, official guide - https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-new-release/
			# Updating using CLI, official guide - https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-new-release/#_upgrading_using_the_dnf_system_upgrade_plugin
		# RPM Fusion Third-Party Repository will update automatically and does not require any manualy action to update when moving between Fedora releases
			# Reddit thread 1 - https://www.reddit.com/r/Fedora/comments/lrxvak/rpm_fusion_and_fedora_version_upgrades/
			# Reddit thread 2 - https://www.reddit.com/r/Fedora/comments/bhbrv7/rpmfusion_question/


	## Update the Operating System(all packages)
	sudo dnf -y update


	## Add RPM Fusion repository to the repository list
	sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf -y update


	## Install applications
 	# shellcheck disable=SC2086
	sudo dnf -y install ${application_list} # double quotes SHOULD NOT be used around ${application_list} because it should expand to multiple package-names(seperated by spaces) and not just one and the comment above stops ShellCheck from showing this warning only for this particular line, all other warnings are shown
	

	## Install applications with platform specific names
	sudo dnf -y install @development-tools # install "make" and other GNU utilites

	### Install QEMU and Virt manager if GNOME Boxes aren't available (GNOME isn't installed)
	if [ "${current_de}" != "gnome" ]; then
		sudo dnf -y install @virtualization
	fi


	## Install applications that are absent from distribution's repositories
	### Install VS code - https://code.visualstudio.com/docs/setup/linux
 	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  	# shellcheck disable=SC3037
	echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
 	dnf check-update
	sudo dnf -y install code


 	## Remove the ssh server to disable the ability of remote access to the computer(to prevent malicious unauthorized access)
	sudo dnf -y remove openssh-server
	sudo dnf -y autoremove
fi

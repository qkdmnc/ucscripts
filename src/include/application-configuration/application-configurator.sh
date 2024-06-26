#! /bin/sh
# This shell script file is responsible for applying custom user configuration to applications


# A variable to which each of the configuration blocks below adds the name of the application it configures
configured_application_list=""


# Apply configuration to the Git version control software
if git --version ; then # Make sure that the program exists before trying to configure it
  ## Change the global git name and email
  git config --global user.name "qkdmnc"
  git config --global user.email "qkdmnc"


  ## Add the application's name to the list of configured applications
  configured_application_list="${configured_application_list}git, "
fi




# Apply configuration to the Nano text editor
if nano --version ; then
  ## Make directory for local user's custom nano configuration(nano automatically indexes this directory if it exists)
  mkdir -p "${HOME}/.config/nano"

  
  ## Copy files to the config directory
  cp "${application_configuration_textfiles_directory}/nanorc" "${HOME}/.config/nano"
  
  
  ## Add the application's name to the list of configured applications
  configured_application_list="${configured_application_list}nano, "
fi




# Apply configuration to the Visual Studio Code text editor
if code --version ; then
  ## Install vscode extensions
  ### Extension name format - author.extension(this info is displayed next to extension name on it's store page)
  code --install-extension ms-vscode.cpptools
  code --install-extension ms-python.python
  code --install-extension ms-vscode.hexeditor
  
  
  ## Variable declaration
  vscode_config="${application_configuration_textfiles_directory}/vscode-config.json"
  
  
  ## Change the default .json configuration file of vscode to a custom one and use different file paths depending on the platform(as vscode configuration is located in different directories on different OSs)
  ### To open the json configuration file from Visual Studio Code application itself: VSCode App -> Keyboard shortcut "control" + "P"(On MacOS: command + P) -> Type in the opened prompt ">settings.json" -> Select "Preferences: Open User Settings (JSON)" in the drop-down menu
  if [ "${current_os}" = "linux" ]; then
  	cat "${vscode_config}" > "${HOME}/.config/Code/User/settings.json"
  fi
  
  if [ "${current_os}" = "macos" ]; then
  	cat "${vscode_config}" > "${HOME}/Library/ApplicationSupport/Code/User/settings.json"
  fi
  
  
  ## Output information
  echo "Activity Bar(the one on the left edge of the editor) can't be edited from json and needs to be edited manually: make sure to remove all icons from there except for 'Explorer', 'Search', 'Source Control', 'Extensions'"
  
  
  ## Add the application's name to the list of configured applications
  configured_application_list="${configured_application_list}vscode, "
fi

#! /bin/sh
## Remove default XDG directories ##


xdg_replacement_directory=".std_xdg_dirs" # when changing the name of the directory in this variable, make sure to also change all of it's occurances in ./textfiles/user-dirs.dirs file in this repository
mkdir -p "${HOME}/${xdg_replacement_directory}" # create a directory to move the XDG directories to, so that they do not bloat the /home/[user]

mkdir -p "${HOME}/${xdg_replacement_directory}/Templates" "${HOME}/${xdg_replacement_directory}/Pictures" # for XDG directories that aren't useless in functionality, but still bloat up the home directory, create replacement directories, but put them into a hidden(.) directory instead of the root of home directory(Templates directory is needed so that files could be created from the file manager, Pictures directory is needed so that screenshots aren't thrown into the home directory)
touch "${HOME}/${xdg_replacement_directory}/Templates/file.txt" # create a text file template in Templates directory so that textfiles could be easily created from the file manager without using the command line

rm -rf "${HOME}/Music" "${HOME}/Pictures" "${HOME}/Public" "${HOME}/Templates" "${HOME}/Videos" # remove bloat directories from the root of home directory as they aren't needed or are moved to be in another directory

rm -rf "${HOME}/.config/user-dirs.dirs" # remove the old XDG directory config file
cp "${system_configuration_textfiles_directory}/user-dirs.dirs" "${HOME}/.config/" # move our new XDG directory config file onto the place of the old one

#! /bin/sh
## The script hides default XDG directories (e.g. Music) by moving them from the root of the HOME directory to a hidden dot (.) directory inside the HOME directry. The Desktop, Downloads and Documents directories are not touched


moved_xdg_user_directories_path="${HOME}/${miscellaneous_home_directory}" # path to the directory to which the default XDG directories will be moved in order to be hidden from the root of home directory

mkdir -p "${moved_xdg_user_directories_path}"

mv "${HOME}/Templates/" "${moved_xdg_user_directories_path}" # move the default XDG user Templates folder from the root of home directory to a hidden directory
xdg-user-dirs-update --set TEMPLATES "${moved_xdg_user_directories_path}/Templates/" # change the path for the Templates folder in the ~/.config/user-dirs.dirs configuration file using the xdg-user-dirs-update utility pre-installed on most desktop environments (DO NOT use the xdg-user-dirs-gtk-update)

mv "${HOME}/Public/" "${moved_xdg_user_directories_path}"
xdg-user-dirs-update --set PUBLICSHARE "${moved_xdg_user_directories_path}/Public/"

mv "${HOME}/Music/" "${moved_xdg_user_directories_path}"
xdg-user-dirs-update --set MUSIC "${moved_xdg_user_directories_path}/Music/"

mv "${HOME}/Videos" "${moved_xdg_user_directories_path}"
xdg-user-dirs-update --set VIDEOS "${moved_xdg_user_directories_path}/Videos"

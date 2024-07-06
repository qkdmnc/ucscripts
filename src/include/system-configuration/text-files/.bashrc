# Customizing prompt guide - https://wiki.archlinux.org/title/Bash/Prompt_customization
# Bash escape sequences - https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
# 	\u - current username
# 	\w - current working directories full path (\W displays only the name of working directory, without path)
# 	\[ \] - should be put around a sequence of non-printable characters (any command or escape sequence that does not have output to the terminal, e.g. tput)

# Terminal control
# 	List of all possible terminal attributes - man terminfo
# 	tput [attribute] [optional value to which attribute is set]


# Variables
t_bold="\[$(tput bold)\]"
t_cyan="\[$(tput setaf 6)\]"
t_blue="\[$(tput setaf 4)\]"
t_magenta="\[$(tput setaf 5)\]"
t_reset="\[$(tput sgr0)\]"


# PS1 holds the shell prompt
PS1="${t_bold}${t_cyan}[${t_blue}\u ${t_magenta}\w${t_cyan}]${t_reset} "

# PS2 holds the shell prompt for multi-line commands
PS2="${t_bold}${t_cyan}>${t_reset}"

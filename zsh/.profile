# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Append "$1" to $PATH when not already in.
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# Append our default paths
[ -d "$HOME/bin" ] && append_path "$HOME/bin"
[ -d "$HOME/.local/bin" ] && append_path "$HOME/.local/bin"

# Go (manual installation)
append_path "/usr/local/go/bin"

[ -d "$HOME/.local/bin/zig" ] && append_path "$HOME/.local/bin/zig"


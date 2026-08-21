source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

starship init fish | source

# Wrapper parar repositório ~/.dotfiles
function config
	 git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
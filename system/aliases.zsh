# Some of this file is from original fork and some is from https://raw.github.com/mathiasbynens/dotfiles/master/.aliases

## grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Detect which `ls` flavor is in use
#if ls --color > /dev/null 2>&1; then # GNU `ls`
#  colorflag="--color"
#else # OS X `ls`
#  colorflag="-G"
#fi

# List all files colorized in long format
alias l="ls -lG"

# List all files colorized in long format, including dot files
alias la="ls -laG"

# List only directories
alias lsd='ls -lG | grep "^d"'

# Always use color output for `ls`
alias ls="command ls -G"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get OS X Software Updates, and update Homebrew, and its installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; rvm get head; pushd ~/.vim/bundle/vim-cdadia; git pull; vim +BundleInstall! +qall; vim +PowerlineClearCache +qall; popd'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Trim new lines and copy to clipboard
alias pbcopynn="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# File size
if stat -c '' . > /dev/null 2>&1; then
  # GNU `stat`
  alias fs="stat -c \"%s bytes\""
else
  # OS X `stat`
  alias fs="stat -f \"%z bytes\""
fi

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo =rm -rfv /Volumes/*/.Trashes; sudo =rm -rfv ~/.Trash; sudo =rm -rfv /private/var/log/asl/*.asl"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# System volume stuff
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"
alias dc="docker-compose "
alias dm="docker-machine "
alias doc="docker "
alias containers="doc ps -a"
alias images="doc images"
alias rmimg="doc rmi "
alias doclogs="doc logs -f --tail=500 "
alias dmc="dm create --virtualbox-disk-size '30000' -d virtualbox "
alias dmrm="dm rm "


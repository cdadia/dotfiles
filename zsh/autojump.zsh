if [ -f `brew --prefix`/etc/autojump ]; then
    . `brew --prefix`/etc/autojump
elif [ -f `brew --prefix`/etc/autojump.zsh ]; then
    . `brew --prefix`/etc/autojump.zsh
fi

alias gs='git status -sb'
alias gc='git commit --verbose'
alias gb='git branch'
alias glog='git log --all --decorate --oneline --graph'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

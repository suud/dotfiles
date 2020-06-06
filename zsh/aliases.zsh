alias dev='docker run -v /var/run/docker.sock:/var/run/docker.sock -v "$(pwd)":/app -it --rm suud/dotfiles'
# automatically ls after every cd
function cd {
    builtin cd "$@" && ls
}

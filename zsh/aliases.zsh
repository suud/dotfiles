# automatically ls after every successfull cd:
function cd {
    builtin cd "$@" && ls
}

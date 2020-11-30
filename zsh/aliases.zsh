alias dev='docker run -v /var/run/docker.sock:/var/run/docker.sock -v "$(pwd)":"$(pwd)" -it --rm suud/dotfiles'
alias re-frame='docker run -it --rm -p 127.0.0.1:80:8080 -p 127.0.0.1:8081:8081 -p 127.0.0.1:9630:9630 -p 9000:9000 -v "$(pwd)":/app -w /app suud/cljs bash'
alias reagent='docker run -it --rm -p 127.0.0.1:80:8080 -p 127.0.0.1:9630:9630 -p 9000:9000 -v "$(pwd)":/app -w /app suud/cljs bash'
# automatically ls after every cd
function cd {
    builtin cd "$@" && ls
}

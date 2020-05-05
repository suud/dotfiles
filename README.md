# suud's dotfiles
Simple, yet powerful collection of vim, tmux, and zsh configurations.

## Quickstart
```
# make sure you work on the latest image version
docker pull suud/dev 
# use one of the following commands to run the container
docker run -it --rm suud/dotfiles
docker run -v "$(pwd)":/app -it --rm suud/dotfiles # dev
docker run -v "$(pwd)":/app:ro -it --rm suud/dotfiles # dev-ro
docker run -v "$(pwd)":/app -v ~/.ssh:/root/.ssh:ro -it --rm suud/dotfiles # dev!
docker run -v "$(pwd)":/app:ro -v ~/.ssh:/root/.ssh:ro -it --rm suud/dotfiles # dev-ro!
docker run -v "$(pwd)":/app -v ~/.ssh:/root/.ssh:ro -it suud/dotfiles # dev-persistent!
```


## Custom base image
You can use `docker image ls` to check if you already have an image with the
desired tag. Otherwise try:

```
git clone https://github.com/suud/dotfiles.git
cd dotfiles
vim Dockerfile # change the FROM part in the Dockerfile
docker build -t dotfiles:<custom-tag> .
# run a container from the created image
docker run -it dotfiles:<custom-tag>
```

## Standing on the shoulders of ...
- [Talk: How to Do 90% of What Plugins Do (With Just Vim)](https://youtu.be/XA2WjJbmmoM)

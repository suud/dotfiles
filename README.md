# suud's dotfiles
Simple, yet powerful collection of vim, tmux, and zsh configurations.

## Quickstart
```
# make sure you work on the latest image version
docker pull suud/dev 
### use one of the following commands to run the container ###
## temporary containers ##
docker run -it --rm suud/dotfiles
docker run -v "$(pwd)":/app -it --rm suud/dotfiles # dev
docker run -v "$(pwd)":/app:ro -it --rm suud/dotfiles # dev-ro
# WARNING! The following command mounts your ssh keys into the container!
docker run -v "$(pwd)":/app -v ~/.ssh:/root/.ssh:ro -it --rm suud/dotfiles # dev!
## persistent container ##
docker run -v "$(pwd)":/app -v ~/.ssh:/root/.ssh:ro --name <custom-name> --hostname <custom-name> -it suud/dotfiles
```

## Custom setup

These commands facilitate setting up your environment:

- `setup-git`: Setup your git configuration (Author Name and E-Mail)


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


## Components (taken from [holman/dotfiles](https://github.com/holman/dotfiles))

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `bin/install-dotfiles`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Known Issues
- **There are weird characters on my screen**: Try to install [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#fonts) or run `p10k configure`

## Standing on the shoulders of ...
- [Talk: How to Do 90% of What Plugins Do (With Just Vim)](https://youtu.be/XA2WjJbmmoM)
- [Repo: holman/dotfiles](https://github.com/holman/dotfiles)

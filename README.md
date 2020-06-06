# suud's dotfiles
Simple, yet powerful collection of vim, tmux, and zsh configurations.

## Quickstart
```
# make sure you work on the latest image version
docker pull suud/dev
### use one of the following commands to run the container ###
docker run -it --rm suud/dotfiles
docker run -v /var/run/docker.sock:/var/run/docker.sock \
           -v "$(pwd)":/app \
           -it \
           --rm \
#          -v ~/.ssh:/root/.ssh:ro \
#          --name <custom-name> \
#          --hostname <custom-name> \
           suud/dotfiles
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


## Components (stolen from [holman/dotfiles](https://github.com/holman/dotfiles))

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
- **I have to press ctrl-p twice to make it work**: [remap the docker binding for detaching](https://stackoverflow.com/questions/20828657/docker-change-ctrlp-to-something-else)
- **Something looks strange**: Install iterm2 if you're using macOS. I haven't tested these dotfiles in another terminal emulator.
- **There are weird characters on my screen**: Install [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#fonts) (optional) and run `p10k configure` to fix the zsh theme configuration.

## Standing on the shoulders of ...
- [Talk: How to Do 90% of What Plugins Do (With Just Vim)](https://youtu.be/XA2WjJbmmoM)
- [Repo: holman/dotfiles](https://github.com/holman/dotfiles)
- [Article: Setting up vim as an IDE for Python](https://medium.com/@hanspinckaers/setting-up-vim-as-an-ide-for-python-773722142d1d)

# Rudxain's .files
Prefer `.path` over `.exports` to specify `$PATH`.

You can use `~/.extra` to add custom cmds without forking this entire repo, or to add private data.

You could also use `~/.extra` to override settings, fns, aliases, etc..., essentially treating the repo as a default. It's probably better to [fork this repo](https://github.com/Rudxain/dotfiles/fork) instead

## Install
> [!warning]
> Review the code and remove things you don't want or need.
> 
> My preferences and needs may not align with yours!

### Bootstrap
You can clone the repo however-&-wherever you want. `bootstrap.sh` will pull `main` then copy the files to your `HOME`.

> [!note]
> `bootstrap.sh` depends on `rsync`

```sh
git clone https://github.com/Rudxain/dotfiles.git \
&& cd dotfiles \
&& . bootstrap.sh
```

To update, `cd` into your local `dotfiles` repo and then:
```sh
# safer
. bootstrap.sh
```
alt:
```sh
# avoid confirmation prompt
set -- -f; . bootstrap.sh
```

### Git-less
```sh
cd
curl -#L https://github.com/Rudxain/dotfiles/tarball/main |\
tar -xzv --strip-components 1 --exclude={bootstrap.sh,README.md,LICENSE}
```
To update, just run that cmd again

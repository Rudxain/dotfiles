# Rudxain's .files
Prefer `.path` over `.exports` to specify `$PATH`.

You can use `~/.extra` to add custom cmds without forking this entire repo, or to add private data.

You could also use `~/.extra` to override settings, fns, aliases, etc..., essentially treating the repo as a default. It's probably better to [fork this repo](https://github.com/Rudxain/dotfiles/fork) instead

## Install
> [!warning]
> Review the code and remove things you don't want or need.
> 
> My preferences and needs may not align with yours!

### Script
> [!note]
> `install` depends on `rsync`

`install` will pull the `main` branch, then copy the files to your `HOME`:
```bash
git clone https://github.com/Rudxain/dotfiles.git \
&& cd dotfiles \
&& source install
```

To do a [differential update](https://en.wikipedia.org/wiki/Incremental_backup), `cd` into your local `dotfiles` repo and then:
```bash
# safer
source install
```
alt:
```bash
# avoid confirmation prompt
set -- -f; source install
```

### Min-deps
Portable to almost any environment. See [progress on `wget`](https://github.com/Rudxain/dotfiles/issues/7).

Non-Termux:
```sh
cd
curl -#L https://github.com/Rudxain/dotfiles/tarball/main | \
tar -xzv --strip-components 1 --exclude={.termux,bin/termux-\*,.gitattributes,install,README.md,LICENSE} \
&& . .profile
```

Termux:
```sh
cd
curl -#L https://github.com/Rudxain/dotfiles/tarball/main | \
tar -xzv --strip-components 1 --exclude={.bash_prompt,.gitattributes,install,README.md,LICENSE} \
&& . .profile
```

To update, just run the corresponding cmd again. The downside is that it always downloads the full contents of the this repo, even if no files have changed

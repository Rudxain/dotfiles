# Rudxain's .files
Based on [this](https://github.com/mathiasbynens/dotfiles)

You can use `~/.sh/extra` (POSIX) and `~/.bash_extra` to:
- add custom cmds without forking this entire repo
- add private data
- override settings, fns, aliases, etc..., essentially treating the repo as a default.
	- it's probably better to [fork this repo](https://github.com/Rudxain/dotfiles/fork) instead

## Distro Setup
`setup-env` script isn't necessary, but if you're setting-up a clean install of a Debian-based distro it'll be handy.

I'm considering switching to NixOS, to make this process seamless

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
git clone --depth=1 https://github.com/Rudxain/dotfiles.git \
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
Minimum dependencies. Portable to almost any environment.

Non-Termux:
```sh
cd
wget -qO- https://github.com/Rudxain/dotfiles/tarball/main | \
tar -xzv --strip-components 1 --exclude={.termux,bin/termux-\*,.gitattributes,install,README.md,LICENSE} \
&& . .profile
```

Termux:
```sh
cd
curl -#L https://github.com/Rudxain/dotfiles/tarball/main | \
tar -xzv --strip-components 1 --exclude={.gitattributes,install,README.md,LICENSE} \
&& . .profile
```

To update, just run the corresponding cmd again. The downside is that it always downloads the full contents of this repo, even if no files have changed

## Updates
I reserve the right to edit this repo in **any way** I want. So don't complain about breaking-changes.

After an update happens, you may have some left-over files that are no longer `source`d. So you may need to do manual [GC](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)). I'm sorry :(

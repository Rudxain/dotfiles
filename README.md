# Rudxain's .files
Based on [this](https://github.com/mathiasbynens/dotfiles)

You can use `~/.sh/ext` ([POSIX](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html)) and `~/.bash_ext` to:
- add custom cmds without forking this entire repo
- add private data
- override settings, fns, aliases, etc..., essentially treating the repo as a default.
	- it's probably better to [fork this repo](https://github.com/Rudxain/dotfiles/fork) instead

## Install
> [!warning]
> Review the code and remove things you don't want or need.
>
> My preferences and needs may not align with yours!

### Script
```bash
git clone https://github.com/Rudxain/dotfiles \
&& cd dotfiles \
&& source ./install.sh
```

To do a [differential update](https://en.wikipedia.org/wiki/Incremental_backup), `cd` into your local `dotfiles` repo and then:
```bash
# safer
source ./install.sh
```
alt:
```bash
# avoid confirmation prompt
set -- -f; source ./install.sh
```

### Min-deps
Minimum dependencies. Portable to almost any environment.

```sh
cd
wget -qO- https://github.com/Rudxain/dotfiles/tarball/main | \
tar -xzv --strip-components 1 '--exclude={.gitattributes,install.sh,README*,LICENSE}' \
&& \. .profile
```

To update, just run the corresponding cmd again. The downside is that it always downloads the full contents of this repo, even if no files have changed

## Updates
I reserve the right to edit this repo in **any way** I want (including Git history, for now). So don't complain about breaking-changes.

After an update happens, you may have some left-over files

# Rudxain's .files

<div align=center><img src=icon.svg width=50% height=50%></div>

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don't want or need. Don't blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository however-&-wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.

```sh
git clone https://github.com/Rudxain/dotfiles.git && cd dotfiles && . bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```sh
. bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```sh
set -- -f; . bootstrap.sh
```

### Git-less install

To install these dotfiles without `git`:

```bash
cd
curl -#L https://github.com/Rudxain/dotfiles/tarball/main |\
tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE}
```

To update later on, just run that command again.

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature-testing takes place.

Here's an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```sh
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without forking

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don't want to commit to a public repository.

You could also use `~/.extra` to override settings, functions, and aliases from my dotfiles repository. It's probably better to [fork this repository](https://github.com/Rudxain/dotfiles/fork) instead, though.

## Author

| [![twitter/mathias](http://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](http://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](https://mathiasbynens.be/) |

## Thanks to…

* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Cătălin Mariș](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](https://butt.zone/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* Lauri ‘Lri' Ranta for sharing [loads of hidden preferences](https://web.archive.org/web/20161104144204/http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](https://matijs.brinkhu.is/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](https://sindresorhus.com/)
* [Tom Ryder](https://sanctum.geek.nz/) and his [dotfiles repository](https://sanctum.geek.nz/cgit/dotfiles.git/about)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles)
* [Haralan Dobrev](https://hkdobrev.com/)
* Anyone who [contributed a patch](https://github.com/mathiasbynens/dotfiles/contributors) or [made a helpful suggestion](https://github.com/mathiasbynens/dotfiles/issues)

### Pre-requirements

The following is installed:

- Git / Git Bash
- AutoHotkey
- GVim
- Vim

I recommend using [scoop](https://scoop.sh/) for the installations.

In an **elevated** PowerShell prompt add the `extras` bucket:

```
scoop bucket add extras
```

Then install the necessary software:

```
scoop install git autohotkey-installer vim
```

### Config files setup

Clone the repository in the home directory:

```sh
git clone https://github.com/HerCerM/vmc.git "$HOME/vmc"
```

Run the setup script:

```
sh -- $HOME/vmc/setup.sh
```


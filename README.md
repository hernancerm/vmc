### Pre-requirements

The following is installed:

- Git / Git Bash
- AutoHotkey
- GVim
- Vim

I recommend using [scoop](https://scoop.sh/) for the installations.

After installing scoop, user **PowerShell** to install the necessary software:

```
scoop install git vim
```

For AutoHotkey, I recommend using the installer from their website:

<https://www.autohotkey.com/download/ahk-install.exe>

### Config files setup

Using **Git Bash**, clone the repository in the home directory:

```sh
git clone https://github.com/HerCerM/vmc.git "$HOME/vmc"
```

Run the setup script:

```
sh -- $HOME/vmc/setup.sh
```


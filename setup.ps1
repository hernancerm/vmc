# Setup minimal Vim and gVim configuration. 
#
# Before running, make sure to set the execution policy to unrestricted:
# set-executionPolicy -scope currentUser unrestricted

# Install scoop, if the scoop command is not available.
function has-command {
  param(
    [string] $command
  )
  if (get-command "$command" -errorAction silentlyContinue) { 
    return $true
  }
  return $false
}
if (-not (has-command 'scoop')) {
  irm get.scoop.sh | iex
}

# Install initial software.
scoop install git sudo vim

# Install AutoHotkey, will open UAC prompt.
scoop bucket add extras
sudo scoop install autohotkey-installer

# Install Iosevka Nerd Font.
scoop bucket add nerd-fonts
scoop install Iosevka-NF-Mono

# Clone vmc repository, if not already cloned.
function has-file {
  param(
    [string] $filepath
  )
  if (get-item "$filepath" -errorAction silentlyContinue) { 
    return $true
  }
  return $false
}
$vmc = "$HOME\vmc"
if (-not (has-file "$vmc")) { 
  git clone https://github.com/HerCerM/vmc.git "$vmc"
}

# Symlink configuration files.
function create-symbolic-link {
  param (
    [string] $link,
    [string] $target
  )
  # Remove conflicting file, if any.
  remove-item -path "$link" -errorAction silentlyContinue
  sudo new-item -path "$link" -itemType symbolicLink -value "$target"
}
# Vim configuraton files.
create-symbolic-link -link "~\_vimrc" -target "$vmc\_vimrc"
create-symbolic-link -link "~\_gvimrc" -target "$vmc\_gvimrc"
# AutoHotkey script file.
$startup = "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
create-symbolic-link -link "$startup\vmc.ahk" -target "$vmc\vmc.ahk"

# Start AutoHotkey script without blocking the interactive shell session.
start-job -scriptBlock { autohotkey "$HOME\vmc\vmc.ahk" }


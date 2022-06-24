# Setup minimal Vim and gVim configuration. 
#
# Before running, make sure to set the execution policy to unrestricted:
# set-executionPolicy -scope currentUser unrestricted

function has-admin-privilege {
  $identity = [system.security.principal.windowsIdentity]::getCurrent()
  $principal = new-object system.security.principal.windowsprincipal($identity)
  $admin_role = [system.security.principal.windowsBuiltInRole]::administrator
  if ($principal.isInRole($admin_role)) {
    return $true
  }
  else {
    return $false
  }
}

if (-not (has-admin-privilege)) {
  write-error "Please run the script in a session with admin privileges"
  exit 1
}

# Pick the user to use for the script and set the 'chosen home'.
$user = read-host -prompt `
    "Which user do you want to configure? (leave blank to use '$env:username')"
if (-not $user) {
  $user = $env:username
}
# Verify chosen user exists.
$user_list = (get-localUser).name
if (-not $user_list.contains($user)) {
  write-error "The user '$user' does not exist."
  exit 1
}
$chome = "C:\Users\$user"

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
scoop install git vim

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
$vmc = "$chome\vmc"
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
  new-item -path "$link" -itemType symbolicLink -value "$target"
}
# Vim configuraton files.
create-symbolic-link -link "$chome\_vimrc" -target "$vmc\_vimrc"
create-symbolic-link -link "$chome\_gvimrc" -target "$vmc\_gvimrc"
# AutoHotkey script file.
$startup = "$chome\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
create-symbolic-link -link "$startup\vmc.ahk" -target "$vmc\vmc.ahk"


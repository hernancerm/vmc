### Installation

Open a PowerShell console with **administrator priviliges**, and change the execution policy:

```text
set-executionPolicy -scope currentUser unrestricted
```

Run the installation script:

```text
irm https://raw.githubusercontent.com/HerCerM/vmc/main/setup.ps1 | iex
```
Install AutoHotkey (AHK) using the installer from the website. Use 'Express Installation'.

https://www.autohotkey.com/download/ahk-install.exe

Having now AHK installed, you can double click the script `vmc.ahk` to start it. After you reboot your PC, the `vmc.ahk` script will start automatically on every system boot, so no need to double click the AHK script again.

### After installation

I recommend to set back the execution policy to its default value:

```text
set-executionPolicy -scope currentUser restricted
```

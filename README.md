### Installation

Open a PowerShell console with **administrator priviliges**, and change the execution policy:

```text
set-executionPolicy -scope currentUser unrestricted
```

Run the installation script:

```text
irm https://raw.githubusercontent.com/HerCerM/vmc/main/setup.ps1 | iex
```

### After installation

I recommend to set back the execution policy to its default value:

```text
set-executionPolicy -scope currentUser restricted
```

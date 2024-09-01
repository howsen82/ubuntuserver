# Locating PowerShell Core Group Policy Tenplate
Get-ChildItem -Path $PSHOME -Filter *Core*Policy*

# Install PowerShell Core Group Policy templates
$PSHOME\InstallPSCorePolicyDefinitions.ps1

# The Group Policy templates for PowerShell Core will be installed, and you can access them by navigating to the following:
# Computer Configuration | Administrative Templates | PowerShell Core
# User Configuration |Administrative Templates | PowerShell Core
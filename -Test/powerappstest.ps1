

Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber

Save-Module -Name Microsoft.PowerApps.Administration.PowerShell -Path
Import-Module -Name Microsoft.PowerApps.Administration.PowerShell
Save-Module -Name Microsoft.PowerApps.PowerShell -Path
Import-Module -Name Microsoft.PowerApps.PowerShell


Add-PowerAppsAccount
$pass = ConvertTo-SecureString "passwordtest" -AsPlainText -Force
Add-PowerAppsAccount -Username admin -Password $pass


Get-AdminFlow ""



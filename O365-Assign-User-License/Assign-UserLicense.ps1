Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Used to connect to O365 servers and give license to end users
"@
Write-host $desc -ForegroundColor DarkCyan

#Installing modules
Install-Module -Name MSOnline
Install-Module -Name AzureAD

#starting connection
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential -credential "admin@domain.com.br"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Connect to Office 365
Connect-MsolService -Credential $UserCredential
get-mailbox -ResultSize 2

#Retrieve a list of your Licensing Plans
Get-MsolAccountSku

#Connect-MSOLService

$output = ".\LOG-LicenseAssigned$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
add-content $output -Value "UPN;USAGELOCATION;SKU;LICENSES"
$users = import-csv ".\users.csv"
foreach ($user in $users){
  $upn=$user.UPN
  $usagelocation= "BR"
  $SKU="reseller-account:STANDARDPACK"
  Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation
  Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
  $INFO = Get-Msoluser -UserPrincipalName $upn | Select-Object UserPrincipalName, usagelocation, licenses
  write-host $info.UserPrincipalName, $info.UsageLocation, $info.Licenses
  Add-Content $output -value "$upn; $USAGELOCATION; $SKU"
} 
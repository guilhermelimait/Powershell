Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Use it to connect to O365 servers
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

Import-Module ExchangeOnlineManagement
$UserCredential = Get-Credential -credential "user@domain.com"
Connect-ExchangeOnline -Credential $UserCredential -ShowProgress $true

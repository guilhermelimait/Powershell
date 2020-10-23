Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Set SIP to end user
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

import-csv '.\inputusers.csv' -delimiter ','| foreach{
	$user = $_.user
	$sip = $_.sip
	$primary = $_.primary
	
	Write-host $user, $sip, $primary
	Set-QADObject $user -ObjectAttribute @{'msRTCSIP-PrimaryUserAddress' = "SIP:$sip"} 					#WORKING

}
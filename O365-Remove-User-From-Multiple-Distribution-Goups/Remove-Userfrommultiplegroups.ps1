Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Remove user from multiple distribution groups
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$DGs= Get-DistributionGroup *
foreach( $dg in $DGs){
	Remove-DistributionGroupMember $dg -Member "user@domain.com"
}

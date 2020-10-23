Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Get all distribution groups a user is member of
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Groups=@()
$User = get-mailbox "user1@domain.com"
Get-DistributionGroup | foreach {
	$dg = $_.Name
	Get-DistributionGroupMember $dg -resultsize unlimited| foreach {if ($_.identity -eq $User) {$Groups += $DG} 
	}
}
$Groups



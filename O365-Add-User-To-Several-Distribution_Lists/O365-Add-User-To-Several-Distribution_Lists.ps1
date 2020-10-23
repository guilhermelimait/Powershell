Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add user to multiple distribution lists from an external list with automapping disabled
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$dls = Import-csv ".\distributionlists.csv"
$user = "user@domain.com"
$total = $dls.count
$count = 0
write-host "+ Adding user $user to Distribution lists:"

$dls | foreach {
	$dl = $_.dl
	$count = $count + 1
	write-host -background Black -foreground White "-   Giving permissions to" $dl  -nonewline
	Add-MailboxPermission -Identity $dl -User $user -AccessRights FullAccess -AutoMapping:$false
	write-host -background Black -foreground GREEN "| FullAccess SUCCESS! " -nonewline
	Add-RecipientPermission $dl -AccessRights SendAs -Trustee $user -confirm:$false
	write-host -background Black -foreground GREEN "| SendAs SUCCESS! |" 
	}
Write-host
Write-host -foreground white "+ User was added successfully on "  -nonewline
Write-host -foreground red $count -nonewline
Write-host -foreground white " of " -nonewline
Write-host -foreground red $total -nonewline
Write-host -foreground white " Dl's"
Write-host

Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : 
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$users = @(
	"user1@domain.com",
	"user2@domain.com",
	"user3@domain.com",
	"user4@domain.com"
)

foreach ($user in $users){
	$user2 = $user + ":\calendario"
	$before = get-mailboxfolderpermission $user2
	Set-MailboxFolderPermission -Identity "Mailbox:\Calendar" -User Default -AccessRights AvailabilityOnly
	Set-MailboxFolderPermission -Identity "Mailbox:\Calendar" -User Anonymous -AccessRights None
	$after =  get-mailboxfolderpermission -Identity $user2
	Write-host -foreground red "Permissions before"
	Write-host $before
	Write-host -foreground green "Permissions later"
	Write-host $later
}
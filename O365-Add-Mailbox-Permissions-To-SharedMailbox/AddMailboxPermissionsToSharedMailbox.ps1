Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add multiple users with full and send access to a shared mailbox
"@
Write-host $desc -ForegroundColor DarkCyan
Write-host "  > Press [ENTER] to continue" -foreground DarkYellow
Read-host

$mailboxes = @(
	"user1@domain.com",
	"user2@domain.com",
	"user3@domain.com",
	"user4@domain.com",
	"user5@domain.com"
)

$sharedmailbox = "shared.mailbox@domain.com"

foreach ($mailbox in $mailboxes){
	Add-MailboxPermission -Identity $mailbox -User $sharedmailbox -AccessRights FullAccess -AutoMapping:$true
	Add-RecipientPermission $mailbox -AccessRights SendAs -Trustee $sharedmailbox -confirm:$false
}
 

Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Remove the option to automap shared mailboxes informed in the array
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

# Insert the shared mailboxes to remove the automap
$mailboxes = @(
	"sharedmailbox1@domain.com",
	"sharedmailbox1@domain.com",
	"sharedmailbox1@domain.com",
	"sharedmailbox1@domain.com",
	"sharedmailbox1@domain.com"
)

$user = "user1@domain.com"
foreach ($mailbox in $mailboxes){
	Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
	}

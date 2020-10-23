Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Remove the option to automap shared mailboxes informed to the users in the array
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Users = @(
	"user1@domain.com",
	"user2@domain.com",
	"user3@domain.com",
	"user4@domain.com",
	"user5@domain.com"
)


$Mailbox = "sharedmailbox@domain.com"
foreach ($user in $users){
	Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
	}

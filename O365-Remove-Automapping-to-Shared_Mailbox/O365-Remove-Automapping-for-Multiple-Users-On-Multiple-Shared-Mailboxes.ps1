
$desc = @"

DEVELOPED BY : Guilherme Lima
PLATFORM     : O365
WEBSITE      : http://solucoesms.com.br
WEBSITE2     : http://github.com/guilhermelimait
LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
DESCRIPTION  : Remove the option to automap shared mailboxes informed in the array

"@
Write-host $desc

$Users = @(
	"user1@domain.com",
	"user2@domain.com",
	"user3@domain.com"
)

$SharedMailbox = @(
	"sharedmailbox1@domain.com",
	"sharedmailbox2@domain.com",
	"sharedmailbox3@domain.com"
)

foreach ($mailbox in $SharedMailbox){
	foreach ($user in $users){
		Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
		Add-RecipientPermission $mailbox -AccessRights SendAs -Trustee $user -confirm:$false
	}
}
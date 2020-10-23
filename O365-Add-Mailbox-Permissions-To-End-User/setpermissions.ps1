Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add user mailbox permissions
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Mailbox = "user1@domain.com"

$users = Import-csv .\input.csv
Foreach ($user in $users) {
	#write-host $m.name
	add-MailboxPermission $mailbox -User $user -AccessRights FullAccess
	add-RecipientPermission $mailbox -AccessRights SendAs -Trustee $user
	}
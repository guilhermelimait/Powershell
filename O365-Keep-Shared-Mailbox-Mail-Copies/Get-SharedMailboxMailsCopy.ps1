
Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Export if MessageCopyForSendOnBehalfEnabled is enabled to the mailbox
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$mailboxes = @(
	"sharedmailbox1@domain.com",
	"sharedmailbox2@domain.com",
	"sharedmailbox3@domain.com",
	"sharedmailbox4@domain.com"
)

foreach ($mailbox in $mailboxes){
	Get-Mailbox $mailbox | select primarysmtpaddress, messagecopy* # -MessageCopyForSendOnBehalfEnabled $true
}
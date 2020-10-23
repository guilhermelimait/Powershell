Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Export all messages sent/received between two inserted dates
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Input = ".\users.csv"
$output = new-item -type file -name "FinalReport-$(get-date -f MM-dd-yyyy_HH_mm_ss).csv"
add-content "mail, DeliverToMailboxAndForward, ForwardingAddress, ForwardingSmtpAddress" -path $output

import-csv $Input | foreach {
	$mail = $_.mail
	$result = get-mailbox $mail | select DeliverToMailboxAndForward, ForwardingAddress, ForwardingSmtpAddress
	add-content "$mail, $result.DeliverToMailboxAndForward, $result.ForwardingAddress, $result.ForwardingSmtpAddress" -path $output
	write-host "User: " $mail "has as forwading address: " $result.ForwardingSmtpAddress " configured."
	Set-Mailbox $mail -ForwardingSmtpAddress $null -ForwardingAddress $null
	#rite-host "Forwarding address disabled for the user"
}

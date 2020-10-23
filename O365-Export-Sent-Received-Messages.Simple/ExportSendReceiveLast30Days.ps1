Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Export all messages sent/received between two inserted dates
		The list of users must be UNICODE with "mail" on the first line
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

[Int] $intSent = $intRec = $Sent = $received = 0
$datestart = (get-date).adddays(-30)
$dateend = (get-date -f yyyy-MM-dd)

$Input =import-csv ".\inputlist.csv"
$output = new-item -type file -name "FinalReport-$(get-date -f MM-dd-yyyy_HH_mm_ss).csv"

add-content "mail, datestart, dateend, Sent, Received" -path $output

$input | foreach{
	$mail = $_.mail
	Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Sent++ }
	Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Received++ }

	add-content  "$mail, $datestart, $dateend, $Sent, $Received" -path $output
	$sent = $received = 0
}

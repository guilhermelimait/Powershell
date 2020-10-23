<#
  .DEVELOPED BY: 
    Guilherme Lima
  .PLATFORM:
    O365
  .WEBSITE:
    http://solucoesms.com.br
  .LINKEDIN:
    https://www.linkedin.com/in/guilhermelimait/
  .DESCRIPTION:
	Export all messages sent/received between two inserted dates
	The list of users must be UNICODE with "mail" on the first line
#>

[Int] $intSent = $intRec = $Sent = $received = 0
#$datestart = (get-date).adddays(-3)
$datestart = (get-date).addhours(-24)
$dateend = (get-date -format "yyyy-MM-dd hh:mm")

$Input = import-csv ".\inputlist.csv"
$output = new-item -type file -name "FinalReport-$(get-date -f MM-dd-yyyy_HH_mm_ss).csv"

add-content "mail; datestart; dateend; Sent; Received" -path $output

$input | foreach{
	$mail = $_.mail
	Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Sent++ }
	Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Received++ }

	add-content  "$mail; $datestart; $dateend; $Sent; $Received" -path $output
	$sent = $received = 0
}

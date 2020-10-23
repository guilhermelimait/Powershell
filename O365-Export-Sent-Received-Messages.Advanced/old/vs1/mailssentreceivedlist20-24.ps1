<#
 .DEVELOPED BY: 
  Guilherme Lima
 .PLATFORM:
  O365
 .WEBSITE:
  http://solucoesms.com.br
 .LINKEDIN:
  https://www.linkedin.com/in/guilhermelimait/
  https://github.com/guilhermelimait/Powershell/blob/master/O365-Export-Sent-Received-Messages-Count-From-Users-List
 .DESCRIPTION:
	Export all messages sent/received between two inserted dates and report sent via email
	The list of users must be UNICODE with "mail" on the first line

#>

# Variables / Time slot configuration

[Int] $intSent = $intRec = $Sent = $received = 0

$datestart = ([DateTime]::Today.AddDays(-1).AddHours(22)).tostring("yyyy-MM-dd HH:mm")
$dateend = ([DateTime]::Today.AddDays(-1).AddHours(23).addminutes(59)).tostring("yyyy-MM-dd HH:mm")

$Input =import-csv ".\inputlist.csv"
$output = new-item -type file -name "MonitoringReport-$(get-date -f yyyy.MM.ddTHH.mm.ss).csv"
add-content "Mail; DateStart; DateEnd; Sent; Received" -path $output

$total = $input.count
Write-host
Write-host -foreground white "+ Monitoring time slot between: " -nonewline
Write-host -foreground red $datestart -nonewline
Write-host -foreground white " and " -nonewline
Write-host -foreground red $dateend
Write-host -foreground white "+ Users found in file: " -nonewline
Write-host -foreground red $total 
Write-host -foreground white "+ Starting message trace..."
Write-host

# Message trace 

$count = 0
$input | foreach{
	$count = $count + 1
	$mail = $_.mail
	Write-host -foreground white "  - Executing message trace on "-nonewline
	Write-host -foreground red $count -nonewline
	Write-host -foreground white " of " -nonewline
	Write-host -foreground red $total -nonewline
	Write-host -foreground white " users. User analyzed: " -nonewline
	Write-host -foreground red $mail -nonewline
	Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Sent++ }
	Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Received++ }
	add-content "$mail; $datestart; $dateend; $Sent; $Received" -path $output
	Write-host -foreground green " SUCCESS!"
	$sent = $received = 0
}
Write-host
Write-host -foreground white "+ The report was executed successfully on "  -nonewline
Write-host -foreground red $count -nonewline
Write-host -foreground white " of " -nonewline
Write-host -foreground red $total -nonewline
Write-host -foreground white " users"
Write-host
Write-host -foreground White "+ Sending report..." -nonewline

# Send mail information
<#
$param = @{
	SmtpServer = 'BHZ-APP-SMTP01.bms.com.br'
	From = 'noreply@arcelormittal.com'
	To = 'guilherme.lima@wipro.com', 'RASHEED.KHAN-PARTNER@ARCELORMITTAL.COM'
	Subject = "Monitoring Report from " + $datestart + " to " + $dateend
	Body = "Hi,<br /> Please check the report from <b> " + $datestart + "</b> to <b>" + $dateend + "</b> in attachment <br /> Report generated automatically in " + $total + " users." 
	Attachments = $output
}
Send-MailMessage @param -bodyashtml
#>

Write-host -foreground Green " SUCCESS!"
Write-host 
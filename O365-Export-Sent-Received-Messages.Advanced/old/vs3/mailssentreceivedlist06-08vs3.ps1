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
cls 
# Import modules
#import-module msonline
#connect-msolservice 

# Variables / Time slot configuration

[Int] $intSent = $intRec = $Sent = $received = 0
$datestart = (get-date '06:00').tostring("yyyy-MM-dd HH:mm")
$dateend = (get-date '08:00').tostring("yyyy-MM-dd HH:mm")

# Move old files, create new report
write-host -foreground white "+ Old file renamed"
$curDateTime = Get-Date -Format yyyyMMdd-HHmmss
Get-ChildItem $Path "MonitoringReport06h-08h.csv" -Recurse | Rename-Item -NewName {$_.Basename + '_' + $curDateTime + $_.Extension }
write-host -foreground white "- File renamed successfully!"
Move-Item "MonitoringReport06h-08h*" -Destination .\06h-08h\
write-host -foreground white "- File moved corredtly to .\06h-08h\"

$output = new-item -type file -name "MonitoringReport06h-08h.csv"
$Input = import-csv ".\inputlist.csv"
add-content "Department; Country; City; DateStart; DateEnd; Sent; Received" -path $output

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
	#$department = get-aduser $mail -properties * | select-object -expandproperty department
	#$city = get-aduser $mail -properties * | select-object -expandproperty city
	$UPN = get-mailbox $mail | select-object -expandproperty UserPrincipalName
	$department = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty department
	$city = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty city
	$country = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty country
	add-content "$department; $country; $city; $datestart; $dateend; $Sent; $Received" -path $output
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

$param = @{
    SmtpServer = 'smtpserver.domain.com'
    From = 'noreply@domain.com'
    To = 'admin1@domain.com', 'admin2@domain.com'
    Subject = "Monitoring Report from " + $datestart + " to " + $dateend
    Body = "Hi,<br /> Please check the report from <b> " + $datestart + "</b> to <b>" + $dateend + "</b> in attachment <br /> Report generated automatically in " + $total + " users." 
    Attachments = $output
}

#Send-MailMessage @param -bodyashtml
Write-host -foreground Green " SUCCESS!"
Write-host 
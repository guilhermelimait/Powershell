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
import-module msonline
connect-msolservice 

# Variables

[Int] $intSent = $intRec = $Sent = $received = 0

$day = get-date | select-object -expandproperty day
$month = get-date | select-object -expandproperty month
$year = get-date | select-object -expandproperty year
<#
# Move old files, create new report
write-host -foreground White "+ Old file renamed"
$curDateTime = Get-Date -Format yyyyMMdd-HHmmss
Get-ChildItem $Path "MonitoringReport00h-06h.csv" -Recurse | Rename-Item -NewName {$_.Basename + '_' + $curDateTime + $_.Extension }
write-host -foreground White "- File renamed successfully!"
Move-Item MonitoringReport00h-06h* -Destination .\00h-06h\
write-host -foreground White "- File moved corredtly to .\00h-06h\"
#>

$output = ".\MonitoringReport20h-0h.csv"
$fileexist = $false
Write-host
Write-host "+ Verifying Input and Report existence..."
Write-host
do{
  if (Test-Path -path $output) { 
    Write-host "  - File " -nonewline
	Write-host $output -foreground Red -nonewline
	Write-host " found!"
	$fileexist = $true
  } else {
	$file = new-item -type file -name $output -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
	add-content "Department; Country; City; DateStart; DateEnd; Sent; Received; ReportYear; ReportMonth; ReportDate" -path $output -WarningAction silentlycontinue -ErrorAction silentlycontinue
	Write-host "  - File " -nonewline
	Write-host $output -foreground Red -nonewline
	Write-host " created successfully!"
	$fileexist = $true
  }
}until ($fileexist = $true)

$Input = import-csv ".\inputlist.csv"
$total = $input.count
Write-host -foreground White "  - Users found in file: " -nonewline
Write-host -foreground Green $total 


# Message trace 
for (($x = 8); $x -gt 1; ($x--),($y--)){

	$datestart = ([DateTime]::Today.AddDays(-$x).AddHours(20)).tostring("yyyy-MM-dd HH:mm")
	$dateend = ([DateTime]::Today.AddDays(-$x).AddHours(23).addminutes(59)).tostring("yyyy-MM-dd HH:mm")
	#$datestart = ([DateTime]::Today.AddDays(-$x).AddHours(00)).tostring("yyyy-MM-dd HH:mm")
	#$dateend = ([DateTime]::Today.AddDays(-$y).AddHours(23).addminutes(59)).tostring("yyyy-MM-dd HH:mm")
	#$datestart = (get-date '00:00').tostring("yyyy-MM-dd HH:mm")
	#$dateend = (get-date '06:00').tostring("yyyy-MM-dd HH:mm")
	Write-host
	Write-host -foreground White "+ Starting message trace..."
	Write-host
	Write-host -foreground White "  - Monitoring time slot between: " -nonewline
	Write-host -foreground Green $datestart -nonewline
	Write-host -foreground White " and " -nonewline
	Write-host -foreground Green $dateend
	
	$count = 0
	$input | foreach{
		$count = $count + 1
		$mail = $_.mail
		Write-host -foreground White "  - Executing message trace on "-nonewline
		Write-host -foreground Green $count -nonewline
		Write-host -foreground White " of " -nonewline
		Write-host -foreground Green $total -nonewline
		Write-host -foreground White " users. User analyzed: " -nonewline
		Write-host -foreground red $mail -nonewline
		Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Sent++ }
		Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | ForEach { $Received++ }
		$UPN = get-mailbox $mail | select-object -expandproperty UserPrincipalName -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		;#$userinfo = get-msoluser -UserPrincipalName $UPN | select-object @{L='department'; E={@($_.department) -join ";"}}, @{L='city'; E={@($_.city) -join ";"}}, @{L='country'; E={@($_.country) -join ";"}} -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		#$userinfo = get-msoluser -UserPrincipalName $UPN | select-object department, city, country -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		$department = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty department -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		$city = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty city -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		$country = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty country -WarningAction silentlycontinue -ErrorAction silentlycontinue -InformationAction silentlycontinue
		add-content "$department; $country; $city; $datestart; $dateend; $Sent; $Received; $year; $month; $year " -path $output
		Write-host -foreground Green " SUCCESS!"
		$sent = $received = 0
	}
}

Write-host
Write-host -foreground White "  - The report was executed successfully on " -nonewline
Write-host -foreground Green $count -nonewline
Write-host -foreground White " of " -nonewline
Write-host -foreground Green $total -nonewline
Write-host -foreground White " users"
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
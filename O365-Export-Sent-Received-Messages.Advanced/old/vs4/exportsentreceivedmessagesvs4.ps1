cls

<#===========================================

     connecting the powershell to o365
	 
===========================================#>

Function ConnectToO365 {
	$credential = Get-Credential
	Connect-MsolService -Credential $credential
	Connect-EXOPSSession -UserPrincipalName "admin@domain.com"
	import-module msonline
}

#ConnectToO365
cls
write-host

<#===========================================

     importing data and starting gathering
	 
===========================================#>


[Int] $lastread = $count = $intSent = $intRec = $Sent = $received = 0
[Int] $sent00h06h = $received00h06h = $sent06h08h = $received06h08h = $sent08h18h = $received08h18h = $sent18h20h = $received18h20h = $sent20h22h = $received20h22h = $sent22h24h = $received22h24h = 0

$Input = ".\validatedusers.csv"

import-csv $Input -delimiter ";"| ForEach {
	$mail = $_.mail
	$ID = $_.ID
	$UPN = get-mailbox $mail | select-object -expandproperty UserPrincipalName
	$country = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty country
	$city = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty city
	$department = get-msoluser -UserPrincipalName $UPN | select-object -expandproperty department

	# gathering data for the last 7 days

	for (($day = 8); ($day -gt 1); ($day--)){
		$outputname = get-date ([DateTime]::Today.AddDays(-$day)).tostring("yyyy-MM-dd") -Format "yyyy-MM-dd"
		$output = ".\$outputname-24h.csv"
		$fileexist = $false

		#checking file existence

		do{
		    if (Test-Path -path $output) {
		        $fileexist = $true
				break
			} else {
				write-host " + Checking file $output existence ..." -foreground darkcyan
				write-host "  - File $output created successfully" -foreground yellow
			    new-item -type file -name $output |out-null
		        write-host 
			    add-content $output -value "ID; Mail; Country; City; Department; sent00h06h; received00h06h; Sent06h08h; Received06h08h; Sent08h18h; Received08h18h; Sent18h20h; Received18h20h; Sent20h22h; Received20h22h; Sent22h24h; Received22h24h" 
			    $fileexist = $false
		    }
	    }until ($fileexist = $true)
		
		# starting to gather the user data
		
		write-host " + Gathering data from user: $mail" -foreground darkcyan
		write-host "  > Start Date to End Date [ Sent | Received ]" -foreground yellow
		for (($lastread -eq 0); ($lastread -lt 6); ($lastread++)){
			Function 00h06h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(00)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(06)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:sent00h06h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received00h06h++}
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent00h06h | $received00h06h ]"
			}
				
			Function 06h08h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(06)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(08)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach{$script:sent06h08h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received06h08h++}
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent06h08h | $received06h08h ]"
			}
			
			Function 08h18h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(08)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(18)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:sent08h18h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received08h18h++}
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent08h18h | $received08h18h ]"
			}
			
			Function 18h20h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(18)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(20)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:sent18h20h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received18h20h++}
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent18h20h | $received18h20h ]"
			}
			
			Function 20h22h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(20)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(22)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:sent20h22h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received20h22h++}
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent20h22h | $received20h22h ]"
			}

			Function 22h24h{
				$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours(22)).tostring("yyyy-MM-dd HH:mm")
				$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours(23).addminutes(59)).tostring("yyyy-MM-dd HH:mm")
				Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:sent22h24h++}
				Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$script:received22h24h++} 
				write-host "  - Data from " -nonewline
				write-host $datestart -nonewline -foreground cyan
				write-host " to " -nonewline
				write-host $dateend -nonewline -foreground cyan
				write-host " [ $sent22h24h | $received22h24h ]"
			}
			
			Function Writelog {
				add-content $output -value "$ID; $mail; $country; $city; $department; $sent00h06h; $received00h06h; $Sent06h08h; $Received06h08h; $Sent08h18h; $Received08h18h; $Sent18h20h; $Received18h20h; $Sent20h22h; $Received20h22h; $Sent22h24h; $Received22h24h"
			}
			
			switch -wildcard ($lastread){
				"0"{ 00h06h }
				"1"{ 06h08h }			
				"2"{ 08h18h }
				"3"{ 18h20h }
				"4"{ 20h22h }			
				"5"{ 22h24h }			
			}
		}
		write-host 
		Writelog #This function will create one file per day
		[Int] $sent00h06h = $received00h06h = $sent06h08h = $received06h08h = $sent08h18h = $received08h18h = $sent18h20h = $received18h20h = $sent20h22h = $received20h22h = $sent22h24h = $received22h24h = 0
		$lastread = 0 #need to be executed after the loop to guarantee that $lastread is = 0 and that it will run again for the remaining users
	} 
	#write-host Reconnection to O365 count: $count, users executed: $id -foreground yellow
	write-host
	if ($count -gt 40){
		ConnectToO365 # funcao
		$count = 0
	}
	$count +=1
}

<#===========================================

     sending reports via email
	 
===========================================#>
Write-host -foreground Darkcyan " + Sending Mail results..."

$param = @{
    SmtpServer = 'smtpserver.domain.com'
    From = 'noreply@domain.com'
    To = 'admin1@domain.com', 'admin2@domain.com'
    Subject = "Monitoring Report from " + $datestart + " to " + $dateend
    Body = "Hi,<br /> Please check the report from <b> " + $datestart + "</b> to <b>" + $dateend + "</b> in attachment <br /> Report generated automatically in " + $total + " users." 
    Attachments = $output
}

#Send-MailMessage @param #-bodyashtml
Write-host "  - Mail sent successfully!"
Write-host 
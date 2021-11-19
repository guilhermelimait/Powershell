$exporteddata = ".\exporteddata.csv"
$validatedusers = ".\validatedusers.csv"

[int] $LastIdFromExportedData = import-csv $exporteddata -delimiter ";" | select-object -expandproperty id -last 1 
$CountValidatedUsers = (get-content ".\validatedusers.csv").count -1
$x = $LastIdFromExportedData
write-host $LastIdFromExportedData, $CountValidatedUsers

[Int] $CountSentMessages = $CountReceivedMessages = 0


function MessageInfo5 ($texto1, $texto2, $texto3, $texto4, $texto5, $color) {
	write-host "$texto1"-foreground white -nonewline
	write-host "$texto2"-foreground darkcyan -nonewline	
	write-host "$texto3"-foreground white -nonewline
	write-host "$texto4"-foreground darkcyan -nonewline
	write-host "$texto5"-foreground white
	}

$day = 2
for ($x -eq $LastIdFromExportedData; $x -lt $CountValidatedUsers; $x++){ #vai da ultima linha lida até o fim do arquivo input
	[string] $mail = import-csv $validatedusers -delimiter ";"| Select -Index $x | Select-Object -ExpandProperty mail
	$index = $x+1
	write-host "$index $mail" -foreground darkcyan
	Function GetMessageCount ($StartHour, $StartMinute, $EndHour, $EndMinute){
		[Int] $CountSentMessages = $CountReceivedMessages = 0
		$script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours($StartHour).addminutes($StartMinute)).tostring("yyyy-MM-dd HH:mm")
		$script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours($EndHour).addminutes($EndMinute)).tostring("yyyy-MM-dd HH:mm")
		Get-MessageTrace -senderaddress $mail -startdate $datestart -enddate $dateend | foreach {$CountSentMessages++}
		Get-MessageTrace -recipientaddress $mail -startdate $datestart -enddate $dateend | foreach {$CountReceivedMessages++}
		MessageInfo5 " - Data from " "$datestart" " to " "$dateend" " [ $CountSentMessages | $CountReceivedMessages ]"
	}
	
	GetMessageCount 00 00 06 00 
	GetMessageCount 06 00 08 00 
	GetMessageCount 08 00 18 00 
	GetMessageCount 18 00 20 00 
	GetMessageCount 20 00 22 00 
	GetMessageCount 22 00 23 59
	
}

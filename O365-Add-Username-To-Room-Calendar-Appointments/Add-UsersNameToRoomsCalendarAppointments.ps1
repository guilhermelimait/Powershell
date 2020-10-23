Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add users to appointment names in rooms calendar
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$rooms = @(
  "room1@domain.com",
  "room2@domain.com",
  "room3@domain.com"
)

write-host -foreground White "+ CalendarProcessing options are:" -nonewline
write-host -foreground Green " Mail, AddOrganizerToSubject, DeleteComments, DeleteSubject"
write-host
foreach ($room in $rooms){
	Set-CalendarProcessing -Identity $room -AddOrganizerToSubject $true -DeleteComments $false -DeleteSubject $false
	$info = get-calendarprocessing -Identity $room | select AddOrganizerToSubject,  DeleteComments, DeleteSubject
	$info2 = get-mailbox $room | select primarysmtpaddress
	write-host -foreground white "  -" $info2.primarysmtpaddress -nonewline
	write-host -foreground Green " " $info.AddOrganizerToSubject,  $info.DeleteComments, $info.DeleteSubject
}
write-host


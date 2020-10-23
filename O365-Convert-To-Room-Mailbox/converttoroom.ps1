Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Convert the mailbox to room mailbox in batch
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$rooms = get-content ".\rooms.csv"
foreach ($room in $rooms) {  
	get-mailbox $room.room
	write-host $room.room
	Set-Mailbox $room.room -Type room
} 

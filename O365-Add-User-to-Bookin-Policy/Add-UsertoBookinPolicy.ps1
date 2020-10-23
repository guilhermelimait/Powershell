Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add user to the bookInPolicy keeping the existent users
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

function Add-CalendarBookInPolicy ($roomName, $newUser) {
  $bookInPolicy = (Get-CalendarProcessing -Identity $roomName).BookInPolicy
  $bookInPolicy += $newUser
  Set-CalendarProcessing -Identity $roomName -BookInPolicy $bookInPolicy
}

Add-CalendarBookInPolicy -Identity $Roomname "meetingroom@domain.com" -newUser "user@domain.com"

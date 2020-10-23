$desc = @"

  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add user to the bookInPolicy keeping the existent users

"@
Write-host $desc

$room = "room@domain.com"
$users =  @(
  "user1@domain.com",
  "user2@domain.com",
  "user3@domain.com",
  "user4@domain.com"
)

function Add-CalendarBookInPolicy {
  Param($roomName, $newUser)
  $bookInPolicy = (Get-CalendarProcessing -Identity $roomName).BookInPolicy
  $bookInPolicy += $newUser
  Set-CalendarProcessing -Identity $roomName -BookInPolicy $bookInPolicy -ForwardRequestsToDelegates $false -AllBookInPolicy $false
}

foreach($user in $users){
  Add-CalendarBookInPolicy -Roomname $room -newUser $user
}

Get-CalendarProcessing $room | Select-Object -ExpandProperty bookInPolicy
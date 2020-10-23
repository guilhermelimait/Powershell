$desc = @"

DEVELOPED BY : Guilherme Lima
PLATFORM     : O365
WEBSITE      : http://solucoesms.com.br
WEBSITE2     : http://github.com/guilhermelimait
LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
DESCRIPTION  : Add rooms to a Teams Group and add the Organizer

"@
Write-host $desc

$group = "Teams Group Name"
$rooms = @(
	"room1@domain.com",
	"room2@domain.com",
	"room3@domain.com",
	"room4@domain.com"
)

foreach ($room in $rooms){
	Add-DistributionGroupMember -Identity $group -Member "user1@domain.com"
}
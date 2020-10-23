Clear-Host
$desc = @"

  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Validate if the users informed in file exists in O365

"@
Write-host $desc

<#===========================================

  VARIABLES
  
===========================================#>

$InputFile = ".\INPUT-list.csv"
$OutputValidUsers = ".\LOG-ValidUsers.csv"
$OutputInvalidUsers = ".\LOG-InvalidUsers.csv"

<#===========================================

  FUNCTIONS
  
===========================================#>

function MessageInfo3 ($texto1, $texto2, $texto3, $color) {
	write-host "$texto1"-foreground white -nonewline
	write-host "$texto2"-foreground $color -nonewline
	write-host "$texto3"-foreground white
}

function MessageInfo1 ($texto1, $color) {
	write-host "$texto1" -foreground $color
}

function FileExistence ($InputFile) {
	do {
		if (Test-Path -path $InputFile) {
			MessageInfo3 "  - File " "$InputFile" " found successfully" "cyan"
			$InputFileexist = $true
			break
		} else {
			MessageInfo1 "  - File $InputFile not found ..." "Red"
			MessageInfo3 "  - File " "$InputFile" " created succesfully" "cyan"
			new-item -type file -name $InputFile | out-null
			$InputFileexist = $false
		}
	}until ($InputFileexist = $true)
}
	
<#===========================================

  FILE MANAGEMENT
  
===========================================#>

write-host
MessageInfo1 " + Checking file existence ..." "DarkCyan"

remove-item $OutputValidUsers, $OutputInvalidUsers -erroraction SilentlyContinue

FileExistence $InputFile
FileExistence $OutputValidUsers
FileExistence $OutputInvalidUsers

<#===========================================

  GENERAL STATUS
  
===========================================#>

$x = $y = 0
$global:erroraction = 'stop'

$size = (get-content $InputFile).count - 1
$InputFileexist = $false

add-content $OutputValidUsers -value "Id; mail"
add-content $OutputInvalidUsers -value "Id; mail"

<#===========================================

  USERS VERIFICATION
  
===========================================#>

write-host
MessageInfo1 " + Starting mailbox existence verification ..." "DarkCyan"

import-csv $InputFile | foreach {
	$mail = $_.mail	 
	try {
		Get-mailbox -Identity $mail -erroraction 'stop' | Out-Null
		$x += 1
		MessageInfo3 "  - " "[V]" " ID [$x] - $mail exists." "green"
		add-content $OutputValidUsers -value "$x; $mail"
	} catch { 
		$y += 1
		MessageInfo1 "  - [F] ID [$y] - $mail not found!" "Red"
		add-content $OutputInvalidUsers -value "$y; $mail"
	} 
}

<#===========================================

  RESULTS
  
===========================================#>
 
write-host
MessageInfo1 " + Results ..." "DarkCyan"
MessageInfo1 "  - [$size] Mailboxes informed in file		[$InputFile]" "white"
MessageInfo1 "  - [$x] Mailboxes were found successfully	[$OutputValidUsers]" "green"
MessageInfo1 "  - [$y] Mailboxes not found			[$OutputInvalidUsers]" "red"
write-host
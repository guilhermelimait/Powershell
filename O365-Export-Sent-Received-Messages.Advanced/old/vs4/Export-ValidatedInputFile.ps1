<#===========================================

  VARIABLES
  
===========================================#>

$file = ".\inputlist-test.csv"
$validfile = ".\validatedusers.csv"
$invalidfile = ".\notfoundusers.csv"

<#===========================================

  FUNCTIONS
  
===========================================#>

function MessageInfo3 ($texto1, $texto2, $texto3, $color) {
	write-host "$texto1"-foreground white -nonewline
	write-host "$texto2"-foreground $color -nonewline
	write-host "$texto3"-foreground white
	}

function MessageInfo1 ($texto1, $color){
	write-host "$texto1" -foreground $color
}

function FileExistence ($file){
	do{
		if (Test-Path -path $file) {
			MessageInfo3 "  - File " "$file" " found successfully" "cyan"
			$fileexist = $true
			break
		} else {
			MessageInfo1 "  - File $file not found ..." "Red"
			MessageInfo3 "  - File " "$file" " created succesfully" "cyan"
			new-item -type file -name $file |out-null
			$fileexist = $false
		}
	}until ($fileexist = $true)
}
	
<#===========================================

  FILE MANAGEMENT
  
===========================================#>

clear-host
write-host
MessageInfo1 " + Checking file existence ..." "DarkCyan"

remove-item $validfile, $invalidfile

FileExistence $file
FileExistence $validfile
FileExistence $invalidfile

<#===========================================

  GENERAL STATUS
  
===========================================#>

$x = $y = 0
$global:erroraction = 'stop'

$size = (get-content $file).count -1
$fileexist = $false

add-content $validfile -value "ID; mail"
add-content $invalidfile -value "ID; mail"

<#===========================================

  USERS VERIFICATION
  
===========================================#>

write-host
MessageInfo1 " + Starting mailbox existence verification ..." "DarkCyan"

import-csv $file | foreach {
	$mail = $_.mail	 
	try {
		Get-mailbox -Identity $mail -erroraction 'stop' | Out-Null
		$x +=1
		MessageInfo3 "  - " "[V]" " ID [$x] - $mail exists." "green"
		add-content $validfile -value "$x; $mail"
	} 
	catch { 
		$y += 1
		MessageInfo1 "  - [F] ID [$y] - $mail doesn't exist!" "Red"
		add-content $invalidfile -value "$y; $mail"
	} 
}

<#===========================================

  RESULTS
  
===========================================#>
 
write-host
MessageInfo1 " + Results ..." "DarkCyan"
MessageInfo1 "  - [$size] Mailboxes informed in file $file" "white"
MessageInfo1 "  - [$x] Mailboxes were found successfully." "green"
MessageInfo1 "  - [$y] Mailboxes doesn't exist." "red"
write-host

FUNCTION MessageInfo3 ($text1, $text2, $text3, $color) {
	write-host "$text1"-foreground White -nonewline
	write-host "$text2"-foreground $color -nonewline	
	write-host "$text3"-foreground White
}

FUNCTION MessageInfo5 ($text1, $text2, $text3, $text4, $text5, $color) {
	write-host "$text1"-foreground Cyan -nonewline
	write-host "$text2"-foreground $color -nonewline	
	write-host "$text3"-foreground Cyan -nonewline
	write-host "$text4"-foreground $color -nonewline
	write-host "$text5"-foreground Cyan
}

FUNCTION menu {
    HEADER  " + Choose an option:"
    MessageInfo3 "  [ 1 ] " "- Connect to O365 using MFA" "" "Cyan"
    MessageInfo3 "  [ 2 ] " "- Connect to O365 standard" "" "Cyan"
    MessageInfo3 "  [ 3 ] " "- Exit" "" "Cyan"
	Write-host
	$a = Read-host 
	switch($a){
		1 { um }
		2 { dois }
		3 { exit }
	}
}

FUNCTION menuEnd {
	Write-host " > Process completed, press [ENTER] to continue..." -foreground Green
	read-host 
	menu
}

FUNCTION menuEndNO {
	Write-host " > Process canceled, press [ENTER] to continue..." -foreground Red
	read-host 
	menu
}

FUNCTION HEADER ($FUNCTION){
	cls
	write-host 
	write-host " + Exchange Management Tool 1.0 : $env:username" -foreground DarkCyan
	write-host 
	Write-host "$Function " -foreground Cyan
	Write-host
}

FUNCTION CONTINUE (){	
    write-host -nonewline " > Continue? (Y/N) "
    $response = read-host
    if ( $response -ne "Y" ) { menuEndNO }
    else { menuEnd }
}


FUNCTION um {
	cls
	HEADER " + Connecting to O365 using MFA"
	$useradmin = Read-host "Insert your admin user:"
    $SessionOption = New-PSSessionOption -IdleTimeout "43200000"
    Connect-ExchangeOnline -UserPrincipalName $useradmin -psSessionOption $SessionOption
    menu
}

FUNCTION dois {
	cls
    HEADER " + Connecting to O365 using Standard"
	Set-ExecutionPolicy RemoteSigned
	$useradmin = Read-host "Insert your admin user:"
    $UserCredential = Get-Credential $useradmin
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
	Import-PSSession $Session
	Read-Host
    menu
}

FUNCTION tres {
	cls
	exit
}

cls
menu
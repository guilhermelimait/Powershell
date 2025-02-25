$Messagebody = @"

Report Information:

	Users informed for LH activation : 1
	Users validated to LH activated  : 2
	Users not found or without E3 lic: 3
	Time Execution                   : 4

"@
cls
write-host $Messagebody



$messagebody2 = 'a', 'b', 'c'

foreach ($m in $messagebody2){
	Write-Host $m
}

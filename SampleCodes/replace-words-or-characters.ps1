$output = ".\file.txt"
(get-content $output) | foreach-object {
	$_ -replace '"','' `
	-replace '@{PrimarySmtpAddress=','' `   #replace the text "@{PrimarySmtpAddress=" by "empty"
	-replace ' LitigationHoldEnabled=','' ` #replace the text " LitigationHoldEnabled=" by "empty"
	-replace '}','' `			#replace the text "}" by "empty"
	} | set-content $output
$inputcontent = select-string -pattern "\w" -path $output | foreach-object{$_.line}
$inputcontent | set-content $output

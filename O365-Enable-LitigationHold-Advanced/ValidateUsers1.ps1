Clear-Host
$desc = @"

  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Convert the mailbox to room mailbox in batch

"@
Write-host $desc

del ".\litigationusers.csv"
$output = ".\litigationusers.csv"
new-item -type file -name $output | out-null
$input = get-content ".\inputlist.csv"
$count = 0
$total = ($input).Length

$users = $input
foreach ($user in $users) {
	$count += 1
	$smtp = get-mailbox $user | select-object -ExpandProperty primarysmtpaddress 
	write-host "  [$count] of [$total] - $smtp"
	"$user" | add-content $output
} 

(get-content $output) | foreach-object { 
	$_ -replace '"','' `
	-replace '@{primarysmtpaddress=','' `
	-replace '}','' `
	} | set-content $output

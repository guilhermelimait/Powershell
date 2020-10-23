$desc = @"

DEVELOPED BY : Guilherme Lima
PLATFORM     : O365
WEBSITE      : http://solucoesms.com.br
WEBSITE2     : http://github.com/guilhermelimait
LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
DESCRIPTION  : Convert mailbox informed in file to shared mailbox

"@
Write-host $desc

$input = ".\shared.csv"
$shareds = import-csv $input
$total = ((Get-Content $input).length -1)
$count = 1

write-host $total "itens found on file $input" -foreground green
foreach ($shared in $shareds) {
	Write-host Starting convertion of item $count of $total
	Set-Mailbox $shared.shared -Type shared
	Write-host $shared.shared -nonewline -foreground yellow
	Write-host " converted successfully!" -foreground green  
	$count += 1
} 

#$shared = "sharedmailbox@domain.com"
#Set-User -Identity $shared -LinkedMasterAccount $null
#Set-Mailbox $shared -Type shared
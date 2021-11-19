$desc = @"

DEVELOPED BY : Guilherme Lima
PLATFORM     : O365
WEBSITE      : http://solucoesms.com.br
WEBSITE2     : http://github.com/guilhermelimait
LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
DESCRIPTION  : Export from .\distributiongroup.csv who have permissions to send messages to.

"@
Write-host $desc

#Path files that will be used in this script
$input = ".\distributiongroup.csv"
$output = ".\distributiongrouppermissions $(get-date -f yyyy-MM-dd_HH_mm_ss).csv"

#Enabling Litigation Hold on each user
add-content $output -value "displayname; PrimarySmtpAddress; acceptmessagesonlyfrom"
$DGS = get-content $input

Foreach ($DG in $DGS) {
Get-DistributionGroup $DG | select-object displayName, PrimarySmtpAddress, @{Name="AcceptMessagesOnlyFrom";Expression={[string]::join(";",$_.AcceptMessagesOnlyFrom)}} | export-csv $output -appendget 
	}

#Remove the unnecessary characters on file
$LineCount = 0
(get-content $output) | foreach-object {
	$_ -replace '"','' `
	-replace '@{displayname=','' `
	-replace ' PrimarySmtpAddress=','' `
	-replace ' acceptmessagesonlyfrom=','' `
	-replace '}','' `
	} | set-content $output
$inputcontent = select-string -pattern "\w" -path $output | foreach-object{$_.line}
$inputcontent | set-content $output

#Send mail information
$body = get-content($Output) -delimiter "\n"
$param = @{
    SmtpServer = 'mail.domain.com'
    From = 'distributiongrouppermissions@domain.com'
    To = 'admin1@domain.com'
    Subject = 'Distribution Group Permissions'
    Body = $body
    Attachments = $output
}

Send-MailMessage @param

$desc = @"

  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Validate the users and enable the litigation hold to identified users

"@
Write-host $desc

#Path files that will be used in this script
$input = ".\litigationusers.csv"
$output = ".\LHreport $(get-date -f yyyy-MM-dd_HH_mm_ss).csv"

#Enabling Litigation Hold on each user
add-content $output -value "PrimarySmtpAddress; LitigationHoldEnabled"

write-host
write-host -foreground Yellow "+  Reading info from INPUT file... " -nonewline

$users = get-content $input
$Total = $users.count
$count = 0

write-host -foreground Green " DONE!"
write-host
write-host -foreground Yellow "+  Number of users found... " -nonewline
write-host -foreground Green $Total

Foreach ($user in $users) {
	$count = $count + 1
	get-mailbox $user -includeinactivemailbox 
	write-host -foreground Yellow "  - [$count of $total] Enabling Litigation hold to: " $user -nonewline
	Set-Mailbox $user -LitigationHoldEnabled $true -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -InactiveMailbox 
	write-host -foreground GREEN " DONE!" 	
	Get-Mailbox $user | select-object PrimarySmtpAddress, LitigationHoldEnabled | add-content $output
	}

write-host
write-host -foreground Yellow "+ Exporting results ... " -nonewline
write-host -foreground Green " DONE!"

#Remove the unnecessary characters on file
(get-content $output) | foreach-object {
	$_ -replace '"','' `
	-replace '@{PrimarySmtpAddress=','' `
	-replace ' LitigationHoldEnabled=','' `
	-replace '}','' `
	} | set-content $output
$inputcontent = select-string -pattern "\w" -path $output | foreach-object{$_.line}
$inputcontent | set-content $output

write-host
write-host -foreground Yellow "+ Sending results ... " -nonewline

#Send mail information
$body = get-content($Output) -delimiter "\n"
$param = @{
    SmtpServer = 'mailserver.domain.com'
    From = 'litigationhold@domain.com'
    To = 'admin1@domain.com', 'admin2@domain.com', 'admin3@domain.com'
    Subject = 'Litigation Hold Report'
    Body = $body
    Attachments = $output
}

Send-MailMessage @param -bodyashtml
write-host -foreground Green " DONE!"


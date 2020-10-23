
###### CREATE PASS ENCRYPTED FILE ######
#Run the following command in powershell to generate password's encrypted file
#read-host -prompt "Enter password to be encrypted in PW_O365.txt" -assecurestring | convertfrom-securestring | out-file "$PSScriptRoot\PW_EXO.txt"
$mypass = cat "$PSScriptRoot\PW_EXO.txt" | ConvertTo-SecureString
$msolcred = New-Object -typename System.Management.Automation.PSCredential -argumentlist "sa_admin@services.mittalco.com",$mypass
#Connect-AzureAD -Credential $msolcred

$ExecPolicy = Get-ExecutionPolicy
write-host "Setting Execution Policy to RemoteSigned..."
Set-ExecutionPolicy RemoteSigned -Force

write-host "Connecting to Exchange Online..."
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $msolcred -Authentication Basic -AllowRedirection

write-host "Importing Modules..."
Import-PSSession $Session


$StartDate = (get-date -format "HH:mm:ss")
Clear-Host

$desc = @"

  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Validate the users and enable the litigation hold to identified users

"@
Write-host $desc

# Validation

Write-host " + Verifying user existence in O365 ..." -foreground Darkcyan
Write-host
Remove-Item ".\litigationusersvalidated.csv" -Force

$inputlist = import-csv "C:\Scripts\O365-LitigationHold\Automation_v2\LHMSOLine\Logs\Success\litigationusers.csv" -Delimiter ";"
$output = ".\litigationusersvalidated.csv"
new-item -type file -name $output | out-null
$count = 0
$total = ($inputlist).Length
foreach ($upn in $inputlist) {
	$UPN = $upn.userprincipalname
	$count += 1
	$smtp = get-mailbox $UPN | select-object -ExpandProperty primarysmtpaddress -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
	write-host "  [$count] of [$total] - $smtp"
	"$UPN" | add-content $output
} 
(get-content $output) | foreach-object { 
	$_ -replace '"','' `
	-replace '@{primarysmtpaddress=','' `
	-replace '}','' `
	} | set-content $output

# End validation

$InputFile = ".\litigationusersvalidated.csv"
$MailboxFound = ".\LOG-MailboxFound $(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
$MailboxNotFound = ".\LOG-MailboxNOTFound $(get-date -f yyyy-MM-dd_HH_mm_ss).csv"

$size = 60000
$count = $Userinfo = 0
$users = get-content $InputFile
$total = $users.Length

function MessageInfo1 ($text1, $color) {
	write-host "$text1" -foreground $color
}

function MessageInfo3 ($text1, $text2, $text3, $color) {
	write-host "$text1"-foreground white -nonewline
	write-host "$text2"-foreground $color -nonewline
	write-host "$text3"-foreground white
}

function MessageInfo4 ($text1, $text2, $text3, $text4, $color) {
	write-host "$text1"-foreground white -nonewline
	write-host "$text2"-foreground $color -nonewline
	write-host "$text3"-foreground white -nonewline
	write-host "$text4"-foreground green
}

function FileExistence ($typefile, $file, $header){
	write-host
	MessageInfo1 " + Locating $typefile file..." Darkcyan
	do{
		if (Test-Path -path $file) {
			MessageInfo3 "  - File " "$file" " found." "cyan"
			$fileexist = $true
			break
		} else {
			MessageInfo1 "  - File $file not found ..." "Red"
			MessageInfo3 "  - File " "$file" " created succesfully." "cyan"
			new-item -type file -name $file |out-null
			add-content $file -value $header
			$fileexist = $false
		}
	}until ($fileexist = $true)
}

MessageInfo1 " + Starting Litigation Hold activation ..." "Darkcyan"

#FileExistence "log" $InputFile ""
FileExistence "log" $MailboxFound "USER; ISINACTIVEMAILBOX; SIZEQUOTA; ACTIVE"
FileExistence "log" $MailboxNotFound "USER; ISINACTIVEMAILBOX; SIZEQUOTA"
write-host
MessageInfo1 " + Verifying Licensing ..." "Darkcyan"
write-host

foreach ($user in $users){ #verifica se o usuario tem licenciamento baseado no tamanho da quota aplicada
	$count += 1
	$Userinfo = Get-Mailbox $user | Select-object -property IsInactivemailbox, primarysmtpaddress, @{Name="prohibitsendquota";expression={[math]::Round(($_.prohibitsendquota.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}}
	[int]$UserSize = $Userinfo.prohibitsendquota
	$UserInactivemailbox = $Userinfo.IsInactivemailbox
	$UserSMTP = $Userinfo.primarysmtpaddress

	if ($UserSize -gt $size){ #tem licenciamento
		if ($UserInactivemailbox = "$false") { #mailbox ativa
			Set-Mailbox $user -LitigationHoldEnabled $true -WarningAction SilentlyContinue -ErrorAction SilentlyContinue #-InactiveMailbox 
			$active = get-mailbox $user | select-object -expandproperty LitigationHoldEnabled -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
			add-content $MailboxFound -value "$user; $UserInactivemailbox; $Usersize; $active"
			MessageInfo4 "  [$count] of [$total] - Mailbox in Active mode   | " "$UserSMTP " "| E3 Found | " "$active" "cyan"
		} else {
			Set-Mailbox $user -LitigationHoldEnabled $true -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -InactiveMailbox 
			$active = get-mailbox $user | select-object -expandproperty LitigationHoldEnabled -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
			add-content $MailboxFound -value "$user; $UserInactivemailbox; $Usersize; $active"
			MessageInfo4 "  [$count] of [$total] - Mailbox in Inactive mode | " "$UserSMTP " "| E3 Found | " "$active" "red"
		}
	} else {
		MessageInfo1 "  [$count] of [$total] - Mailbox not found | $UserSMTP | E3 NOT FOUND $usersize" "red"
		add-content $MailboxNotFound -value "$user; $UserInactivemailbox; $Usersize"
	}	
}

write-host
write-host -foreground DarkCyan "+ Sending results ... " -nonewline

$CountFoundUsers = (get-content $MailboxFound).count -1
$CountNotFoundUsers = (get-content $MailboxNotFound).count -1

$EndDate = (get-date -format "HH:mm:ss")
$TimeDiff = New-Timespan -Start $StartDate -End $EndDate

$Messagebody = @"

Report Information:

	Users informed for LH activation : $total
	Users validated to LH activated  : $CountFoundUsers
	Users not found or without E3 lic: $CountNotFoundUsers
	Time Execution                   : $TimeDiff

"@

write-host $messagebody
$param = @{
    SmtpServer = '192.168.0.1'
    From = 'litigationhold@domain.com'
    To = 'admin1@domain.com', 'admin2@domain.com', 'admin3@domain.com'
    Subject = 'Litigation Hold Report - Brazil'
    Body = $MessageBody
    Attachments = $MailboxNotFound, $MailboxFound 
}

Send-MailMessage @param -bodyashtml
write-host -foreground Green " + DONE!"

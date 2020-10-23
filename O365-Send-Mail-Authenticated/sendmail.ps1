Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Send an authenticated mail over the Microsoft 365
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

# Sender and Recipient Info
$MailFrom = "user1@domain.com"
$MailTo = "user2@domain.com"

# Sender Credentials
$Username = "user1@domain.com"
$Password = "password"

# Server Info
$SmtpServer = "smtp.office365.com"
$SmtpPort = "587"

# Message stuff
$MessageSubject = "mail test - 15:27" 
$Message = New-Object System.Net.Mail.MailMessage $MailFrom,$MailTo
$Message.IsBodyHTML = $true
$Message.Subject = $MessageSubject
$Message.Body = @'
<!DOCTYPE html>
<html>
<head>
</head>
<body>
This is a test message to trigger an ETR.
</body>
</html>
'@

# Construct the SMTP client object, credentials, and send
$Smtp = New-Object Net.Mail.SmtpClient($SmtpServer,$SmtpPort)
$Smtp.EnableSsl = $true
$Smtp.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
$Smtp.Send($Message)
write-host "message sent" -ForegroundColor yellow
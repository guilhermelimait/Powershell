$Username = "from@domain.com";
$Password= "senha!";

function Send-ToEmail([string]$email){

    $message = new-object Net.Mail.MailMessage;
    $message.From = $Username;
    $message.To.Add($email);
    $message.Subject = "Mail test";
    $message.Body = "Hi! This is a mail test";

    write-host "attaching"
    $file = "C:\temp\filetest.csv"
    $att = new-object Net.Mail.Attachment($file)
    $message.Attachments.Add($file)
	
    write-host "New smtp"
    $smtp = new-object Net.Mail.SmtpClient("mail.dominio.com.br", "587"); 
    $smtp.EnableSSL = $false;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);

    write-host "New send"
    $smtp.send($message);
    write-host "Pre dispose"
    $att.Dispose()
    write-host "Mail Sent" ; 
 }
 
Send-ToEmail  -email "destiny@domain.com";

exit 1
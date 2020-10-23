$body = get-content($Output) -delimiter "\n"
$param = @{
    SmtpServer = 'smtp-server.dominio.com'
    From = 'report@dominio.com'
    To = 'user1@domain.com', 'user2@domain.com', 'user3@domain.com'
    Subject = 'Litigation Hold Report'
    Body = $body
    Attachments = $output
}

Send-MailMessage @param

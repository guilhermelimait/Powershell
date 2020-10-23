Clear-Host
Write-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : Web
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : URL Availability Tool
"@
Write-host $desc -ForegroundColor DarkCyan

[array]$SiteLinks = "https://nullaostalavoro.dlci.interno.it/Ministero/Index2", "https://nullaostalavoro.dlci.interno.it"
#[array]$SiteLinks = "http://solucoesms.com.br", "http://solucoesms.com.br/teste"

function sendmail {
    $SmtpServer = 'mail.domain.com'
    $EmailFrom = 'user1@domain.com'
    $EmailTo = 'user2@domain.com'
    $Subject = $title
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
    $SMTPClient.EnableSsl = $true 
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential("user1@domain.com", "password"); 
    #$Body = ""
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
}

foreach($url in $SiteLinks) {
    try {
        Write-Host 
        Write-host "  + Starting verification on: " -ForegroundColor Yellow -NoNewline
        Write-host $url -ForegroundColor White
        $checkConnection = Invoke-WebRequest -Uri $url -UseBasicParsing
        if ($checkConnection.StatusCode -eq 200) {
            Write-Host "  - The website is online! " -ForegroundColor Green
            $title = "200 - $url"
            #sendmail
        }   
    } catch [System.Net.WebException] {
        $exceptionMessage = $Error[0].Exception
        if ($exceptionMessage -match "503") {
            Write-Host "Server is too busy to reply" -ForegroundColor Red
            $title = "503 - $url"
        } elseif ($exceptionMessage -match "404") {
            Write-Host "  - Page Not found" -foreground Red
            $title = "404 - $url"
        }
    }sendmail
}

Write-Host
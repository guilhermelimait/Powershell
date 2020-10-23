Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Test SMTP Connection
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host
# Define the host names here for the servers that needs to be monitored
$servers = "server01@domain.com","server02@domain.com"
# Define port number
$tcp_port = "25"

# Loop through each host to get an individual result.
ForEach($srv in $servers) {

    $tcpClient = New-Object System.Net.Sockets.TCPClient
    $tcpClient.Connect($srv,$tcp_port)
    $connectState = $tcpClient.Connected

    If($connectState -eq $true) {
        Write-Host "$srv is online"
    }
    Else {
		$alert = Server $srv is offline 
        Write-Host "$srv is offline"
		#$body = "$srv is offline, get-date -f yyyy-MM-dd"
    }

    $tcpClient.Dispose()
}

$param = @{
    SmtpServer = 'mail.domain.com'
    From = 'smtp-monitoring@domain.com'
    To = 'admin@domain.com.br'
    Subject = 'SMTP Monitoring'
    Body = $alert
}

Send-MailMessage @param
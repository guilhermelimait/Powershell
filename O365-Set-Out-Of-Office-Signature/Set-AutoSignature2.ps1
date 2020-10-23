Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Set autosignature to a out of office user
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Input = ".\users.csv"

import-csv $Input | foreach {
	$mailOrigem = $_.mailOrigem
	$mailDestino = $_.mailDestino
	$OOFMsg = @"
<html> 
<body>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
Obrigado pelo seu e-mail. Teste de mensagem de OOO.
<br>
<br>Por favor encaminhe sua mensagem para o endereço <a href="$mailDestino">$mailDestino</a>.
<br> 
<br>
Obrigado<br>
<br> Empresa X 
<meta charset="utf-8"/>
</body>
</html>
"@
	
	Write-host -ForegroundColor yellow "Starting on " $mailOrigem
		Set-MailboxAutoReplyConfiguration $mailOrigem -AutoReplyState enabled -ExternalAudience all -InternalMessage $OOFMsg -ExternalMessage $OOFMsg
	write-host -ForegroundColor Green "Autosignature set on" $mailDestino 

}

#Set-MailboxAutoReplyConfiguration user1@domain.com –AutoReplyState disabled

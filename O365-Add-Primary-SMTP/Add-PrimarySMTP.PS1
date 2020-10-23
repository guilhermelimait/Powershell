Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add user SMTPs based on manual info after migration
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$output = ".\LOG-ChangePrimarySMTP$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
add-content $output -Value "Count;Before;After"
$inputlist = Import-CSV ".\input-smtp.csv"
$Users = $inputlist
$total = ($inputlist).Length
$count = 0

Foreach ($User in $Users){
  $count += 1
  write-host "  [$count] of [$total] > Changing SMTP on: " -ForegroundColor white -NoNewline
  write-host $User.InternalEmailAddress -ForegroundColor Green
  $internal = $user.InternalEmailAddress
  $primary = $user.Primary
  $Alias2 = $user.Alias2
  $Alias3 = $user.Alias3
  $Alias4 = $user.Alias4
  $sip = $user.InternalEmailAddress
  $before = get-mailbox $primary | Select-Object -ExpandProperty EmailAddresses
  Set-Mailbox $primary -EmailAddresses "SMTP:$primary"
  Set-Mailbox $primary -EmailAddresses @{add=$Internal,$Alias2,$Alias3,$Alias4,"SIP:$sip"}
  $after = get-mailbox $primary | Select-Object -ExpandProperty EmailAddresses
  "$count" + ";" + "$before" + ";" + "$after" | add-content $output
}




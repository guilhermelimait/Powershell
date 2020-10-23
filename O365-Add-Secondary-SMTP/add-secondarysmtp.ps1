Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Create secondarysmtp to the informed users
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$inputlist = Import-Csv -Path ".\secondarysmtp.csv" 
$Users = $inputlist

$total = ($inputlist).Length
$count = 0

Write-Host "  > Creating secondary smtp to the users" -ForegroundColor DarkCyan
foreach ($user in $users) {
    $count += 1
    write-host "  [$count] of [$total] > Changed user: " -ForegroundColor white -NoNewline
    Write-host $user.UserPrincipalName -foreground Green
    
    #add onmicrosoftaddress to users
    $SecondarySMTP = $user.SecondarySMTP
    Set-Mailbox $user.UserPrincipalName -EmailAddresses @{add=$SecondarySMTP}
}
Write-host
Write-host Done! -ForegroundColor DarkCyan

Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add users to a group
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

Import-module ActiveDirectory

Write-host "  > Press [ENTER] to continue" -foreground DarkYellow
Read-host
Write-host "  > Adding users to the Groups:" -ForegroundColor White
Import-CSV ".\Input-Users.csv" | Foreach ($user in $users) {
    Add-ADGroupMember -Identity $user.LicenseGroup -Member $user.UserName
    Write-Host "  > User $User.UserName added to $user.LicenseGroup successfully!" -ForegroundColor Green
}
Write-host "  > End of Script!" -ForegroundColor White


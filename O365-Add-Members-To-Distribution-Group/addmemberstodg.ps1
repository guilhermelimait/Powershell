Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Add multiple users from an external list to a Distribution Group
"@

Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Userslist = Import-CSV .\Distribution-Groups-Members.csv
ForEach ($User in $Userslist)
{
Add-DistributionGroupMember -Identity "distributiongroup@domain.com" -Member $User.PrimarySmtpAddress
}

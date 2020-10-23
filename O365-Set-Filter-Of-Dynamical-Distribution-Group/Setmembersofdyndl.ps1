Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Create filter to a specific Dynamical Distribution Group
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

Set-DynamicDistributionGroup dyndl1@domain.com -RecipientFilter {(Department -like 'F*') -and (customattribute8 -eq 'LALA') -and (customattribute11 -eq 19)-and (customattribute13 -eq CCB)}

Set-DynamicDistributionGroup dyndl2@domain.com -RecipientFilter {(Department -like 'I*') -and (customattribute8 -eq 'LOLO') -and (customattribute11 -eq '18')-and (customattribute13 -eq 'FCB')}


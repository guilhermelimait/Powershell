Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Export all members of a Dynamical Distribution Group on O365
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host


$DDG = Get-DynamicDistributionGroup * -resultsize unlimited
$DDG | ForEach{
	Get-Recipient -RecipientPreviewFilter $DDG.RecipientFilter -resultsize unlimited | select DisplayName, PrimarySmtpAddress, RecipientType | Export-csv ".\$ddg.csv" -NoTypeInformation 
}
Write-host Finalizado
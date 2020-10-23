Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Change user password based on manual info
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$output = ".\LOG-UserPassword$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
add-content $output -Value "Count; UserPrincipalName; SignInName; LastPasswordChangeTimestamp; UsageLocation; ValidationStatus; PasswordNeverExpires; BlockCredential; Licenses"
$inputlist = Import-CSV ".\input.csv"
$Users = $inputlist
$total = ($inputlist).Length
$count = 0

Foreach ($User in $Users){
  $count += 1
  write-host "  [$count] of [$total] > Forcing password change in: " -ForegroundColor white -NoNewline
  write-host $User.Emailaddress -ForegroundColor Green
  
  Set-MsolUserPassword -UserPrincipalName $User.Emailaddress -NewPassword $User.Password -ForceChangePassword:$true

  Write-Host "  > Done!" -ForegroundColor Cyan
  $userinfo = Get-MsolUser -UserPrincipalName $User.Emailaddress | Select-Object UserPrincipalName,SignInName,LastPasswordChangeTimestamp,UsageLocation,ValidationStatus,PasswordNeverExpires,BlockCredential,Licenses
  $upn = $userinfo.UserPrincipalName
  $sig = $userinfo.SignInName
  $lpc = $userinfo.LastPasswordChangeTimestamp
  $usl = $userinfo.UsageLocation
  $vst = $userinfo.ValidationStatus
  $pne = $userinfo.PasswordNeverExpires
  $bcr = $userinfo.BlockCredential
  $uli = $userinfo.Licenses

  Add-Content $output -value "$count;$upn;$sig;$lpc;$usl;$vst;$pne;$bcr;$uli"
  #add-content $MailboxNotFound -value "$user; $UserInactivemailbox; $Usersize"
}
Write-host "  > Script completed!" -ForegroundColor Green


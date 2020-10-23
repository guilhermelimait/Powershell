Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Create new user and change password based on manual info from an external file
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$output = ".\LOG-UsersCreated$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
add-content $output -Value "Count;UserPrincipalName;DisplayName;FirstName;LastName;UsageLocation;Licenses;SignInName;LastPasswordChangeTimestamp;ValidationStatus;PasswordNeverExpires;BlockCredential"
$inputlist = Import-Csv -Path ".\Input-CreateNewUsers.csv" 
$Users = $inputlist
$total = ($inputlist).Length
$count = 0

foreach ($user in $users) {
    $count += 1
    write-host "  [$count] of [$total] > Creating user: " -ForegroundColor white -NoNewline
    Write-host $user.DisplayName -foreground Green

    New-MsolUser -UserPrincipalName $user.UserPrincipalName -DisplayName $user.DisplayName -FirstName $user.FirstName -LastName $user.LastName -UsageLocation $user.UsageLocation -LicenseAssignment $user.AccountSkuId
    Set-MsolUserPassword -UserPrincipalName $User.UserPrincipalName -NewPassword $User.Password -ForceChangePassword:$true

    Write-Host "  > Done!" -ForegroundColor Cyan
    $userinfo = Get-MsolUser -UserPrincipalName $user.UserPrincipalName | Select-Object UserPrincipalName, DisplayName, FirstName, LastName, UsageLocation, Licenses, SignInName, LastPasswordChangeTimestamp, ValidationStatus, PasswordNeverExpires, BlockCredential
    $UPN = $userinfo.UserPrincipalName
    $DNM = $userinfo.DisplayName
    $FNM = $userinfo.FirstName
    $LNM = $userinfo.LastName
    $ULC = $userinfo.usagelocation
    $LIC = $userinfo.licenses
    $sig = $userinfo.SignInName
    $lpc = $userinfo.LastPasswordChangeTimestamp
    $vst = $userinfo.ValidationStatus
    $pne = $userinfo.PasswordNeverExpires
    $bcr = $userinfo.BlockCredential

    Add-Content $output -value "$count;$UPN;$DNM;$FNM;$LNM;$ULC;$LIC;$sig;$lpc;$vst;$pne;$bcr"
}
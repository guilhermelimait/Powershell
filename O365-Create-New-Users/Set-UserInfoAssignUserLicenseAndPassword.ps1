Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Set user info, change password and assign license based on manual info on external file
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host
#input file
$inputlist = Import-Csv -Path ".\Input-UserInfoAssignUserLicenseAndPassword.csv"
#Output file
$output = ".\LOG-UserInfoAssignUserLicenseAndPassword$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
add-content $output -Value "Count;UserPrincipalName;DisplayName;FirstName;LastName;UsageLocation;Licenses;SignInName;LastPasswordChangeTimestamp;ValidationStatus;PasswordNeverExpires;BlockCredential"
$Users = $inputlist
$total = ($inputlist).Length
$count = 0

foreach ($user in $users) {
    $count += 1
    write-host "  [$count] of [$total] > Changed user: " -ForegroundColor white -NoNewline
    Write-host $user.UserPrincipalName -foreground Green
    
    #add onmicrosoftaddress to users
    $Onmicrosoftaddress = $user.Onmicrosoft
    Set-Mailbox $user.UserPrincipalName -EmailAddresses @{add=$Onmicrosoftaddress}

    #Set user, add password and license to the end user
    Set-MsolUser -UserPrincipalName $user.UserPrincipalName -DisplayName $user.DisplayName -FirstName $user.FirstName -LastName $user.LastName -UsageLocation $user.UsageLocation 
    Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -AddLicenses $user.AccountSkuId -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
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
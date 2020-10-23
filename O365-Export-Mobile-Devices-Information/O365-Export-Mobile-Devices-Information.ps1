Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Export all device information from the users from Brazil filter
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

# New file 
$csv = New-Item -name ".\MobileDevices-$(get-date -f yyyy.MM.ddTHH.mm.ss).csv" -ItemType file
add-content "Name; UPN; Location; Languages; Alias; DeviceFriendlyName; DisplayName; ClientType; ClientVersion; DeviceId; DeviceMobileOperator; DeviceModel; DeviceOS; DevicePhoneNumber; DeviceType; FirstSyncTime" -path $csv

# Variable definition
$count = $total = 0
$results = @()
$mobileDevice = @()

# Starting Script search
Clear-host
Write-host "+ Starting script ..." -foreground Green
Write-host "+ Searching users in Brazil... " -Foreground Green 
$mailboxUsers = get-mailbox -filter {UsageLocation -eq "Brazil"} -resultsize unlimited | select-object -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
$mailboxUsers.count
Write-host "-  ($mailboxUsers).Count were found successfully!" -foreground Yellow

foreach($user in $mailboxUsers){
	$UPN = $user.UserPrincipalName
	$displayName = $user.DisplayName
	$languages = $user.Languages
	$alias = $user.Alias
	$location = $user.UsageLocation
	$mobileDevices = Get-MobileDeviceStatistics -Mailbox $UPN 

	write-host "+ Information from user: $UPN being captured... " -foreground Green
	foreach($mobileDevice in $mobileDevices){
		$Name = $user.name
		$DeviceFriendlyName = $mobileDevice.DeviceFriendlyName
		$ClientType = $mobileDevice.ClientType 
		$ClientVersion = $mobileDevice.ClientVersion 
		$DeviceId = $mobileDevice.DeviceId 
		$DeviceMobileOperator = $mobileDevice.DeviceMobileOperator
		$DeviceModel = $mobileDevice.DeviceModel 
		$DeviceOS = $mobileDevice.DeviceOS 
		$DevicePhoneNumber = $mobileDevice.DevicePhoneNumber
		$DeviceType = $mobileDevice.DeviceType
		$FirstSyncTime = $mobileDevice.FirstSyncTime
    }
    $results += New-Object psobject -Property $properties
   
    # Exporting Data
    Write-host "-  Exporting data from user: $UPN..." -foreground Green 
    add-content "$Name; $UPN; $Location; $Languages; $Alias; $DeviceFriendlyName; $DisplayName; $ClientType; $ClientVersion; $DeviceId; $DeviceMobileOperator; $DeviceModel; $DeviceOS; $DevicePhoneNumber; $DeviceType; $FirstSyncTime" -path $csv
    Write-host "+ Exporting completed successfully..." -foreground Yellow
}
# The End
write-host "+ End of Script" -Foreground Green  




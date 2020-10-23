
$desc = @"

DEVELOPED BY : Guilherme Lima
PLATFORM     : O365
WEBSITE      : http://solucoesms.com.br
WEBSITE2     : http://github.com/guilhermelimait
LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
DESCRIPTION  : Export mobile device info

"@
Write-host $desc

# New file 
$count = $total = 0
$csv = New-Item -name ".\MobileDevices-$(get-date -f yyyy.MM.ddTHH.mm.ss).csv" -ItemType file
add-content "userdisplayname; userprincipalname; languages; alias; usagelocation; clienttype; DeviceFriendlyName; deviceos; devicemodel; deviceid; DeviceMobileOperator; DevicePhoneNumber; DeviceType; FirstSyncTime" -path $csv

$mailboxUsers = get-mailbox -filter {UsageLocation -eq "Brazil"} -resultsize unlimited | select-object -expandproperty userprincipalname -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -first 5

($mailboxUsers).count

foreach($user in $mailboxUsers){
	$mailbox = get-mailbox $user | select-object displayname, userprincipalname, languages, alias, usagelocation
	$devicestat = Get-MobileDeviceStatistics -mailbox $user | select-object @{Name='clienttype',Expression={[string]::join(",",($_.clienttype))}}, @{Name='DeviceFriendlyName',Expression={[string]::join(",",($_.DeviceFriendlyName))}}, @{Name='deviceos',Expression={[string]::join(",",($_.deviceos))}}, @{Name='devicemodel',Expression={[string]::join(",",($_.devicemodel))}}, @{Name='deviceid',Expression={[string]::join(",",($_.deviceid))}}, @{Name='DeviceMobileOperator',Expression={[string]::join(",",($_.DeviceMobileOperator))}}, @{Name='DevicePhoneNumber',Expression={[string]::join(",",($_.DevicePhoneNumber))}}, @{Name='DeviceType',Expression={[string]::join(",",($_.DeviceType))}}, @{Name='FirstSyncTime',Expression={[string]::join(",",($_.FirstSyncTime))}}
	add-content "$mailbox.displayname; $mailbox.userprincipalname; $mailbox.languages.name; $mailbox.alias; $mailbox.usagelocation; $devicestat.clienttype; $devicestat.DeviceFriendlyName; $devicestat.deviceos; $devicestat.devicemodel; $devicestat.deviceid; $devicestat.DeviceMobileOperator; $devicestat.DevicePhoneNumber; $devicestat.DeviceType; $devicestat.FirstSyncTime" -path $csv
	#write-host $mailbox.displayname; $mailbox.userprincipalname; $mailbox.languages.name; $mailbox.alias; $mailbox.usagelocation; $devicestat.clienttype; $devicestat.DeviceFriendlyName; $devicestat.deviceos; $devicestat.devicemodel; $devicestat.deviceid; $devicestat.DeviceMobileOperator; $devicestat.DevicePhoneNumber; $devicestat.DeviceType; $devicestat.FirstSyncTime

}
write-host end***



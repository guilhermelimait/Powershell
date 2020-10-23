
$user = "diego.silveira@amcontratos.com.br"

$mailbox = get-mailbox $user | select-object userdisplayname, userprincipalname
$devicestat = Get-MobileDeviceStatistics -mailbox $user | select-object @{Name='clienttype';Expression={[string]::join(";",($_.clienttype))}}, @{Name='DeviceFriendlyName';Expression={[string]::join(";",($_.DeviceFriendlyName))}}, @{Name='deviceos';Expression={[string]::join(";",($_.deviceos))}}, @{Name='devicemodel';Expression={[string]::join(";",($_.devicemodel))}}

cls
write-host USERDISPLAYNAME: $mailbox.userdisplayname
write-host USERPRINCIPALNAME: $mailbox.userprincipalname
write-host CLIENTTYPE: $devicestat.clienttype
write-host DEVICEFRIENDLYNAME: $devicestat.devicefriendlyname
write-host DEVICEOS: $devicestat.deviceos
write-host DEVICEMODEL: $devicestat.devicemodel

#Get-QADUser seth -IncludeAllProperties | select name, @{Name=’proxyAddresses’;Expression={[string]::join(“;”, ($_.proxyAddresses))}}



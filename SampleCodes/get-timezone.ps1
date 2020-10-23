$test = Get-Date
$timezonedate = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, 'Romance Standard Time')
write-host $test -ForegroundColor green
write-host $timezonedate -ForegroundColor green
##################

$a = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([datetime]::UtcNow, 'Romance Standard Time').ToString('yyyy-MM-ddTHH:mm:ss')
Write-Host $a -ForegroundColor Yellow

##################

$DateTime = Get-Date
$FromTZ = Get-Date
$ToTZ = [System.TimeZoneInfo]::FindSystemTimeZoneById("Romance Standard Time")
$UTC = [System.TimeZoneInfo]::ConvertTimeToUtc($DateTime, $FromTZ)
[System.TimeZoneInfo]::ConvertTimeFromUtc($utc, $ToTZ)


##
Function Get-LocalTime($UTCTime){
    $strCurrentTimeZone = (Get-WmiObject win32_timezone).StandardName
    $TZ = [System.TimeZoneInfo]::FindSystemTimeZoneById($strCurrentTimeZone)
    $LocalTime = [System.TimeZoneInfo]::ConvertTimeFromUtc($UTCTime, $TZ)
    Return $LocalTime
}

Get-LocalTime Get-Date

########


[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date), 'Romance Standard Time')

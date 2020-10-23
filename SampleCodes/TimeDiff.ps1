
$StartDate = (get-date -format "HH:mm:ss")
$EndDate = (get-date -format "HH:mm:ss")
$TimeDiff = New-Timespan -Start $StartDate -End $EndDate
write-host $timediff 

Clear-Host
Write-Host "____ TIME DIFF ____"

$StartDate = (get-date -format "HH:mm:ss")

Start-sleep 10

$EndDate = (get-date -format "HH:mm:ss")
$TimeDiff = New-Timespan -Start $StartDate -End $EndDate

Write-Host
Write-host "Started at $StartDate, " -ForegroundColor Green -NoNewline
write-host "ended at $EndDate, "  -ForegroundColor Red -NoNewline
Write-host "difference between them is $TimeDiff" -ForegroundColor Cyan
Write-Host




$day = 0
Function GetMessageCount ($StartHour, $StartMinute, $EndHour, $EndMinute, $DifferenceBetweenTimeZones){
    $script:datestart = ([DateTime]::Today.AddDays(-$day).AddHours($StartHour - $DifferenceBetweenTimeZones).addminutes($StartMinute)).tostring("yyyy-MM-dd HH:mm")
    $script:dateend = ([DateTime]::Today.AddDays(-$day).AddHours($EndHour - $DifferenceBetweenTimeZones).addminutes($EndMinute)).tostring("yyyy-MM-dd HH:mm")
    Write-Host $datestart " " -ForegroundColor green -NoNewline
    Write-Host $dateend -ForegroundColor Yellow
    #Write-Host $tempo1 $tempo2
}
GetMessageCount 00 00 06 00 -5






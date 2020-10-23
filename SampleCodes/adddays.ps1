

[DateTime]$start = "7/02/19 01:00"
[DateTime]$end = "7/10/19 02:00"
$datafinal = Get-Date

while ($end -lt $datafinal) {    
    Write-Host "Data atual " $end.Day $end.Month
    $end = $end.AddDays(5)    
    $start = $start.AddDays(5)
}  
 


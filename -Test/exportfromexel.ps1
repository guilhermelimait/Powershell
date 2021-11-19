Clear-Host
$Filename = ".csv"
$Origin = "HamperDelivery (7).csv"
$FilePath = "C:\Users\ITLimaGu\OneDrive - NESTLE\Hampers"

$NumberOfFiles = 20
$Skip=1
$FinalRow=$NumberOfRows=150
#$FinalRow=150

for ($x = 1; $x -le $NumberOfFiles; $x++){
    Write-Host "===================================="
    New-Item -Path "$FilePath" -Name "\Hampers$x$Filename" -ItemType "file" -WarningAction SilentlyContinue -InformationAction SilentlyContinue
        Write-Host "Arquivo Hampers$x - $Skip to " $FinalRow
        $header = @((get-content $FilePath\$Origin | Select-Object -First 1))
        $header += (get-content $FilePath\$Origin | Select-Object -Skip $Skip -First $NumberOfRows)
        $content = $header | Add-Content -Path "$FilePath\Hampers$x$Filename"
        $Skip+= $NumberOfRows
        $FinalRow = $FinalRow + $NumberOfRows
        $Size = Get-Content $FilePath\Hampers$x$Filename | Measure-Object -Line
        Write-Host Hampers$x$Filename, $Size.Lines
}
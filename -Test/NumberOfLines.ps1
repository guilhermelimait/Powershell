Clear-Host
$Extension = ".csv"
$FilePath = "C:\Users\ITLimaGu\OneDrive - NESTLE\Hampers\"

$list = Get-ChildItem $FilePath 
foreach ($item in $list) {
    $a = Get-Content $FilePath$item | Measure-Object -line
    Write-Host $item.Name, $a.Lines
}

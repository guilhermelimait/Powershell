$name = "italy"
$url = "http://solucoesms.com.br"
Clear-Host
$oldfile = ".\$name.old"

if (Test-Path -path $oldfile) {
    Write-Host
    Write-Host " Reference file found, starting test ..." -BackgroundColor Green -ForegroundColor Black
    Write-Host
    $new = Invoke-WebRequest -Uri $url
    if ($null -ne (Compare-Object -ReferenceObject (get-content $oldfile) -DifferenceObject $new)){
        Write-Host " The website $url was not updated since last comparison. " -BackgroundColor Red -ForegroundColor Black
        Write-Host
    } else {
        Write-Host " The webSite $url was updated! " -BackgroundColor Green -ForegroundColor Black
        Write-Host
    }
} else {
    New-Item -type file -name ".\$name.old" | out-null
    Write-Host
    Write-Host " There is no data to compare, program will finish " -BackgroundColor yellow -ForegroundColor Black
    Write-Host
    Invoke-WebRequest -Uri $url -OutFile $oldfile
    Write-Host " Reference file created, you can run me again  " -BackgroundColor yellow -ForegroundColor Black
    Write-Host   
    break
}




<#

$old = Get-Content $oldfile
$new = Invoke-WebRequest  

#>

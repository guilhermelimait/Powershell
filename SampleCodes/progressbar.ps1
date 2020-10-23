for($CountSearching = 1; $CountSearching -lt 10; $CountSearching++ )
{
    Write-Progress -Activity "Verifying users data..."-Status 'Progress ->' -PercentComplete $CountSearching -CurrentOperation OuterLoop
    for($CountExporting = 1; $CountExporting -lt 101; $CountExporting++ )
    {
        Write-Progress -id 2 -Activity "Exporting users data..." -Status 'Progress' -PercentComplete $CountExporting -CurrentOperation InnerLoop
    }
}
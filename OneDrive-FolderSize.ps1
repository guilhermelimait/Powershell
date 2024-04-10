


#Parameters
$path = "C:\Temp"
$outputFile ="C:\Temp\FolderSize.csv"
$credential = Get-Credential
Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
Connect-SPOService -Url https://portal.office.com

#Get all Folders, Sub-Folders recursively
$folders = Get-ChildItem -Path $Path -Directory -Recurse
 
#Loop through each folder to Find the size
$FolderSizes = foreach ($folder in $folders) {
    $size = (Get-ChildItem -Path $folder.FullName -File -Recurse | Measure-Object -Property Length -Sum).Sum
    $sizeInMB = $size / 1MB
 
    #Collect Data
    [PSCustomObject]@{
        FolderName = $folder.FullName
        SizeInMB = [Math]::Round($sizeInMB,2)
    }
}
#Export the Result to CSV
$FolderSizes | Format-table
$FolderSizes | Export-Csv -Path $outputFile -NoTypeInformation

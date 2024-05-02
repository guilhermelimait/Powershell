Install-Module -Name PowerShellGet -Force -AllowClobber
Install-Module -Name MicrosoftTeams -Force -AllowClobber

Connect-MicrosoftTeams

$groupID = "f607d0f0-b1ef-4f11-a615-c0d3f900cac3"
$displayName = "Research and Development - MS 365 Copilot Pilot"
Import-Csv ".\users.csv" | ForEach-Object {
    Add-TeamChannelUser -GroupId $groupID -DisplayName $displayName -User $_.Mail
    Write-Host "User:" $_.Mail "added to the group!" 
}
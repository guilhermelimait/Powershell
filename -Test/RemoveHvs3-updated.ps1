### SET HOME DIRECTORY AND HOMEDRIVE to $NULL
### Update the ExtensionAttribute15 to contains the following information
### "Current Date;OneDriveCompleted;\\UNC Path for recording"
     
### SET HOME DIRECTORY AND HOMEDRIVE to $NULL
### Update the ExtensionAttribute15 to contains the following information
### "Current Date;OneDriveCompleted;\\UNC Path for recording"
### Version: 2.0 (Date: 09-01-2017)
     
<#param 
( [Parameter(Mandatory=$True)] [string]$File )
Import-Module ActiveDirectory
#>

Function Set-RDUserSetting{
param
([parameter()][string]$User)

$TSHDValue = ""
$logonServer = $env:LOGONSERVER.Replace("\", "")

#Get the distinguishedName from the User
$UserdistinguishedName = Get-ADUser -Properties * -Identity $User | Select-Object distinguishedName
$String = $($UserdistinguishedName).distinguishedName
[ADSI]$CTXUser = "LDAP://$logonServer/$String"
$property = "TerminalServicesHomeDirectory"

    try{
        if($CTXUser.psbase.invokeget($property) -ne $null){
            
            #Write-Host "TerminalServicesHomeDirectory: "$CTXUser.InvokeGet("TerminalServicesHomeDirectory")
            #Write-Host "TerminalServicesHomeDrive: "$CTXUser.InvokeGet("TerminalServicesHomeDrive")
            Write-Host "|-  Current Terminal Settings:" $CTXUser.TerminalServicesHomeDrive "->" $CTXUser.TerminalServicesHomeDirectory": removing... "
            $CTXUser.psbase.InvokeSet("TerminalServicesHomeDirectory",$TSHDValue)           
            $CTXUser.setinfo()
        }
        if($CTXUser.psbase.invokeget($property) -eq $null){
           Write-Host "Users without HomeProfile in RDS"
        }
       }
     Catch{ [System.Exception]
      }
}

### SCRIPT START HERE ###
$file = ".\removeh.txt"
$Users = Get-Content $File
$Date = Get-Date -Format MM-dd-yyyy

$file1 = new-item -type file -name "report$(get-date -f MM-dd-yyyy_HH_mm_ss).csv"
$fileContent = Import-csv $file1 -header "user", "CurrentHome","NewHome","extensionAttribute15"
$datereport = $(get-date -f MM-dd-yyyy_HH_mm_ss)

foreach ($User in $Users){

    $HDriveBefore = Get-AdUser -Identity $User -Properties HomeDirectory,HomeDrive,Name,extensionAttribute15
    $ext = "$Date;OneDriveCompleted;$($HDriveBefore.HomeDirectory)"
        if ($HDriveBefore.HomeDrive -ne $null) {
            Write-Host -NoNewline "|-  Current home:" $HDriveBefore.HomeDrive "->" $HDriveBefore.HomeDirectory": removing... "
            Set-AdUser -Identity $User -HomeDirectory $null -HomeDrive $null
            Set-ADUser -Identity $User -Clear "extensionAttribute15"
            Set-ADUser -Identity $User -Add @{extensionAttribute15 = $ext}

            Write-Host "Done."
            $HDriveAfter = Get-AdUser -Identity $User -Properties HomeDirectory,HomeDrive,Name,extensionAttribute15
	$newRow = New-Object PsObject -Property @{ user =  $User; CurrentHome = $HDriveBefore.HomeDirectory ; NewHome = $HDriveAfter.HomeDirectory ; extensionAttribute15 = $HDriveAfter.extensionAttribute15}
	Export-Csv $file1 -inputobject $newrow -append -Force

        } else {
	$newRow = New-Object PsObject -Property @{ user =  $User; CurrentHome = $HDriveBefore.HomeDirectory ; NewHome = "Not changed" ; extensionAttribute15 = $HDriveAfter.extensionAttribute15}
	Export-Csv $file1 -inputobject $newrow -append -Force
            Write-Host "$User"+" :Already migrated"
        }
        #Set-RDUserSetting -User $User
    }
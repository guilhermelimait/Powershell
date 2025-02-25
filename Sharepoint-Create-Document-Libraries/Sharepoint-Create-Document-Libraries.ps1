#Import SharePoint Online PowerShell Module
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
    
Function Create-DocumentLibrary()
{
    param
    (
        [Parameter(Mandatory=$true)] [string] $SiteURL,
        [Parameter(Mandatory=$true)] [string] $DocLibraryName
    )   
    Try {
    #Setup Credentials to connect
    $Cred = Get-Credential
 
    #Set up the context
    $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
    $Ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.UserName,$Cred.Password)
 
    #Get All Lists from the web
    $Lists = $Ctx.Web.Lists
    $Ctx.Load($Lists)
    $Ctx.ExecuteQuery()
  
    #Check if Library name doesn't exists already and create document library
    if(!($Lists.Title -contains $DocLibraryName))
    {
        #create document library in sharepoint online powershell
        $ListInfo = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $ListInfo.Title = $DocLibraryName
        $ListInfo.TemplateType = 101 #Document Library
        $List = $Ctx.Web.Lists.Add($ListInfo)
        $List.Update()
        $Ctx.ExecuteQuery()
   
        write-host  -f Green "New Document Library has been created!"
    }
    else
    {
        Write-Host -f Yellow "List or Library '$DocLibraryName' already exist!"
    }
}
Catch {
    write-host -f Red "Error Creating Document Library!" $_.Exception.Message
}
}
  
#Set Parameters
$SiteURL= "https://nestle.sharepoint.com/teams/StreamBackup001"
$DocLibraryName = 'StreamLibrary001-010','StreamLibrary011-020','StreamLibrary021-030','StreamLibrary031-040','StreamLibrary041-050','StreamLibrary051-060','StreamLibrary061-070','StreamLibrary071-080','StreamLibrary081-090','StreamLibrary091-100'
  
#Call the function to create document library

ForEach ($doclib in $DocLibraryName) {
    Create-DocumentLibrary -siteURL $SiteURL -DocLibraryName $doclib
}

Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : This script was made to insert the extension attribute 9 on all users informed in the file "userslist.csv"
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host


#create report file
$output = new-item -type file -name "report$(get-date -f MM-dd-yyyy_HH_mm_ss).csv"
Add-Content $output "user;expectedExtAtt9;foundExtAtt9;insertedExtAtt9"

Import-Csv .\"userslist.csv" -Delimiter ";" | foreach {
	
    #variable declaration
    $user = $_.user
	$att = $_.att9
    
    #find user, shows the users attribute
	$att9onad = Get-ADUser -Identity $user -Properties * | Select-Object -ExpandProperty extensionattribute9 
    write-host User $user com extatt9 = $att9onad -ForegroundColor yellow 
    
    #clear attribute, insert the attribute, find user again, save to
    Set-ADUser -Identity "$user" -clear extensionAttribute9
    Set-ADUser -Identity "$user" -Add @{extensionAttribute9="$att"}
    $att9onadafterchange = Get-ADUser -Identity $user -Properties * | Select-Object -ExpandProperty extensionattribute9
    
    #save the report
    add-content $output "$user;$att;$att9onad;$att9onadafterchange"
    Write-Host User $user modified to $att9onadafterchange
}
Write-host "--- The enD ---" -ForegroundColor Green

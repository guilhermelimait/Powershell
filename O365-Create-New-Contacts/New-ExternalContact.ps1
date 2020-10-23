Clear-Host
$desc = @"
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Create or Remove contacts and Add them as Forward address. Used during migration processes
"@
Write-host $desc -ForegroundColor DarkCyan
Write-Host

$Contacts = Import-CSV ".\externalcontacts2.csv"
$count = 0
$total = ($Contacts).Length

FUNCTION menu {
    Write-host "  > Choose an option:" -ForegroundColor DarkCyan
    Write-host "  1 - Create Contacts" -ForegroundColor White
    Write-host "  2 - Remove Contacts" -ForegroundColor White
    Write-host "  3 - Exit" -ForegroundColor Red
	Write-host
	$a = Read-host 
	switch($a){
		1 { Create }
		2 { Remove }
		3 { End }
	}
}

FUNCTION Create {
    $outputcreated = ".\LOG-createdcontacts$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
    add-content $outputcreated -Value "Count;InternalEmailaddress;ForwardingSmtpAddress;ForwardingAddress;DeliverToMailboxAndForward"
    Foreach ($contact in $contacts){
        $count += 1
        $displayname = "Migracao-"+$Contact.firstname+$contact.LastName
        write-host "  [$count] of [$total] -"$Contact.InternalEmailaddress
        New-MailContact -Name $displayname -DisplayName $displayname -ExternalEmailAddress $Contact.ExternalEmailAddress -FirstName $Contact.FirstName -LastName $Contact.LastName | Set-MailContact -HiddenFromAddressListsEnabled $true 
        Write-Host "  > Contact created:" $contact.Name "as" $displayname -ForegroundColor green
        Set-Mailbox $Contact.InternalEmailaddress -DeliverToMailboxAndForward $true -ForwardingSMTPAddress $Contact.ForwardingSmtpAddress
        $Validation = get-mailbox $contact.InternalEmailaddress |select-object ForwardingSmtpAddress, ForwardingAddress, DeliverToMailboxAndForward
        $count + ";" + $Contact.InternalEmailaddress + ";" + $Validation.ForwardingSmtpAddress + ";" + $Validation.ForwardingAddress + ";" + $Validation.DeliverToMailboxAndForward | add-content $outputcreated
        #get-mailbox $contact.InternalEmailaddress | fl ForwardingSMTPAddress,DeliverToMailboxandForward
    }
}

FUNCTION Remove {
    $outputremoved = ".\LOG-removedcontacts$(get-date -f yyyy-MM-dd_HH_mm_ss).csv"
    add-content $outputremoved -Value "Count;InternalEmailaddress;ForwardingSmtpAddress;ForwardingAddress;DeliverToMailboxAndForward"
    Foreach ($contact in $contacts){
        $count += 1
        $displayname = "Migracao-"+$Contact.firstname+$contact.LastName
        write-host "  [$count] of [$total]" $Contact.InternalEmailaddress
        Set-Mailbox $Contact.InternalEmailaddress -ForwardingSmtpAddress $null -ForwardingAddress $null -DeliverToMailboxAndForward $false
        Write-host "  > User Info: $displayname Removed" -ForegroundColor Green
        Remove-MailContact $displayname -Confirm:$false
        Write-host "  > Contact: $displayname Removed" -ForegroundColor Green
        $Validation = get-mailbox $contact.InternalEmailaddress |select-object ForwardingSmtpAddress, ForwardingAddress, DeliverToMailboxAndForward
        $count + ";" + $Contact.InternalEmailaddress + ";" + $Validation.ForwardingSmtpAddress + ";" + $Validation.ForwardingAddress + ";" + $Validation.DeliverToMailboxAndForward | add-content $outputremoved
    }
}

FUNCTION End {
    get-mailcontact
    $count = 0
    exit
}

menu
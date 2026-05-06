# PowerShell Scripts

A collection of PowerShell scripts for Microsoft 365 and Active Directory administration.

## Contents

Scripts are organized by service area:

- **AD-*** — Active Directory operations: user management, group membership, extension attributes
- **O365-*** — Microsoft 365: mailbox permissions, forwarding, litigation hold, shared mailboxes, SMTP settings, calendar permissions, license management
- **Teams-*** — Microsoft Teams administration
- **Sharepoint-*** — SharePoint Online site and permission management
- **SampleCodes/** — Reference snippets and examples
- `OneDrive-FolderSize.ps1` — Reports OneDrive folder sizes per user
- `Disclaimer.ps1` — Email disclaimer configuration via transport rules

## Requirements

- [ExchangeOnlineManagement](https://docs.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell) module
- [AzureAD](https://docs.microsoft.com/en-us/powershell/module/azuread/) or MSOnline module (depending on the script)
- Visual Studio Code or Windows PowerShell ISE

Connect to Exchange Online and Azure AD before running most scripts.

## License

MIT

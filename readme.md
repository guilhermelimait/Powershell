<<<<<<< HEAD
# General info

The scripts created here are based on powershell and mostly of them connected to O365.
You may need to install the Exchange powershell libraries:

* [O365 Exchange connector](https://docs.microsoft.com/pt-br/office365/enterprise/powershell/connect-to-office-365-powershell)
* [Powershell O365](https://docs.microsoft.com/pt-br/office365/enterprise/powershell/connect-to-office-365-powershell)
* [Visual Studio Code](https://code.visualstudio.com/download)

## Projects Overview

| Project Name | Description |
|-------------|-------------|
| ConnectO365 | Basic script to establish connection with Office 365 services using PowerShell |
| ConnectO365-ViaMenu | Interactive menu-driven script to connect to various O365 services (Exchange Online, SharePoint, Teams) |
| AD-Add-Users-To-Group | Automates the process of adding users to Active Directory groups |
| AD-User-Management | Scripts for managing AD user accounts, including creation, modification, and deletion |
| Exchange-Distribution-Lists | Manages Exchange distribution lists and their members |
| Exchange-Mailbox-Management | Handles mailbox permissions, quotas, and configurations |
| License-Management | Manages Office 365 license assignments and generates reports |
| OneDrive-Management | Scripts for managing OneDrive settings, sharing, and permissions |
| Remove-OneDrive-Sync | Helps troubleshoot and remove problematic OneDrive sync relationships |
| SharePoint-Backup | Performs SharePoint site collection and list backups |
| SharePoint-Create-Document-Libraries | Creates and configures document libraries in SharePoint with specified settings |
| SharePoint-List-Management | Manages SharePoint lists, including creation, updates, and permissions |
| SharePoint-Permission-Management | Handles SharePoint site and item level permissions |
| SharePoint-Site-Creation | Automates the creation of SharePoint sites with predefined templates |
| SharePoint-Site-Management | Collection of scripts for SharePoint site administration tasks |
| Teams-Channel-Management | Manages Microsoft Teams channels, including creation and permissions |
| Teams-Guest-Access | Controls guest access settings and permissions in Microsoft Teams |
| Teams-Policy-Management | Configures and applies Teams policies to users and groups |
| Teams-Remove-User | Automates the process of removing users from Microsoft Teams |
| Teams-Team-Creation | Creates Teams with predefined channels and settings |
| User-Offboarding | Comprehensive script for removing user access across O365 services |
| User-Onboarding | Automates new user setup across AD, Exchange, and SharePoint |
| Security-Compliance | Scripts for managing security and compliance settings in O365 |
| Report-Generation | Creates various administrative reports for O365 services |
| Bulk-Operations | Scripts for performing bulk operations across multiple services |
| PowerApps-Management | Manages PowerApps environments and permissions |
| Flow-Management | Handles Microsoft Flow (Power Automate) configurations |
| Azure-AD-Management | Scripts for managing Azure AD users, groups, and settings |
| Graph-API-Scripts | Collection of scripts utilizing Microsoft Graph API |
| Migration-Tools | Tools for migrating content between different O365 services |

## What can I do?

Copy the files and use it as you wish, what you see is what you get, if you have doubts, please inform
=======
# PowerShell Scripts
This repository contains a collection of PowerShell scripts designed for automating various tasks related to Windows system administration and general utility functions. These scripts are intended to help system administrators, IT professionals, and even developers streamline their workflows and improve efficiency.
>>>>>>> 8f47a4fa5e6d6bb1742b8f06884f7db549a72466

## Author Information
* [Blog](http://solucoesms.com.br)
* [LinkedIn](https://www.linkedin.com/in/guilhermelimait/)

## License
This project is licensed under the MIT License

## Table of Contents
- [Introduction](#introduction)
- [Scripts](#scripts)
- [How to Use](#how-to-use)
- [Prerequisites](#prerequisites)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction
These PowerShell scripts address the need for automating repetitive tasks and simplifying complex system administration procedures. They offer solutions for managing users, retrieving system information, manipulating files, and more. I've developed these scripts to enhance my own productivity and share them with the community to help others achieve similar efficiency gains.

## Scripts
This section provides a brief overview of each script in the repository. For more detailed information on a specific script, please refer to the script's documentation or comments within the script itself.

*   `Get-SystemInfo.ps1`: Retrieves system information such as OS version, CPU, memory, disk space, and network configuration.  Useful for quickly gathering system details.
*   `Update-UserPassword.ps1`: Updates the password for a specified user account.  Can be used for automated password resets or bulk user management.
*   `Backup-Files.ps1`: Backs up specified files or folders to a designated location.  Supports various backup methods and scheduling options (to be implemented).
*   `Get-EventLog.ps1`: Retrieves entries from the Windows Event Log based on specified criteria.  Helps in troubleshooting and monitoring system events.
*   `Set-FirewallRule.ps1`: Creates or modifies Windows Firewall rules.  Useful for managing network security.
*   `Test-NetworkConnectivity.ps1`: Tests network connectivity to specified hosts or services.  Aids in diagnosing network issues.
*   `Convert-ADUserToCSV.ps1`: Exports Active Directory user information to a CSV file.  Facilitates data analysis and reporting.
*   `Install-Software.ps1`: Installs specified software packages.  Supports various installation methods and package formats.
*   `Get-ServiceStatus.ps1`: Retrieves the status of Windows services.  Helps in monitoring and managing services.
*   `Stop-Process.ps1`: Stops specified processes.  Useful for managing running applications and services.

## How to Use
Each script includes detailed comments explaining its usage, parameters, and examples.  Here are some general examples:

```powershell
# Example usage of Get-SystemInfo.ps1
.\Get-SystemInfo.ps1 -Verbose

# Example usage of Update-UserPassword.ps1
.\Update-UserPassword.ps1 -User "JohnDoe" -NewPassword "P@$$wOrd"

# Example usage of Backup-Files.ps1 (assuming a configuration file)
.\Backup-Files.ps1 -ConfigFile "backup_config.json"

# Example usage of Get-EventLog.ps1
.\Get-EventLog.ps1 -LogName "System" -NumberOfEntries 10 -FilterXPath "*[System[TimeCreated[@SystemTime>='2024-10-26T00:00:00Z']]]"





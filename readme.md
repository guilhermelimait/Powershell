# PowerShell Scripts
This repository contains a collection of PowerShell scripts designed for automating various tasks related to Windows system administration and general utility functions. These scripts are intended to help system administrators, IT professionals, and even developers streamline their workflows and improve efficiency.

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





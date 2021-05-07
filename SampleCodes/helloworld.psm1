<#
  DEVELOPED BY : Guilherme Lima
  PLATFORM     : O365/Local
  WEBSITE      : http://solucoesms.com.br
  WEBSITE2     : http://github.com/guilhermelimait
  LINKEDIN     : https://www.linkedin.com/in/guilhermelimait/
  DESCRIPTION  : Simple hello world with random color show everytime you run it
#>

param (
    [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()]$Foreground,
    [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()]$Background
)
Clear-Host

$Colors = "Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White"

$helloworld = @"
 #     #                                   #     #                             ### 
 #     # ###### #      #       ####        #  #  #  ####  #####  #      #####  ### 
 #     # #      #      #      #    #       #  #  # #    # #    # #      #    # ### 
 ####### #####  #      #      #    # ##### #  #  # #    # #    # #      #    # ### 
 #     # #      #      #      #    #       #  #  # #    # #####  #      #    # ### 
 #     # #      #      #      #    #       #  #  # #    # #   #  #      #    #     
 #     # ###### ###### ######  ####         ## ##   ####  #    # ###### #####   #  
"@

if(([string]::IsNullOrWhiteSpace($Foreground)) -and ([string]::IsNullOrWhiteSpace($Background))){
    Write-Host $helloworld -ForegroundColor (Get-Random($Colors)) -BackgroundColor (Get-Random($Colors))
} else {
    Write-Host $helloworld -ForegroundColor $foreground -BackgroundColor $background
}

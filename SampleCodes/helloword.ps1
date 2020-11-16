param (
    [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()]$Foreground,
    [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()]$Background
)

#Clear-Host
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
    Write-Host $helloworld -ForegroundColor DarkCyan -BackgroundColor DarkGray
} else {
    Write-Host $helloworld -ForegroundColor $foreground -BackgroundColor $background
}

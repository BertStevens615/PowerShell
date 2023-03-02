<#
.SYNOPSIS
  These are some of my frequently used parts of code.

.DESCRIPTION
  This script should not be run as a stand alone script. It
  contains pieces of code that I frequently use. A good coder
  is a lazy coder. :)

.NOTES
	Author: Bert Stevens | bertstevens615@gmail.com
#>

###################################################################################

<#
# The acceptable values for this parameter are:
-ForegroundColor
-BackgroundColor
    Black
    DarkBlue
    DarkGreen
    DarkCyan
    DarkRed
    DarkMagenta
    DarkYellow
    Gray
    DarkGray
    Blue
    Green
    Cyan
    Red
    Magenta
    Yellow
    White
#>

# Splat variables for changing text color.
$Green = @{
    "ForegroundColor" = "Green"
}
$Yellow = @{
    "ForegroundColor" = "Yellow"
}
$Red = @{
    "ForegroundColor" = "Red"
}
$Cyan = @{
    "ForegroundColor" = "Cyan"
}
$DarkRed = @{
    "ForegroundColor" = "DarkRed"
}
$Black = @{
    "ForegroundColor" = "Black"
    "BackgroundColor" = "White"
}
$White = @{
    "ForegroundColor" = "White"

}


###################################################################################


#### How to write a colorized Read-Host in a variable ####
$Domain = $(Write-Host "Enter the new domain name for all users" @Green -NoNewLine) + $(Write-Host " (i.e. 'conteso.com'): " @Yellow -NoNewLine; Read-Host)


###################################################################################
$Folder = "c:\temp\foldername

# Create working folder, if needed.
[System.IO.Directory]::CreateDirectory("$Folder")

or

# Create working folder, if needed.
If(!(test-path -PathType container $Folder))
{
      New-Item -ItemType Directory -Path $Folder
}


###################################################################################


# Create a taskbar notification.
[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
[reflection.assembly]::loadwithpartialname('System.Drawing')
$notify = new-object system.windows.forms.notifyicon
$notify.icon = [System.Drawing.SystemIcons]::Information
$notify.visible = $true
$notify.showballoontip(10,'RESTART','Please restart your computer to complete recent changes.',[system.windows.forms.tooltipicon]::None)


###################################################################################

# Check if the current user is an administrator. Relaunch elevated if not.
Write-Host `n"Checking to see if PowerShell is in an elevated session." @Cyan
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Not Running as Administrator, Attempting to Elevate..." @Yellow
    Start-Sleep -Seconds 3
    # Save the current script path and arguments
    $scriptPath = $myinvocation.mycommand.path
    $scriptArgs = $args

    # Relaunch the script with administrator privileges
    Start-Process pwsh -Verb runAs -ArgumentList "-File `"$scriptPath`" $scriptArgs"
    exit
} else { 
    Write-Host "Running as administrator." @Green
    }

###################################################################################


#### Create a message box ####
[System.Windows.Forms.Application]::EnableVisualStyles()
$btn = [System.Windows.Forms.MessageBoxButtons]::OK
#$ico = [System.Windows.Forms.MessageBoxIcon]::Information
$Title = 'Additional Module Required'
$Message = 'Would you like to proceed'
#$msgBoxInput = [System.Windows.Forms.MessageBox]::Show($Message, $Title, 'YesNoCancel', $ico)
$msgBoxInput = [System.Windows.Forms.MessageBox]::Show($Message, $Title, $btn)
#$msgBoxInput =  [System.Windows.MessageBox]::Show('Would you like to proceed?', 'Confirmation', 'YesNoCancel','Error'), 

switch  ($msgBoxInput) {

    'Yes' {
    	## Action Here
    }
    'No' {
    	## Action Here
    }
    'Cancel' {
    	## Action Here
    }

}


###################################################################################

#### How to write multiple actions off an import ####
Import-Csv $FilePath | % {        # "%" is an alias of ForEach-Object
   Get-AzureADUser -ObjectID $_.ObjectId | Set-AzureADUser -AccountEnabled $false
   Set-AzureADUser -ObjectID $_.ObjectId | Revoke-AzureADUserAllRefreshToken
   Get-AzureADUserRegisteredDevice -ObjectId $_.ObjectId  | Set-AzureADDevice -AccountEnabled $false
   Get-AzureADUser -ObjectID $_.ObjectId | Select DisplayName,Mail,AccountEnabled,RefreshTokensValidFromDateTime
    }


###################################################################################


# Request the user's username and password with powershell dialog and then use in the script
$creds = $host.ui.PromptForCredential("Need credentials", "Please enter you VPN username and password.", "", "")
    $username = $creds.username
    $password = $creds.GetNetworkCredential().password


###################################################################################

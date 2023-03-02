<#
.SYNOPSIS
  These are code snippets to install and connect to a service.

.DESCRIPTION
  This script should not be run by itself. These code snippets are
  to be added to other scripts. They will test for the listed service,
  install if needed, and then connect to that service

.NOTES
	Author: Bert Stevens | bertstevens615@gmail.com
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


#####################################################################################
# Check if needed module is installed. If so, connect. If not, install then connect.
#####################################################################################

# AzureAD - Connect to the AzureAD service. Install the module if needed. 
if (Get-Module -ListAvailable -Name AzureAD) {
    Write-Host "Conneting to Azure AD Online Service" @Green
    Connect-AzureAD  
} 
else {
    Write-Host "AzureAD required. Now installing" @Yellow
    Install-Module -Name AzureAD -Scope AllUsers -Force 
     Write-Host "Conneting to Azure AD Online Service" @Cyan
    Connect-AzureAD
}  


# ExchangeOnline - Connect to the Exchange Online Service. Install the module if needed. 
if (Get-Module -ListAvailable -Name ExchangeOnlineManagement) {
    Write-Host "Conneting to Exchange Online Service" @Green
    Connect-ExchangeOnline
} 
else {
    Write-Host "ExchangeOnline required. Now installing" @Yellow
    Install-Module -Name ExchangeOnlineManagement -Scope AllUsers -Force 
     Write-Host "Conneting to Exchange Online Service" @Cyan
    Connect-ExchangeOnline
}


# Microsoft Graph - Connect to the Microsoft Graph service. Install the module if needed. 
if (Get-InstalledModule Microsoft.Graph) {
    Write-Host "Conneting to Microsoft Graph Service" @Green
    Connect-MgGraph -Scopes "User.Read.All","UserAuthenticationMethod.Read.All"
    } 
else {
    Write-Host "Microsoft Graph required. Now installing" @Yellow
    Install-Module Microsoft.Graph -AllowClobber -Scope AllUsers -Force  -All
    Write-Host "Conneting to Microsoft Graph Service" @Cyan
    Connect-MgGraph -Scopes "User.Read.All","UserAuthenticationMethod.Read.All"
    }

# MSOnline - Connect to the MS Online Service. Install the module if needed. 
if (Get-Module -ListAvailable -Name MSOnline) {
    Write-Host "Conneting to MS Online Service" @Green
    Connect-MsolService
} 
else {
    Write-Host "MSOnline required. Now installing" @Yellow
    Install-Module -Name Msonline -Scope AllUsers -Force 
     Write-Host "Conneting to MS Online Service" @Cyan
    Connect-MsolService
}


# Security & Compliance - Connect to the Security and Compliance service. Install the module if needed.
if (Get-Module -ListAvailable -Name IPPSSession) {
    Write-Host "Conneting to IPPSSession Online Service" @Green
    Import-Module ExchangeOnlineManagement
    Connect-IPPSSession  
} 
else {
    Write-Host "AzureAD required. Now installing" @Yellow
    Install-Module -Name IPPSSession -Scope AllUsers -Force 
    Write-Host "Conneting to IPPSSession Online Service" @Cyan
    Import-Module ExchangeOnlineManagement
    Connect-IPPSSession
}  


# SPOService - Connect to the SharePoint Online service. Install the module if needed. 
$AdminSiteURL = $(Write-Host "Enter the new SharePoint admin domain." @Green -NoNewLine) + $(Write-Host " (i.e. 'conteso-admin.sharepoint.com'): " @Yellow -NoNewLine; Read-Host)

if (Get-Module -ListAvailable -Name Microsoft.Online.SharePoint.PowerShell) {
    Write-Host "Conneting to SharePoint Online Service" @Green
    Connect-SPOService -Url $AdminSiteURL 
} 
else {
    Write-Host "MSOnline required. Now installing" @Yellow
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope AllUsers -Force 
     Write-Host "Conneting to SharePoint Online Service" @Cyan
    Connect-SPOService -Url $AdminSiteURL 
}  


###################################################################################

#365 Modules install 
install-module AzureAD
install-module MSOnline
Install-Module -Name MicrosoftTeams
Install-Module -Name TAK
install-module -name Microsoft.Online.SharePoint.PowerShell

#after install for any new session 
Import-Module AzureAD
Import-Module MSOnline
Import-Module MicrosoftTeams
Import-Module Tak
import-module Microsoft.Online.SharePoint.PowerShell

#365 connect
#https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell
Connect-MsolService

#teams connect
Connect-MicrosoftTeams

#sharepoint connect 
#https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps
$adminUPN="<the full email address of a SharePoint administrator account, example: jdoe@contosotoycompany.onmicrosoft.com>"
$orgName="<name of your Office 365 organization, example: contosotoycompany>"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

#Exchange
$UserCredential = Get-Credential
$ProxyOptions = New-PSSessionOption -ProxyAccessType ieconfig
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic –AllowRedirection –SessionOption $proxyOptions
Import-PSSession $Session –DisableNameChecking
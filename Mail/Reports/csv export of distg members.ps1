#requires -version 5
<#
.SYNOPSIS
CSV export of Dist G members 
.DESCRIPTION
  CSV export of Dist G members 

.PARAMETER 
n/a
.INPUTS
  Blank csv 
.OUTPUTS
 CSV Report 
.NOTES
  Version:        1.0
  Author:         Pknowles
  Creation Date:  TBC
  Purpose/Change: Initial script development
.EXAMPLE

.Ref
    https://gallery.technet.microsoft.com/scriptcenter/Write-Log-PowerShell-999c32d0
    https://9to5it.com/powershell-script-template-version-2/
  #>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------
#Import Modules & Snap-ins

#----------------------------------------------------------[Declarations]----------------------------------------------------------
#Any Global Declarations go here

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'
#Static Variables for  Logging Function

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

$Outputfile = 'D:\o365dlmembers.csv'


#Prepare Output file with headers
Out-File -FilePath $OutputFile -InputObject "Distribution Group DisplayName,Distribution Group Email,Member DisplayName, Member Email, Member Type" -Encoding UTF8

#Get all Distribution Groups from Office 365
$objDistributionGroups = Get-DistributionGroup -ResultSize Unlimited

#Iterate through all groups, one at a time
Foreach ($objDistributionGroup in $objDistributionGroups)
{

    write-host "Processing $($objDistributionGroup.DisplayName)..."

    #Get members of this group
    $objDGMembers = Get-DistributionGroupMember -Identity $($objDistributionGroup.PrimarySmtpAddress)

    write-host "Found $($objDGMembers.Count) members..."

    #Iterate through each member
    Foreach ($objMember in $objDGMembers)
    {
        Out-File -FilePath $OutputFile -InputObject "$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)" -Encoding UTF8 -append
        write-host "`t$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)"
    }
}
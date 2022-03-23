#requires -version 5
<#
.SYNOPSIS
  import users to distg
.DESCRIPTION
  import users to distg
.PARAMETER 
n/a
.INPUTS
  exchange displayname and distgroup identity in a csv  
.OUTPUTS
 users added to dist group 
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

Import-Csv .\StaffForDistGroup.csv | ForEach {Add-DistributionGroupMember -Identity $_.distributiongroup -Member $_.displayname}
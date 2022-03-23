#requires -version 5
<#
.SYNOPSIS
  Teams Users /Chanel Scrape 
.DESCRIPTION
  Scrapes Teams for users/owners in teams channels 
.PARAMETER 
  n/a
.INPUTS
  Teams 
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


$teams = get-team
$OutputPath = 'C:\temp\Teams-Report.csv'

foreach ($team in $teams)
{
    $teamowner = Get-TeamUser -GroupId $team.groupid | where-object {$_.role -eq "Owner"}
    $teamguest = Get-TeamUser -GroupId $team.groupid | where-object {$_.role -ne "Owner"}
    $teamchannels = Get-TeamChannel -GroupId $team.groupid
    foreach ($teamchannel in $teamchannels)
    {

    $csvoutput = @(
        [pscustomobject]@{
           TeamName = $team.displayname
           TeamDescription = $team.Description
            TeamVisibility = $team.Visibility
            TeamArchieved = $team.Archived
            TeamMailNickname = $team.MailNickName
           TeamChannel = $teamchannel.displayname
            TeamChannelDescription = $teamchannel.description
           TeamOwnerMail = ($teamowner.user -join ";")
           TeamOwnerName = ($teamowner.name -join ";")
           TeamNotOwnerMail = ($teamguest.mail -join ";")
           TeamNotOwnerName = ($teamguest.name -join ";")
        })

     $csvoutput | Export-CSV $OutputPath -Append -Force -notypeinformation -noclobber




    }


    }
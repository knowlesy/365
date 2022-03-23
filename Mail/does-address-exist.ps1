#requires -version 5
<#
.SYNOPSIS
    Does email address exist already 
.DESCRIPTION
    Checks if email exists within exchange as a contact/group/mailbox

.PARAMETER 
n/a
.INPUTS
  list of email addresses line by line 
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
$content = Get-Content 'c:\temp\maillist.txt'
$OutputPath = 'c:\temp\doesitexist.csv'
foreach ($mail in $content) {

    $Checkmailbox = Get-Mailbox $mail -ErrorAction silentlycontinue
    $CheckContact = Get-mailcontact $mail -ErrorAction silentlycontinue
    $CheckDistG = Get-DistributionGroup $mail -ErrorAction silentlycontinue
    $CheckUser = get-mailuser $mail -ErrorAction silentlycontinue
    
    if (($Checkmailbox | Measure-Object).Count -eq 1) {
        Write-Host ('Mailbox found: ' + $mail) -ForegroundColor Green
        $ExcelMailbox = 'True'
    }
    else {
        Write-Host ('Mailbox NOT found: ' + $mail) -ForegroundColor Yellow
        $ExcelMailbox = 'False'
    }
    if (($Checkcontact | Measure-Object).Count -eq 1) {
        Write-Host ('contactfound: ' + $mail) -ForegroundColor Green
        $Excelcontact = 'True'
    }
    else {
        Write-Host ('contact NOT found: ' + $mail) -ForegroundColor Yellow
        $Excelcontact = 'False'
    }
    if (($CheckDistG | Measure-Object).Count -eq 1) {
        Write-Host ('DistG found: ' + $mail) -ForegroundColor Green
        $ExcelDistG = 'True'
    }
    else {
        Write-Host ('DistG NOT found: ' + $mail) -ForegroundColor Yellow
        $ExcelDistG = 'False'
    }
    if (($CheckUser | Measure-Object).Count -eq 1) {
        Write-Host ('User found: ' + $mail) -ForegroundColor Green
        $ExcelUser = 'True'
    }
    else {
        Write-Host ('User NOT found: ' + $mail) -ForegroundColor Yellow
        $ExcelUser = 'False'
    }

    $csvoutput = @(
        [pscustomobject]@{
            Address = $mail
            Mailbox = $ExcelMailbox
            Contact = $Excelcontact
            DistG   = $ExcelDistG
            User    = $ExcelUser

        })

    $csvoutput | Export-Csv $OutputPath -Append -Force

}

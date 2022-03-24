$users = get-Content "d:\Temp\userlist.txt"
$OutputPath = 'd:\temp\usersarchive.csv'
foreach ($user in $users) {
    $archivecheck = Get-MailboxStatistics -Identity $user -Archive | select displayname
    
    $csvoutput = @(
    [pscustomobject]@{
        Name =  $user

        ArchiveResponse = $archivecheck.displayname
       
            

    })

 

$csvoutput | Export-CSV $OutputPath -Append -Force

}

$GBTOTAL = get-mailbox |select -expand userprincipalname |Get-MailboxStatistics | Select-Object DisplayName, IsArchiveMailbox, ItemCount, @{name=”GB”;expression={[math]::Round((($_.TotalItemSize.Value.ToString()).Split(“(“)[1].Split(” “)[0].Replace(“,”,””)/1GB),2)}}
$GBTOTAL.gb | Measure-Object -Sum | select sum

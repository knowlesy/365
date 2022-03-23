Get-Mailbox | Where-object { $_.IsResource –eq ‘true’ } | select displayname,resourcetype,PrimarySmtpAddress,alias,EmailAddresses,ExchangeVersion,UsageLocation,RecipientTypeDetails | Export-Csv C:\Temp\resourcemailbox.csv -NoClobber -NoTypeInformation




RecipientTypeDetails   GroupMailbox


Get-Recipient -filter {RecipientTypeDetails-like "GroupMailbox"} -ResultSize Unlimited 


Get-Recipient -ResultSize Unlimited | where ($_.RecipientTypeDetails -like "GroupMailbox") 
$username = "ADSyncService@cnu.edu"
$password = ConvertTo-SecureString "803887bBf0!" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-MSolService -Credential $psCred
Get-MsolUser -All | Where-Object {$_.usagelocation -ne "US"} | Set-MsolUser -UsageLocation "US"
Get-MsolUser -All | Where { -Not $_.UserPrincipalName.ToLower().StartsWith(“admin@”) } | ForEach { Set-MsolUserPrincipalName -ObjectId $_.ObjectId -NewUserPrincipalName ($_.UserPrincipalName.Split(“@”)[0] +  “@cnu.edu”) }

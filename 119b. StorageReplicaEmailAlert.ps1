# Get the event information from the Windows Event Log
$EventID = 5014
$EventAdmin = Get-WinEvent -MaxEvents 1 -FilterHashtable @{Logname = "Microsoft-Windows-StorageReplica/Admin"; ID = $EventID}

# Get the name of the server where the event occurred and the time the event was created
$ServerName = $EventAdmin.MachineName
$EventCreated = $EventAdmin.TimeCreated
$EventLevel = $EventAdmin.LevelDisplayName

# Configure sender
$User = 'sender@email.com'
$PWord = ConvertTo-SecureString -String 'pass' -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Get the status of all Storage Replica groups on the server
$M = Get-SRGroup | Format-List -Property Name, ReplicationMode, ReplicationStatus
$SRMsg = Out-String -InputObject $M

# Create two email messages
$Sub = "Storage Replica: $EventLevel Created Time: $EventCreated Created on: $ServerName"
$TimeSR = Date

Send-MailMessage -From 'sender@email.com' -Credential $Cred -To 'receiver1@email.com' -Cc 'receiver2@email.com','receiver3@email.com' -Subject $Sub -Body $EventMessage -SmtpServer X.X.X.X -Port 587
Send-MailMessage -From 'sender@email.com' -Credential $Cred -To 'receiver1@email.com' -Cc 'receiver2@email.com','receiver3@email.com' -Subject 'Get-SRGroup output' -Body $SRMsg -SmtpServer X.X.X.X -Port 587

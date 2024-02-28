# This script will check the space of D & F and send mail. Change the drive letter as per your configuration

# Get the available space on drives D and F
$Volout = Get-Volume -DriveLetter D,F | Format-List -Property DriveLetter, Size, SizeRemaining
$VolMsg = Out-String -InputObject $Volout

# Get the status of all Storage Replica groups
$SRM = Get-SRGroup | Format-List -Property Name, ReplicationMode, ReplicationStatus
$SRMsg = Out-String -InputObject $SRM

# Combine the volume and SR group messages
$MailBody = $VolMsg + $SRMsg

# Configure the email credentials
$User = 'sender@email.com'
$PWord = ConvertTo-SecureString -String 'pass' -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Send the email
Send-MailMessage -From 'sender@email.com' -Credential $Cred -To 'receiver1@email.com' -Cc 'receiver2@email.com','receiver3@email.com' -Subject 'Disk Space (D,F) and Replication Status of Vault1' -Body $MailBody -SmtpServer X.X.X.X -Port 587

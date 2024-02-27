## Add member to event log readers group ##
Add-ADGroupMember -Identity 'Event Log Readers' -Members 'REBELNET-PDC01$'

# Reviewing events with PowerShell
## will list the details about the log files in your local system, including the log file name, max log file size, and number of entries ##
Get-EventLog -List

## List all the events under the Directory Service log file ##
Get-EventLog -LogName 'Directory Service' | Format-List

## List latest 5 events ##
Get-EventLog -Newest 5 -LogName 'Directory Service'

## List latest 5 events - Errors ##
Get-EventLog -Newest 5 -LogName 'Directory Service' -EntryType Error

## List latest 5 events with in last 24 hours ##
Get-EventLog -Newest 5 -LogName 'Directory Service' -EntryType Error -After (Get-Date).AddDays(-1)

## List latest 5 events from given source ##
Get-EventLog -Newest 5 -LogName 'Directory Service' -ComputerName 'REBEL-SDC01' | Format-List -Property *

## List latest 5 events from multiple sources ##
Get-EventLog -Newest 5 -LogName 'Directory Service' -ComputerName "localhost","REBEL-SDC01"

## list the events with the source NTDS KCC ##
Get-EventLog -LogName 'Directory Service' -Source 'NTDS KCC'

## list the events with eventID as 1000 ##
Get-EventLog -LogName 'Directory Service' | Where-Object {$_.eventID -eq 1000}
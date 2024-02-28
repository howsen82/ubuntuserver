# Export Application Events to CSV
Get-EventLog -LogName Application | Export-CSV C:\Logs\Application_Logs.csv

# Export Top 100 events record to CSV
Get-EventLog -LogName System -Newest 100 | Export-CSV C:\Logs\System_Logs_Newest.csv

# Export Top 50 security events to CSV
Get-EventLog -LogName Security -Newest 50 -ComputerName WEB1 | Export-CSV C:\Logs\WEB1_Security_Logs.csv
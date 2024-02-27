## Replication Faliures ##
Get-ADReplicationFailure -Target 'REBEL-SDC01'

## Check Multiple Servers for replication faliures ##
Get-ADReplicationFailure -Target 'REBEL-SDC01,REBELNET-PDC01'

## Target all the domain controllers in domain ##
Get-ADReplicationFailure -Target "therebeladmin.com" -Scope Domain

## Target all the domain controllers in forest ##
Get-ADReplicationFailure -Target " therebeladmin.com" -Scope Forest

## List all the partner details ##
Get-ADReplicationConnection -Filter *

## Filter replication connections ##
Get-ADReplicationConnection -Filter {ReplicateToDirectoryServer -eq "REBEL-SDC01"}

## Force sync object ##
Sync-ADObject -object "adam" -source 'REBEL-SDC01' -destination 'REBELNET-PDC01'

## Check AD Connect tool connectivity ##
Invoke-WebRequest -Uri https://login.microsoftonline.com
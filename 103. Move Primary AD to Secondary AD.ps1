# Check current FSMO role holder
netdom query fsmo

# Move AD
Move-ADDirectoryServerOperationMasterRole -Identity REBEL-SDC02 -OperationMasterRole PDCEmulator, RIDMaster, InfrastructureMaster
# Move All
Move-ADDirectoryServerOperationMasterRole -Identity REBEL-SDC02 -OperationMasterRole SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster, InfrastructureMaster
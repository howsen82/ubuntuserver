### Demoting while the old server is still online
1. Open **Server Manager**
2. **Manage > Remove Roles and Features**
3. Make sure your old server is selected
4. Uncheck **Active Directory Domain Services**
5. If this server is also a DNS server, it is easiest if you remove the DNS Server role before accomplishing the AD DS removal
6. You will receive a pop-up with Validation Results. On this screen, click the link to **Demote this domain controller**
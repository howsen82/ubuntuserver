# 1. Create a VM
New-VM -VMName Windows11 -MemoryStartupBytes 1024MB

# 2. Create virtual hard drive
New-VHD -Path “C:\users\Public\Documents\Hyper-v\Virtual Hard Disks\Windows11.vhdx" -Sizebytes 50GB -Fixed

# 3. Attached virtual hard drive to VM
Add-VMHardDiskDrive -VMName Windows11 -Path "C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\Windows11.vhdx" -ControllerType IDE -ControllerNumber 0 -ControllerLocation 1

# 4. Configure internal virtual switch
New-VMSwitch -Name InternalSwitch -SwitchType Internal

# 5. Connect network adapter to internal virtual switch
Connect-VMNetworkAdapter -VMName Windows11 -VMNetworkAdaptername "Network Adapter" -SwitchName "InternalSwitch"

# 6. Set ISO image file to VM
Set-VMDvdDrive -VMName Windows11 -ControllerNumber 1 -Path "C:\ISO Images\Windows11.ISO"
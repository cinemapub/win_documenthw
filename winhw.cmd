@echo off
setlocal
set output1=.\%computername%.winhw.txt
set output2=.\%computername%.sysinfo.txt

echo Creating %output1% ...
(
echo ## ComputerSystem
wmic ComputerSystem get Caption,ChassisSKUNumber,DNSHostName,Domain,EnableDaylightSavingsTime,HypervisorPresent,Manufacturer,Model,Name,NumberOfLogicalProcessors,NumberOfProcessors,OEMStringArray,PartOfDomain,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory,UserName /format:list

echo ## Bios
wmic BIOS get BIOSVersion,CurrentLanguage,Manufacturer,ReleaseDate,SerialNumber,SMBIOSBIOSVersion,Version /format:list

echo ## Os
WMIC OS get BootDevice,BuildNumber,Caption,CSName,Description,InstallDate,Locale,MUILanguages,Name,OperatingSystemSKU,OSArchitecture,SerialNumber,SystemDevice,SystemDrive,TotalVirtualMemorySize,TotalVisibleMemorySize,Version /format:list

echo ## Disks
wmic LogicalDisk where drivetype!=4 get deviceid,description,volumename,size,FreeSpace,VolumeSerialNumber
wmic LogicalDisk list brief

echo ## CPU
wmic Cpu get MaxClockSpeed,AddressWidth,NumberOfLogicalProcessors,NumberOfCores,Description,Name /value

echo ## Memory
WMIC MemoryChip get Speed,Capacity,DeviceLocator,Manufacturer,Model,Name,Partnumber


echo ## Screens
wmic DESKTOPMONITOR get Caption,Description,Name,ScreenHeight,ScreenWidth,DeviceID,MonitorManufacturer
wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution,Name,VideoProcessor,VideoModeDescription,DriverDate

echo ## Printers
WMIC PRINTER LIST brief

echo ## Software
WMIC PRODUCT GET name,vendor,version,InstallDate,InstallLocation | sort /r

) | findstr /v /r "^$" > %output1%

echo Creating %output2% ...

systeminfo /fo list > %output2%

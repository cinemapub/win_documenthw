@echo off
setlocal
set output1=.\%computername%.winhw.txt
set output2=.\%computername%.sysinfo.txt

(
echo ## ComputerSystem
wmic COMPUTERSYSTEM get Caption,ChassisSKUNumber,DNSHostName,Domain,EnableDaylightSavingsTime,HypervisorPresent,Manufacturer,Model,Name,NumberOfLogicalProcessors,NumberOfProcessors,OEMStringArray,PartOfDomain,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory,UserName /format:list

echo ## Bios
wmic BIOS get BIOSVersion,CurrentLanguage,Manufacturer,ReleaseDate,SerialNumber,SMBIOSBIOSVersion,Version /format:list

echo ## Os
WMIC OS get BootDevice,BuildNumber,Caption,CSName,Description,InstallDate,Locale,MUILanguages,Name,OperatingSystemSKU,OSArchitecture,SerialNumber,SystemDevice,SystemDrive,TotalVirtualMemorySize,TotalVisibleMemorySize,Version /format:list

echo ## Disks
wmic LOGICALDISK where drivetype!=4 get deviceid, description, volumename /value

echo ## Printers
WMIC PRINTER LIST brief

echo ## Software
WMIC PRODUCT GET name,vendor,version,InstallDate,InstallLocation | sort /r


) | findstr /v /r "^$" > %output1%

systeminfo /fo list > %output2%

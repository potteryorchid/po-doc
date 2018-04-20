# dmidecode 概述
dmidecode命令可以让你在Linux系统下获取有关硬件方面的信息。dmidecode的作用是将DMI数据库中的信息解码，以可读的文本方式显示。由于DMI信息可以人为修改，因此里面的信息不一定是系统准确的信息。dmidecode遵循SMBIOS/DMI标准，其输出的信息包括BIOS、系统、主板、处理器、内存、缓存等等。

DMI（Desktop Management Interface,DMI）就是帮助收集电脑系统信息的管理系统，DMI信息的收集必须在严格遵照SMBIOS规范的前提下进行。SMBIOS（System Management BIOS）是主板或系统制造者以标准格式显示产品管理信息所需遵循的统一规范。SMBIOS和DMI是由行业指导机构Desktop Management Task Force(DMTF)起草的开放性的技术标准，其中DMI设计适用于任何的平台和操作系统。

DMI充当了管理工具和系统层之间接口的角色。它建立了标准的可管理系统更加方便了电脑厂商和用户对系统的了解。DMI的主要组成部分是Management Information Format(MIF)数据库。这个数据库包括了所有有关电脑系统和配件的信息。通过DMI，用户可以获取序列号、电脑厂商、串口信息以及其它系统配件信息。

# 命令使用说明 
dmidecode [OPTIONS]
 Options are:
 -d, --dev-mem FILE     Read memory from device FILE (default: /dev/mem) 默认dmidecode解析的信息文件存储位置
 -h, --help             Display this help text and exit
 -q, --quiet            Less verbose output
 -s, --string KEYWORD   Only display the value of the given DMI string
 -t, --type TYPE        Only display the entries of given type
 -u, --dump             Do not decode the entries
     --dump-bin FILE    Dump the DMI data to a binary file
     --from-dump FILE   Read the DMI data from a binary file
 -V, --version          Display the version and exit


######### KEYWORDS 可选参数 #######
bios-vendor
bios-version
bios-release-date
system-manufacturer
system-product-name
system-version
system-serial-number
system-uuid
baseboard-manufacturer
baseboard-product-name
baseboard-version
baseboard-serial-number
baseboard-asset-tag
chassis-manufacturer
chassis-type
chassis-version
chassis-serial-number
chassis-asset-tag
processor-family
processor-manufacturer
processor-version
processor-frequency


######### TYPE 可选参数 #######
bios
system
baseboard
chassis
processor
memory
Cache
connector
slot



######### ALL TYPE 参数 Use by grep #######
BIOS
System
Base Board
Chassis
Processor
Memory Controller
Memory Module
Cache
Port Connector
System Slots
On Board Devices
OEM Strings
System Configuration Options
BIOS Language
Group Associations
System Event Log
Physical Memory Array
Memory Device
32-bit Memory Error
Memory Array Mapped Address
Memory Device Mapped Address
Built-in Pointing Device
Portable Battery
System Reset
Hardware Security
System Power Controls
Voltage Probe
Cooling Device
Temperature Probe
Electrical Current Probe
Out-of-band Remote Access
Boot Integrity Services
System Boot
64-bit Memory Error
Management Device
Management Device Component
Management Device Threshold Data
Memory Channel
IPMI Device
Power Supply
Additional Information
Onboard Device


######### Excemple #######

#查看服务器型号
dmidecode | grep 'Product Name'
#查看主板的序列号
dmidecode |grep 'Serial Number'
#查看系统序列号
dmidecode -s system-serial-number
#查看内存信息
dmidecode -t memory
#查看OEM信息
dmidecode -t 11

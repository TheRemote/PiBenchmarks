#!/bin/bash
# Storage benchmark by James A. Chambers (https://www.jamesachambers.com/)
# Benchmarks your storage and anonymously submits result to jamesachambers.com
# I'm hoping to build a good dataset for us to figure out the best options for Pi storage
# This is especially true for MicroSD cards which are shrouded in an industry of NDAs / mystery / shenanigans

# Terminal colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# Prints a line with color using terminal codes
Print_Style () {
    printf "%s\n" "${2}$1${NORMAL}"
}

# Get binary from string
Get_Binary () {
    local BinaryStr=$(printf "$1" | xxd -r -p | xxd -b | cut -d: -f 2 | sed 's/  .*//; s/ //g' | sed ':a;N;$!ba;s/\n//g')
    echo "$BinaryStr"
}

# Get specific bits from binary string
Get_Bits () {
    # $1 - Binary String
    # $2 - BitsStart
    # $3 - BitsCount
    # $4 - Structure size in bits
    local BitsStart=$(( $4 - $2 - $3 ))
    local BinaryStr=$(printf "$1")
    echo "${BinaryStr:BitsStart:$3}"
}

# Get decimal from binary
Get_Decimal () {
    echo "$((2#$1))"
}

# Get hex from binary
Get_Hex () {
    printf '%x\n' "$((2#$1))"
}

# Check if script is running as root first
if [[ "$(whoami)" != "root" ]]; then
  Print_Style "Benchmarks must be ran as root!  Example: sudo ./Storage.sh" $RED
  exit 1
fi

# Install required components from apt
Print_Style "Fetching required components ..." $YELLOW
apt-get install hdparm build-essential wget curl fio libraspberrypi-bin bc -y

# Retrieve and build iozone
if [ ! -f iozone/src/current/iozone ]; then
  Print_Style "Building iozone ..." $YELLOW
  wget -O iozone.html "http://www.iozone.org"
  DownloadURL=$(grep -m 1 -o 'src/current/iozone3_[^"]*' iozone.html)
  rm iozone.html
  wget -O iozone.tar "http://www.iozone.org/$DownloadURL"
  tar -xf iozone.tar
  rm iozone.tar
  mv iozone3_* iozone
  cd iozone/src/current
  make --quiet linux-arm
  cd ../../..
fi

# Get system boot drive information
BootDrive=$(df | grep boot | awk 'NR==1{ print $1 }')
Print_Style "System drive has been detected as $BootDrive" $YELLOW
BootDriveInfo=$(udevadm info -a -n $BootDrive | sed '/^[[:space:]]*$/d')
Capacity=$(df -H | grep "/dev/root" | awk 'NR==1{ print $2 }')

# Check for MicroSD card
if [[ "$BootDrive" == *"mmcblk"* ]]; then
  # Attempt MicroSD hardware identification
  HostSDClock=$(grep "actual clock" /sys/kernel/debug/mmc0/ios 2>/dev/null | awk '{printf("%0.1f", $3/1000000)}')
  
  # Get Manufacturer and check against known ones
  Manufacturer=$(echo "$BootDriveInfo" | grep -m 1 "manfid" | cut -d= -f3 | cut -d\" -f2 | xargs)
  case "$Manufacturer" in
    0x000001)
      Manufacturer="Panasonic"
      ;;
    0x000002)
      Manufacturer="Toshiba"
      ;;
    0x000003)
      Manufacturer="SanDisk"
      ;;
    0x00001b)
      Manufacturer="Samsung"
      ;;
    0x00001d)
      Manufacturer="AData"
      ;;
    0x000027)
      Manufacturer="Phison"
      ;;
    0x000028)
      Manufacturer="Lexar"
      ;;
    0x000031)
      Manufacturer="Silicon Power"
      ;;
    0x000041)
      Manufacturer="Kingston"
      ;;
    0x000074)
      Manufacturer="Transcend"
      ;;
    0x000076)
      Manufacturer="Patriot"
      ;;
    0x000082)
      Manufacturer="Sony"
      ;;
    *)
      Manufacturer="Unknown"
      ;;
  esac

  # Identify vendor
  Vendor=$(echo "$BootDriveInfo" | grep -m 1 "oemid" | cut -d= -f3 | cut -d\" -f2 | xargs | xxd -r)
  case "$Vendor" in
    SD)
      Vendor="SanDisk"
      ;;
    PA)
      Vendor="Panasonic"
      ;;
    SM)
      Vendor="Samsung"
      ;;
    TM)
      Vendor="Toshiba"
      ;;
    AD)
      Vendor="AData"
      ;;
    BE)
      Vendor="Lexar"
      ;;
    PH)
      Vendor="Phison"
      ;;
    SP)
      Vendor="Silicon Power"
      ;;
    42)
      Vendor="Kingston"
      ;;
    JT)
      Vendor="Sony"
      ;;
    *)
      ;;
  esac

  Product="Micro SD"
  Firmware=$(echo "$BootDriveInfo" | grep -m 1 "{fwrev}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  DateManufactured=$(echo "$BootDriveInfo" | grep -m 1 "date" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Model=$(echo "$BootDriveInfo" | grep -m 1 "{name}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Version=$(echo "$BootDriveInfo" | grep -m 1 "{hwrev}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  SSR=$(echo "$BootDriveInfo" | grep -m 1 "{ssr}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  SCR=$(echo "$BootDriveInfo" | grep -m 1 "{scr}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  CID=$(echo "$BootDriveInfo" | grep -m 1 "{cid}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  CSD=$(echo "$BootDriveInfo" | grep -m 1 "{csd}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  OCR=$(echo "$BootDriveInfo" | grep -m 1 "{ocr}" | cut -d= -f3 | cut -d\" -f2 | xargs)
  SSRBinary=$(Get_Binary $SSR)
  SSRAppClass=$(Get_Decimal $(Get_Bits $SSRBinary 336 4 512))
  SSRVideoClass=$(Get_Decimal $(Get_Bits $SSRBinary 384 8 512))
  SSRUHSClass=$(Get_Decimal $(Get_Bits $SSRBinary 396 4 512))
  SSRSpeedClass=$(Get_Decimal $(Get_Bits $SSRBinary 440 8 512))
  Class=""
  if [[ $SSRAppClass > 0 ]]; then
    Class="A$SSRAppClass"
  fi
  case "$SSRSpeedClass" in
    0)
      Class="$Class Class 0"
      ;;
    1)
      Class="$Class Class 2"
      ;;
    2)
      Class="$Class Class 4"
      ;;
    3)
      Class="$Class Class 6"
      ;;
    4)
      Class="$Class Class 10"
      ;;
    *)
      Class="$Class ?"
      ;;
  esac
  if [[ $SSRVideoClass > 0 ]]; then
    Class="$Class V$SSRVideoClass"
  fi
  if [[ $SSRUHSClass > 0 ]]; then
    Class="$Class U$SSRUHSClass"
  fi
  Class=$(echo "$Class" | xargs)
  Print_Style "MicroSD information: Manufacturer: $Manufacturer - Model: $Model - Vendor: $Vendor - Product: $Product - HW Version: $Version - FW Version: $Firmware - Date Manufactured: $DateManufactured" $YELLOW
  Print_Style "Class: $Class" $YELLOW
else
  # Not a MicroSD card
  BootDriveInfo+=$(hdparm -I $BootDrive)
  HostSDClock="N/A"
  # Attempt to identify drive
  Manufacturer=$(echo "$BootDriveInfo" | grep -m 1 "manufacturer" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Vendor=$(echo "$BootDriveInfo" | grep -m 1 "vendor" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Product=$(echo "$BootDriveInfo" | grep -m 1 "product" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Model=$(echo "$BootDriveInfo" | grep -m 1 "Model Number:" | awk 'NR==1{ print $3 $4 $5 }')
  Version=$(echo "$BootDriveInfo" | grep -m 1 "version" | cut -d= -f3 | cut -d\" -f2 | xargs)
  Firmware=$(echo "$BootDriveInfo" | grep -m 1 "Firmware Revision:" | awk 'NR==1{ print $3 $4 $5 }')
  Print_Style  "Drive information: Manufacturer: $Manufacturer - Model: $Model - Vendor: $Vendor - Product: $Product - HW Version: $Version - FW Version: $Firmware - Date Manufactured: $DateManufactured" $YELLOW
fi

# Get host board information
HostModel=$(tr -d '\0' </proc/device-tree/model)
HostArchitecture=$(uname -m)
HostOSInfo=$(cat /etc/os-release)
HostOS=$(echo "$HostOSInfo" | grep "PRETTY_NAME" | cut -d= -f2 | xargs)

# Check for vcgencmd
if [ -n "`which vcgencmd`" ]; then
  HostConfig=$(vcgencmd get_config int)
  HostCPUClock=$(echo "$HostConfig" | grep arm_freq | cut -d= -f2)
  HostCoreClock=$(echo "$HostConfig" | grep core_freq | cut -d= -f2)
  HostRAMClock=$(echo "$HostConfig" | grep sdram_freq | cut -d= -f2)
else
  HostConfig=$(vcgencmd get_config int)
fi
Print_Style "Board information: Model: $HostModel - Architecture: $HostArchitecture - OS: $HostOS" $YELLOW
Print_Style "Clock speeds: CPU: $HostCPUClock - Core: $HostCoreClock - RAM: $HostRAMClock - SD: $HostSDClock" $YELLOW

# Run HDParm tests
Print_Style "Running HDParm tests ..." $YELLOW
HDParm=$(hdparm -Tt --direct $BootDrive | sed '/^[[:space:]]*$/d')
Print_Style "$HDParm" $NORMAL
HDParmDisk=$(echo "$HDParm" | grep "Timing O_DIRECT disk" | awk 'NR==1{ print $11 }')
HDParmCached=$(echo "$HDParm" | grep "Timing O_DIRECT cached" | awk 'NR==1{ print $11 }')
Print_Style "HDParm: $HDParmDisk MB/s - HDParmCached: $HDParmCached MB/s" $YELLOW

# Run DD tests
Print_Style "Running dd tests ..." $YELLOW
DDWrite=$(dd if=/dev/zero of=test bs=4k count=80k conv=fsync 2>&1 | sed '/^[[:space:]]*$/d')
DDWriteResult=$(echo "$DDWrite" | tail -n 1 |  awk 'NR==1{ print $10 }')
echo "$DDWrite"
Print_Style "DD Write Speed: $DDWriteResult MB/s" $YELLOW
rm -f test

# Run fio tests
Print_Style "Running fio tests ..." $YELLOW
fio4kRandWrite=$(fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=100M --readwrite=randwrite | sed '/^[[:space:]]*$/d')
fio4kRandWriteIOPS=$(echo "$fio4kRandWrite" | grep "iops" | awk 'NR==1{ print $4 }' | cut -d= -f2 | cut -d, -f1)
fio4kRandWriteSpeed=$(echo "$fio4kRandWrite" | grep "iops" | awk 'NR==1{ print $3 }' | cut -d= -f2 | cut -d, -f1 | cut -dK -f1)
echo "$fio4kRandWrite"
rm -f test
fio4kRandRead=$(fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=200M --readwrite=randread | sed '/^[[:space:]]*$/d')
fio4kRandReadIOPS=$(echo "$fio4kRandRead" | grep "iops" | awk 'NR==1{ print $5 }' | cut -d= -f2 | cut -d, -f1)
fio4kRandReadSpeed=$(echo "$fio4kRandRead" | grep "iops" | awk 'NR==1{ print $4 }' | cut -d= -f2 | cut -d, -f1 | cut -dK -f1)
if [[ $fio4kRandReadSpeed == *"B/s"* ]]; then
  fio4kRandReadSpeed=$(echo "$fio4kRandReadSpeed" | cut -dB -f1 )
  fio4kRandReadSpeed=$(echo "scale=2; $fio4kRandReadSpeed/1024" | bc)
fi
if [[ $fio4kRandWriteSpeed == *"B/s"* ]]; then
  fio4kRandWriteSpeed=$(echo "$fio4kRandWriteSpeed" | cut -dB -f1 )
  fio4kRandWriteSpeed=$(echo "scale=2; $fio4kRandWriteSpeed/1024" | bc)
fi
echo "$fio4kRandRead"
Print_Style "4k RandWrite: $fio4kRandWriteIOPS IOPS ($fio4kRandWriteSpeed KB/s) - 4k RandRead: $fio4kRandReadIOPS IOPS ($fio4kRandReadSpeed KB/s)" $YELLOW
rm -f test

# Run iozone tests
Print_Style "Running iozone test ..." $YELLOW
IOZone=$(iozone/src/current/./iozone -a -e -I -i 0 -i 1 -i 2 -s 100M -r 4k)
IO4kRandRead=$(echo "$IOZone" | tail -n 3 | awk 'NR==1{ print $7 }')
IO4kRandWrite=$(echo "$IOZone" | tail -n 3 | awk 'NR==1{ print $8 }')
IO4kRead=$(echo "$IOZone" | tail -n 3 | awk 'NR==1{ print $5 }')
IO4kWrite=$(echo "$IOZone" | tail -n 3 | awk 'NR==1{ print $3 }')
echo "$IOZone"
IOZone=$(echo "$IOZone" | sed '/^[[:space:]]*$/d')
Print_Style "RandRead: $IO4kRandRead - RandWrite: $IO4kRandWrite - Read: $IO4kRead - Write: $IO4kWrite" $YELLOW

# Get brand information
Print_Style "Enter your storage brand marketing name -- Example: SanDisk Pro, Samsung Evo+, Corsair MX100, etc."
read -p 'Brand Name: ' Brand
Print_Style "(Optional) Enter alias to use on benchmark results.  Leave blank for completely anonymous."
read -p 'Alias (leave blank for Anonymous): ' UserAlias
if [[ ! "$UserAlias" ]]; then UserAlias="Anonymous"; fi

# Submit results
curl --form "form_tools_form_id=1" --form "DDTest=$DDWrite" --form "DDWriteSpeed=$DDWriteResult" --form "HDParmDisk=$HDParmDisk" --form "HDParmCached=$HDParmCached" --form "HDParm=$HDParm" --form "fio4kRandRead=$fio4kRandRead" --form "fio4kRandWrite=$fio4kRandWrite" --form "fio4kRandWriteIOPS=$fio4kRandWriteIOPS" --form "fio4kRandReadIOPS=$fio4kRandReadIOPS" --form "fio4kRandWriteSpeed=$fio4kRandWriteSpeed" --form "fio4kRandReadSpeed=$fio4kRandReadSpeed" --form "IOZone=$IOZone" --form "IO4kRandRead=$IO4kRandRead" --form "IO4kRandWrite=$IO4kRandWrite" --form "IO4kRead=$IO4kRead" --form "IO4kWrite=$IO4kWrite" --form "Drive=$BootDrive" --form "DriveInfo=$BootDriveInfo" --form "Model=$Model" --form "Vendor=$Vendor" --form "Capacity=$Capacity" --form "Manufacturer=$Manufacturer" --form "Product=$Product" --form "Version=$Version" --form "Firmware=$Firmware" --form "DateManufactured=$DateManufactured" --form "Brand=$Brand" --form "Class=$Class" --form "OCR=$OCR" --form "SSR=$SSR" --form "SCR=$SCR" --form "CID=$CID" --form "CSD=$CSD" --form "UserAlias=$UserAlias" --form "HostModel=$HostModel" --form "HostSDClock=$HostSDClock" --form "HostConfig=$HostConfig" --form "HostCPUClock=$HostCPUClock" --form "HostCoreClock=$HostCoreClock" --form "HostRAMClock=$HostRAMClock" --form "HostArchitecture=$HostArchitecture" --form "HostOS=$HostOS" --form "HostOSInfo=$HostOSInfo" https://www.jamesachambers.com/formtools/process.php

# Calculate score
Score=$(echo "scale=2; $DDWriteResult * 1024" | bc)
ScratchPad=$(echo "scale=2; $fio4kRandReadIOPS * 4" | bc)
Score=$(echo "scale=2; $Score + $ScratchPad" | bc)
ScratchPad=$(echo "scale=2; $fio4kRandWriteIOPS * 10" | bc)
Score=$(echo "scale=2; $Score + $ScratchPad" | bc)
Score=$(echo "scale=2; $Score + $IO4kRead" | bc)
Score=$(echo "scale=2; $Score + $IO4kWrite" | bc)
ScratchPad=$(echo "scale=2; $IO4kRandRead * 4" | bc)
Score=$(echo "scale=2; $Score + $ScratchPad" | bc)
ScratchPad=$(echo "scale=2; $IO4kRandWrite * 10" | bc)
Score=$(echo "scale=2; $Score + $ScratchPad" | bc)
Score=$(echo "scale=0; $Score / 100" | bc )

# Display results
printf "\n$BRIGHT$UNDERLINE%-25s %-25s %-25s\n" "     Category" "     Test" "     Result     "$NORMAL$CYAN
printf "%-25s %-25s %-25s\n" "HDParm" "Disk Read" "$HDParmDisk MB/s"
printf "%-25s %-25s %-25s\n" "HDParm" "Cached Disk Read" "$HDParmCached MB/s" 
printf "%-25s %-25s %-25s\n" "DD" "Disk Write" "$DDWriteResult MB/s" 
printf "%-25s %-25s %-25s\n" "FIO" "4k random read" "$fio4kRandReadIOPS IOPS ($fio4kRandReadSpeed KB/s)"
printf "%-25s %-25s %-25s\n" "FIO" "4k random write" "$fio4kRandWriteIOPS IOPS ($fio4kRandWriteSpeed KB/s)"
printf "%-25s %-25s %-25s\n" "IOZone" "4k read" "$IO4kRead KB/s" 
printf "%-25s %-25s %-25s\n" "IOZone" "4k write" "$IO4kWrite KB/s"
printf "%-25s %-25s %-25s\n" "IOZone" "4k random read" "$IO4kRandRead KB/s"
printf "%-25s %-25s %-25s\n" "IOZone" "4k random write" "$IO4kRandWrite KB/s"
printf "\n$BRIGHT$MAGENTA$UNDERLINE%-25s %-25s %-25s\n" " " "Score: $Score" " "
echo ""
echo "Compare with previous benchmark results at:"
echo "https://www.jamesachambers.com/raspberry-pi-storage-benchmarks/"
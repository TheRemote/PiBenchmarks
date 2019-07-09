# PiBenchmarks
Raspberry Pi benchmarking scripts featuring a storage benchmark with a score<br>
Anonymously uploads your score to jamesachambers.com to help others make good decisions on Pi storage<br>
View current benchmarks at: https://jamesachambers.com/raspberry-pi-storage-benchmarks/<br>
Discussion and analysis at: https://jamesachambers.com/raspberry-pi-storage-benchmarks-2019-benchmarking-script/<br>
<br>
To run the benchmark type/paste:<br>
curl https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh | sudo bash<br>
<br>
<b>Update History</b><br>
July 8th 2019<br>
-Improved drive detection for SSDs going through adapters<br>
-Added detection of SSD adapters being used<br>
-Improved Micro SD card type detection<br>
<br>
July 5th 2019<br>
-Further improved rootfs device and size detection<br>
-Improved portability with non-Raspbian platforms<br>
-Improved hdparm detection<br>
<br>
June 30th 2019<br>
-Improved rootfs device detection<br>
<br>
June 27th 2019<br>
-MMC storage is now correctly identified<br>
-Improved CPU/core/memory clock detection in older Pis<br>
-Improved Arch Linux support<br>
-Improved system architecture detection<br>
-Added several new SD and MMC manufacturers<br>
-Fixed a portability with parsing dd test output<br>
<br>
June 26th 2019<br>
-Improved USB Flash drive detection<br>
-Added Platinum manufacturer identification<br>
<br>
June 22nd 2019<br>
-Added Hama manufacturer identification<br>
<br>
May 25th 2019<br>
-Improved HDD and SSD identification including form factor, speed, size and class<br>
-Added Lexar as SD manufacturer 0x00009e<br>
<br>
May 4th 2019<br>
-Added Sony as SD manufacturer 0x00009c<br>
<br>
April 27th 2019<br>
-Added cross platform CPU frequency detection to use if vcgencmd is not present<br>
-Improved boot drive detection<br>
-Added fallback for SD drivers that don't populate the udevadm information<br>
-Added check to prevent installing iozone if it is already present on system<br>
<br>
April 16th 2019<br>
-Added "Team Group" as SD vendor (code -B, 0x000045)<br>
-Added Maxell MicroSD vendor (code TI)<br>
-Added fix to get gpu_freq on older Raspberry Pis that don't have core_freq<br>
<br>
March 30th 2019<br>
-Added x86_64 and x86 support<br>
<br>
March 29th 2019<br>
-Added Transcend to known vendors<br>
-Eliminated wget dependency (uses pure curl for everything)<br>
-Attempt to use native iozone package if available, otherwise build<br>
<br>
March 18th 2019<br>
-Added Arch Linux support<br>
<br>
March 17th 2019<br>
-Added Ubuntu support<br>
<br>
March 16th 2019<br>
-Initial release<br>

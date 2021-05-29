# Raspberry Pi Storage Benchmarking Script
<h3>Overview</h3>
Raspberry Pi benchmarking scripts featuring a storage benchmark with a score<br>
Anonymously uploads your score to jamesachambers.com to help others make good decisions on Pi storage<br>

<h3>View Results</h3>

View current benchmarks, discussion and analysis at: https://jamesachambers.com/2020s-fastest-raspberry-pi-4-storage-sd-ssd-benchmarks/<br>
View the full results at: https://pibenchmarks.com/<br>

<h3>Running the Benchmark</h3>
To run the benchmark type/paste:<br>
sudo curl https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh | sudo bash<br>
<br>
If you want to choose which drive to test you can also:<br>
wget https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh<br>
chmod +x Storage.sh<br>
sudo ./Storage.sh /path/to/storage<br>

<h3>Update History</h3>

<h4>May 29th 2021</h4>
<ul>
  <li>Added --no-install-recommends to most apt package installers to cut down on time running on a new system and unnecessary packages</li>
  <li>Moved upload URL to the new pibenchmarks.com domain</li>
</ul>

<h4>May 21st 2021</h4>
<ul>
  <li>Added dependency for libxml-dumper-perl to fix inxi on some platforms (thanks DMC!)</li>
</ul>

<h4>May 9th 2021</h4>
<ul>
  <li>Moved project frontend to pibenchmarks.com domain name</li>
</ul>

<h4>February 24th 2020</h4>
<ul>
  <li>Added xxd dependency (thanks vszakats)</li>
  <li>Added option to choose which drive/folder to test (thanks hvdwolf)</li>
</ul>

<h4>January 6th 2020</h4>
<ul>
  <li>Launched early beta of <a href=https://pibenchmarks.com>https://pibenchmarks.com/</a> results browser</li>
  <li>Fixed an issue where dmesg was giving too much output resulting in "argument list too long" error that prevented results from submitting (thanks winkelement)</li>
</ul>

<h4>December 22nd 2019</h4>
<ul>
  <li>Added new smartctl test to help identify drives on USB adapters that don't support hdparm</li>
  <li>Improved the hwinfo test to provide better drive identifying information</li>
</ul>

<h4>December 21st 2019</h4>
<ul>
  <li>Added new NVME test to help better identify NVME drives</li>
  <li>Double quoted variables to ensure maximum compatibility across distros</li>
</ul>

<h4>December 2nd 2019</h4>
<ul>
  <li>Merged pull request from pschmitt improving the test dramatically on Arch Linux (thanks!)</li>
  <li>Fixed issue where dmesg test could contain characters that could break the test</li>
  <li>Removed all instances of "N/A" in favor of leaving the field blank and saving thousands of unneccessary bytes</li>
</ul>

<h4>November 24th 2019</h4>
<ul>
  <li>Added SSD adapter detection</li>
  <li>Added dmesg test in order to detect applied storage quirks</li>
  <li>Speed increases to dependency detection</li>
</ul>

<h4>November 22nd 2019</h4>
<ul>
  <li>Parted out some tests into separate variables -- cleaning up code/tests for upcoming system improvements</li>
</ul>

<h4>July 24th 2019</h4>
<ul>
  <li>Further improved SSD drive detection</li>
</ul>

<h4>July 8th 2019</h4>
<ul>
  <li>Improved drive detection for SSDs going through adapters</li>
  <li>Added detection of SSD adapters being used</li>
  <li>Improved Micro SD card type detection</li>
</ul>

<h4>July 5th 2019</h4>
<ul>
  <li>Further improved rootfs device and size detection</li>
  <li>Improved portability with non-Raspbian platforms</li>
  <li>Improved hdparm detection</li>
</ul>

<h4>June 30th 2019</h4>
<ul>
  <li>Improved rootfs device detection</li>
</ul>

<h4>June 27th 2019</h4>
<ul>
  <li>MMC storage is now correctly identified</li>
  <li>Improved CPU/core/memory clock detection in older Pis</li>
  <li>Improved Arch Linux support</li>
  <li>Improved system architecture detection</li>
  <li>Added several new SD and MMC manufacturers</li>
  <li>Fixed a portability with parsing dd test output</li>
</ul>

<h4>June 26th 2019</h4>
<ul>
  <li>Improved USB Flash drive detection</li>
  <li>Added Platinum manufacturer identification</li>
</ul>

<h4>June 22nd 2019</h4>
<ul>
  <li>Added Hama manufacturer identification</li>
</ul>

<h4>May 25th 2019</h4>
<ul>
  <li>Improved HDD and SSD identification including form factor, speed, size and class</li>
  <li>Added Lexar as SD manufacturer 0x00009e</li>
</ul>

<h4>May 4th 2019</h4>
<ul>
  <li>Added Sony as SD manufacturer 0x00009c</li>
</ul>

<h4>April 27th 2019</h4>
<ul>
  <li>Added cross platform CPU frequency detection to use if vcgencmd is not present</li>
  <li>Improved boot drive detection</li>
  <li>Added fallback for SD drivers that don't populate the udevadm information</li>
  <li>Added check to prevent installing iozone if it is already present on system</li>
</ul>

<h4>April 16th 2019</h4>
<ul>
  <li>Added "Team Group" as SD vendor (code -B, 0x000045)</li>
  <li>Added Maxell MicroSD vendor (code TI)</li>
  <li>Added fix to get gpu_freq on older Raspberry Pis that don't have core_freq</li>
</ul>

<h4>March 30th 2019</h4>
<ul>
  <li>Added x86_64 and x86 support</li>
</ul>

<h4>March 29th 2019</h4>
<ul>
  <li>Added Transcend to known vendors</li>
  <li>Eliminated wget dependency (uses pure curl for everything)</li>
  <li>Attempt to use native iozone package if available, otherwise build</li>
</ul>

<h4>March 18th 2019</h4>
<ul>
  <li>Added Arch Linux support</li>
</ul>

<h4>March 17th 2019</h4>
<ul>
  <li>Added Ubuntu support</li>
</ul>

<h4>March 16th 2019</h4>
<ul>
  <li>Initial release</li>
</ul>

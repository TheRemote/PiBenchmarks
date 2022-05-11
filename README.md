# Raspberry Pi Storage Benchmarking Script
<h3>Overview</h3>
Raspberry Pi benchmarking scripts featuring a storage benchmark with a score<br>
Anonymously uploads your score to jamesachambers.com to help others make good decisions on Pi storage<br>

<h3>View Results</h3>

View current benchmarks, discussion and analysis at: https://jamesachambers.com/2020s-fastest-raspberry-pi-4-storage-sd-ssd-benchmarks/<br>
View the full results at: https://pibenchmarks.com/<br>

<h3>Running the Benchmark</h3>
To run the benchmark type/paste:<br>
<pre>sudo curl https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh | sudo bash</pre><br>
If you want to choose which drive to test you can also:<br>
wget https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh<br>
chmod +x Storage.sh<br>
sudo ./Storage.sh /path/to/storage<br>

<h3>Removing Installed Packages</h3>
Most of the packages the script installs are core system packages most of which should already be present.  There are a couple benchmarking-only related ones that should be safe to remove if you want an absolute minimalist system.<br>
<br>
If you want to remove the packages the script installed afterward you may do:<br>
<br>
sudo apt remove iozone3 fio<br>
<br>
These are iozone and fio which are both benchmarking utilities and should be safe to use unless you have something else installed that relies on them as a dependency (probably not likely but possible so make sure before removing packages).  

<h3>Buy A Coffee / Donate</h3>
<p>People have expressed some interest in this (you are all saints, thank you, truly)</p>
<ul>
 <li>PayPal: 05jchambers@gmail.com</li>
 <li>Venmo: @JamesAChambers</li>
 <li>CashApp: $theremote</li>
 <li>Bitcoin (BTC): 3H6wkPnL1Kvne7dJQS8h7wB4vndB9KxZP7</li>
</ul>

<h3>Additional Model Support</h3>

See bottom of README for list of supported models.  I can always add additional models if people submit benchmarks with them or request them!

<h3>Update History</h3>

<h4>May 11th 2022</h4>
<ul>
  <li>Added 20 second timeout to udevadm test to prevent it from getting stuck forever in rare cases on some boards (thanks munecito <a href="https://github.com/TheRemote/PiBenchmarks/issues/22">issue #22</a>)/li>
  <li>Removed vendor field parsing</li>
</ul>

<h4>May 10th 2022</h4>
<ul>
  <li>Added seom additional messages to help with debugging</li>
</ul>

<h4>April 29th 2022</h4>
<ul>
  <li>Added a couple more Gigabyte SBCs</li>
  <li>Added 4 Shuttle models that had benchmarks submitted for them -- marketed as the "smallest PC in the world"</li>
</ul>

<h4>April 28th 2022</h4>
<ul>
  <li>Added additional System Boards to <a href="https://pibenchmarks.com/boards">PiBenchmarks.com System Boards</a> and README</li>
  <li>System boards for PC and other types of devices like laptops, desktops, etc. are starting to be added quietly in the background</li>
  <li>PC results won't show on the "Latest" tab yet but you can find models that have already been done by searching for something like "Dell" or "HP" and you'll see System Boards that are being added from those manufacturers</li>
</ul>

<h4>April 26th 2022</h4>
<ul>
  <li>Removed "Vendor" field from submitted fields as it is no longer used for parsing</li>
</ul>

<h4>April 22nd 2022</h4>
<ul>
  <li>Added list of additional supported models (see bottom of README)</li>
</ul>

<h4>April 16th 2022</h4>
<ul>
  <li>Added support for other SBCs similar to the Pi such as ODROID, Banana Pi, Pine64, Radxa Rock Pi, Tinker Board, OrangePi, NVIDIA Jetson Nano and more</li>
  <li>These models were chosen based on the fact that people had already submitted benchmarks with them.  I will add others if people benchmark on those devices as well!</li>
  <li><a href="https://jamesachambers.com/benchmark-tinker-board-odroid-pine64-orangepi-and-others/">Full list of models available here</a></li>
</ul>

<h4>April 10th 2022</h4>
<ul>
  <li>Added instructions to remove packages the script uses that should be safe</li>
</ul>

<h4>March 20th 2022</h4>
<ul>
  <li>Added pre-run requirement check for lsblk and fio to be installed (tries automatically but if you are on an unusual distro you may need to manually install them)</li>
  <li>Fixed an issue where DD write wasn't being read correctly from computers using Japanese</li>
</ul>

<h4>March 17th 2022</h4>
<ul>
  <li>Fixed an issue with btrfs that would add the characters [/@] at the end of the detected drive (about 19 tests impacted)</li>
</ul>

<h4>August 4th 2021</h4>
<ul>
  <li>Removed Ubuntu PPA as it doesn't support focal and is no longer necessary as libraspberrypi-bin is available in the repositories now that the Pi is "officially supported" on Ubuntu</li>
  <li>If you ran the storage script on a focal release and your apt is returning an error complaining about this you can remove the PPA with: <pre>sudo add-apt-repository -r ppa:ubuntu-raspi2/ppa</pre>  This has been fixed on the live version and is no longer added to the apt list.</li>
</ul>

<h4>May 29th 2021</h4>
<ul>
  <li>Added some additional status messages to make it more clear what the script is doing at any given time</li>
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


<h3>Additional Models Supported</h3>
<ul>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Tinker_Board" target="_blank">ASUS Tinker Board</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Tinker_Board_S" target="_blank">ASUS Tinker Board S</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ROCK_Pi_4A" target="_blank">Radxa ROCK Pi 4A</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ROCK_Pi_4B" target="_blank">Radxa ROCK Pi 4B</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ROCK_Pi_X" target="_blank">Radxa ROCK Pi X</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ROCK_3A" Radxa ROCK 3A</li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Pine64%5E" target="_blank">Pine64 Pine64+</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Rock64" target="_blank">Pine64 Rock64</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/RockPro64" target="_blank">Pine64 RockPro64</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_One_Plus" target="_blank">Xunlong OrangePi One / One Plus</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_Zero" target="_blank">Xunlong OrangePi Zero</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_3" target="_blank">Xunlong OrangePi 3</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_4" target="_blank">Xunlong OrangePi 4</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_Plus_%3C_Plus_2" target="_blank">Xunlong OrangePi Plus / Plus2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_PC" target="_blank">Xunlong OrangePi PC</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_PC_2" target="_blank">Xunlong OrangePi PC2 </a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/OrangePi_Lite2" target="_blank">Xunlong OrangePi Lite2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-C4" target="_blank">Hardkernel ODROID-C4</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-C2" target="_blank">Hardkernel ODROID-C2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-HC4" target="_blank">Hardkernel ODROID-HC4</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-N2" target="_blank">Hardkernel ODROID-N2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-N2Plus" target="_blank">Hardkernel ODROID-N2Plus</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID_HC1" target="_blank">Hardkernel ODROID HC1</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID_XU4" target="_blank">Hardkernel ODROID XU4</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ODROID-M1" target="_blank">Hardkernel ODROID M1</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Jetson_Nano_Developer_Kit" target="_blank">NVIDIA Jetson Nano Developer Kit</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Jetson_Nano_2GB_Developer_Kit" target="_blank">NVIDIA Jetson Nano 2GB Developer Kit</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Jetson_Xavier_NX_Developer_Kit" target="_blank">NVIDIA Jetson Xavier Developer Kit</a></li>
<li>FriendlyElec ZeroPi</li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/NanoPi_NEO3" target="_blank">FriendlyElec NanoPi NEO3</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/NanoPi-NEO-Core2" target="_blank">FriendlyElec NanoPi-NEO-Core2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/NanoPi_R2S" target="_blank">FriendlyElec NanoPi RS / R2S</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/NanoPi_M4" target="_blank">FriendlyElec NanoPi M4</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Banana_Pi" target="_blank">LeMaker Banana Pi</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Cubietruck" target="_blank">Cubietech Cubietruck</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Atomic_Pi_MF-001" target="_blank">AAEON Atomic Pi MF-001</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/X96_Max" target="_blank">Shenzen Amediatech  X96 Max</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ROC-RK3328-CC" target="_blank">Firefly ROC-RK3328-CC</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/RK3318_BOX" target="_blank">Rockchip RK3318 BOX</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/VIM2" target="_blank">Khadas VIM2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/STCK1A32WFC" target="_blank">Intel Compute Stick STCK1A32WFC</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Cubox-i_Dual%3CQuad" target="_blank">SolidRun Cubox-i Dual/Quad</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/Vega_S96" target="_blank">Tronsmart Vega S96</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ZBOX-BI320" target="_blank">ZOTAC ZBOX-BI320</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ZBOXNANO-AD12" target="_blank">ZOTAC ZBOXNANO-AD12</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/ZBOX-ID88%3CID89%3CID90" target="_blank">ZOTAC ZBOX-ID88/ID89/ID90</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/KIII_Pro" target="_blank">MeCool KIII Pro</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/BT3_Pro" target="_blank">Beelink BT3 Pro</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/N1" target="_blank">Phicomm N1</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/fitlet2" target="_blank">Compulab fitlet2</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/GB-BACE-3150-System" target="_blank">Gigabyte GB-BACE-3150-System</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/GB-BXBT-1900" target="_blank">Gigabyte GB-BXBT-1900</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/DS57U" target="_blank">Shuttle DS57U</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/DS61" target="_blank">Shuttle DS61</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/DS437" target="_blank">Shuttle DS437</a></li>
<li><a rel="noopener" href="https://pibenchmarks.com/board/NC01U" target="_blank">Shuttle NC01U</a></li>
</ul>
Experimental Yosys Toolchain for Microchip ATF15xx CPLDs
--------------------------------------------------------

Quick Start Guide

1. Install wine

sudo apt-get install wine-stable

2. Download and install the latest nightly of the Yosys Open-Source CAS Suite

https://github.com/YosysHQ/oss-cad-suite-build/releases

cd $HOME
wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2022-11-22/oss-cad-suite-linux-x64-20221122.tgz
tar xf oss-cad-suite-linux-x64-20221122.tgz
rm -f oss-cad-suite-linux-x64-20221122.tgz
export PATH=~/oss-cad-suite/bin:$PATH

3. Checkout the atf15xx_yosys project

cd $HOME
git clone https://github.com/hoglet67/atf15xx_yosys.git

4. Install the Atmel fitter binaries in $HOME/atf15xx_yosys/vendor/

These need to be extracted from the Microchip ProChip Designer download:

http://ww1.microchip.com/downloads/en/DeviceDoc/ProChip5.0.1.zip

These are the sha1sums of the files you should end up with in vendor/
4ea7f7c5696990d84b587f4145ae0625ae9116eb  aprim.lib
7e7010a44455e01e1db6a1f18f320823dcfb5d61  atmel.std
fbcd61cd5348b05000ccad3d0e08cf8a8fb94538  fit1502.exe
e99b14f68fa5de131aa388503535c51ecdf31295  fit1504.exe
5f1ef6d220466dff8ac031acbce4e7a55dfed153  fit1508.exe

5. Try one of the examples

cd $HOME/atf15xx_yosys/examples/mmu

Run Yosys:

../../run_yosys mmu

This should create mmu.edif

Run the Fitter:

../../run_fitter mmu

This creates several files, the most important being:

mmu.fit  - the fitter report
mmu.vo   - a gate-level verilog for timing simulation
mmu.jed  - a JEDEC file for programming with Atmisp

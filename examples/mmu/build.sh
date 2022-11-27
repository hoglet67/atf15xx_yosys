#!/bin/bash

../../run_yosys.sh mmu > mmu.log

echo $*

../../run_fitter.sh mmu -preassign keep -tdi_pullup on -tms_pullup on -output_fast off -xor_synthesis on $*

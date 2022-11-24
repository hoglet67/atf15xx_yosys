#!/bin/bash

../../run_yosys.sh mmu > mmu.log

../../run_fitter.sh mmu -preassign keep -tdi_pullup on -tms_pullup on -output_fast off -foldback_logic on -xor_synthesis on

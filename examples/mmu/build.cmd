@echo off
call "../../run_yosys.cmd" mmu > mmu.log

if not "%*" == "" echo %*

call "../../run_fitter.cmd" mmu -preassign keep -tdi_pullup on -tms_pullup on -output_fast off -xor_synthesis on %*

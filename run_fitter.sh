#!/bin/sh -e

export ROOT=$(dirname $0)
export WINEPREFIX=$HOME/.wine_atf
export FITTERDIR=$(winepath -w ${ROOT}/vendor)

DEVICE=1508
PACKAGE=PLCC84


NAME=$1; shift
OPTS=$(grep '//OPT:' ${NAME}.v | cut -d' ' -f2-)

grep '//PIN:' ${NAME}.v | cut -d' ' -f2- | tee ${NAME}.pin


## Atmel foldback = Altera shareable expander
## Atmel cascade = Altera parallel expander


rm -f ${NAME}.fit

wine ${FITTERDIR}\\fit${DEVICE}.exe \
     -i ${NAME}.edif \
     -ifmt edif \
     -o ${NAME}.jed \
     -device ${PACKAGE} \
     -tech ATF${DEVICE}AS \
     -preassign keep \
     -strategy jtag on \
     -strategy tdi_pullup on \
     -strategy tms_pullup on \
     -strategy output_fast off \
     -strategy pin_keep off \
     -strategy pd1 off \
     -strategy pd2 off \
     -strategy optimize on \
     -strategy Verilog_sim Verilog \
     -strategy cascade_logic off \
     -strategy foldback_logic on \
     -strategy xor_synthesis on \
     ${OPTS}

grep "^   " ${NAME}.fit
echo

echo "Logic Array Block       Macro Cells     I/O Pins        Foldbacks       TotalPT         FanIN           Cascades"
grep "^[A-H]:" ${NAME}.fit
echo

grep "FanIn"   ${NAME}.fit
echo

grep "^Total"  ${NAME}.fit | sed "s/input pins \t/input pins/" | sed "s/Pts \t/Pts/"
echo

grep "^\$Device"  ${NAME}.fit
echo

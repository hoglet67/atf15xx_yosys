#!/bin/bash -e

export ROOT=$(dirname $0)
export WINEPREFIX=$HOME/.wine_atf
export FITTERDIR=$(winepath -w ${ROOT}/vendor)

# Process command line args

DEVICE=ATF1508AS
PACKAGE=PLCC84
SPEED=15

usage() {
    echo "Usage: $0 [-h] [-d <device>] [-p <package>] [-s <speed>] <name> [ fitter options ]" 1>&2
    echo 1>&2
    echo "Defaults:" 1>&2
    echo "  <device>  = ${DEVICE}"  1>&2
    echo "  <package> = ${PACKAGE}" 1>&2
    echo "  <speed>   = ${SPEED}"   1>&2
    echo 1>&2
    echo "additional options are passed through to the fitter"
    exit 1;
}

while getopts ":hd:p:s:" o; do
    case "${o}" in
        h)
            usage
            ;;
        d)
            DEVICE=${OPTARG}
            ;;
        p)
            PACKAGE=${OPTARG}
            ;;
        s)
            SPEED=${OPTARG}
            ;;
    esac
done
shift $((OPTIND-1))

NAME=$1; shift

# Additional fitter options passed through
OPTS=$*

echo Name    = ${NAME}
echo Device  = ${DEVICE}
echo Package = ${PACKAGE}
echo Speed   = ${SPEED}
echo Options = ${OPTS}


## Atmel foldback = Altera shareable expander
## Atmel cascade = Altera parallel expander

## Fitter Defaults
# Device_name = PQFP100
# Tech_name = ATF1508AS
# Package_type = PQFP
# Preassignment = try
# Security_mode = OFF
# Pin-Keeper = OFF
# supporter = ABEL
# optimize = ON
# Xor_synthesis = OFF
# Foldback_logic = OFF
# Cascade_logic = OFF
# Output_fast = ON
# SSTL_input = off
# Power down pin 1 = OFF
# Power down pin 2 = OFF
# power_reset = OFF
# JTAG = ON
# TDI pullup = OFF
# TMS pullup = OFF
# MC_power = OFF
# Open_collector = OFF
# ITD0 = ON
# ITD1 = ON
# ITD2 = ON
# Fast_inlatch = off
# Latch_synthesis = off
# Push_gate = on
# Verilog_sim = off
# VHDL_sim = off
# Out_Edif = off
# Logic Doubling = off

FITTER=fit${DEVICE//[!0-9]/}.exe

grep '//PIN:' ${NAME}.v | cut -d' ' -f2- > ${NAME}.pin

rm -f ${NAME}.fit

wine ${FITTERDIR}\\${FITTER} \
     -i ${NAME}.edif \
     -ifmt edif \
     -o ${NAME}.jed \
     -lib ${FITTERDIR}\\aprim.lib \
     -tech ${DEVICE} \
     -device ${PACKAGE} \
     -tpd ${SPEED} \
      ${OPTS}


grep "^   " ${NAME}.fit
echo

echo "Logic Array Block       Macro Cells     I/O Pins        Foldbacks       TotalPT         FanIN           Cascades"
grep "^[A-H]:" ${NAME}.fit
echo

grep "^Total"  ${NAME}.fit | sed "s/input pins \t/input pins/" | sed "s/Pts \t/Pts/"
echo

grep "^\$Device"  ${NAME}.fit
echo

#!/bin/sh -ex

export ROOT=$(dirname $0)
export WINEPREFIX=$HOME/.wine_atf
export FITTERDIR=$(winepath -w ${ROOT}/vendor)

NAME=$1; shift
OPTS=$(grep '//OPT:' ${NAME}.v | cut -d' ' -f2-)


#grep '//PIN:' ${NAME}.v | cut -d' ' -f2- | tee ${NAME}.pin


wine ${FITTERDIR}\\fit1508.exe -i ${NAME}.edif -o ${NAME}.jed -device PLCC84 -tech ATF1508AS -strategy ifmt=edif -strategy optimize=on -strategy DEBUG=off -strategy Verilog_sim Verilog ${OPTS}

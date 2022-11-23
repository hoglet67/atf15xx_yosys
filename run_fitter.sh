#!/bin/sh -ex

export ROOT=$(dirname $0)
export WINEPREFIX=$HOME/.wine_atf
export FITTERDIR=$(winepath -w ${ROOT}/vendor)

DEVICE=1508
PACKAGE=PLCC84


NAME=$1; shift
OPTS=$(grep '//OPT:' ${NAME}.v | cut -d' ' -f2-)

grep '//PIN:' ${NAME}.v | cut -d' ' -f2- | tee ${NAME}.pin

wine ${FITTERDIR}\\fit${DEVICE}.exe -i ${NAME}.edif -o ${NAME}.jed -device ${PACKAGE} -tech ATF${DEVICE}AS -strategy ifmt=edif -strategy optimize=on -strategy DEBUG=off -strategy Verilog_sim Verilog ${OPTS} -strategy xor_synthesis on

tail -25 ${NAME}.fit

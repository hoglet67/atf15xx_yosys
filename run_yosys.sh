#!/bin/sh -ex

export ROOT=$(dirname $0)

NAME=$1; shift

yosys <<EOF
read_liberty -lib ${ROOT}/cells.lib
read_verilog ${NAME}.v
tribuf -logic
synth -top ${NAME}
dfflibmap -liberty ${ROOT}/cells.lib
abc -liberty ${ROOT}/cells.lib
hilomap -hicell VCC Q -locell GND Q
iopadmap -bits -inpad INBUF Q:A -outpad BUF A:Q -tinoutpad bibuf EN:Q:A:PAD
clean
hierarchy
write_edif ${NAME}.edif
EOF

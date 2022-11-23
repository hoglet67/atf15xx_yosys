#!/bin/sh -ex

export ROOT=$(dirname $0)

NAME=$1; shift

yosys <<EOF
read_liberty -lib ${ROOT}/cells.lib
read_verilog ${NAME}.v
stat
tribuf
stat
synth -noabc -top ${NAME}
stat
techmap -map ${ROOT}/techmap.v
stat
simplemap
stat
dfflibmap -liberty ${ROOT}/cells.lib
stat
abc -liberty ${ROOT}/cells.lib
stat
#hilomap -hicell VCC X -locell GND X
#stat
iopadmap -bits -inpad INBUF Q:A -outpad BUF A:Q -tinoutpad bibuf EN:Q:A:PAD
stat
clean
stat
hierarchy
stat
write_edif ${NAME}.edif
EOF

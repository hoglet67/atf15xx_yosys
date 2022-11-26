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
techmap -map ${ROOT}/techmap.v -D skip_DFFE_XX_
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
splitnets -format _
rename -wire -suffix _reg t:*DFF*
rename -wire -suffix _comb
write_edif ${NAME}.edif
EOF

# The Atmel tools need the bit order of the array ports reversed, so bit 0 is the LSB.
# See https://github.com/YosysHQ/yosys/issues/568
#
# This changes:
#    (port (array ADDR 16) (direction INPUT))
# to:
#    (port (array (rename ADDR "ADDR(15:0)") 16) (direction INPUT))

perl -pe 's/\(array\s+(\w+)\s+(\d+)/"(array (rename $1 \"$1(" . ($2 - 1) . ":0)\") $2"/ge;' < ${NAME}.edif > tmp.edif
mv tmp.edif ${NAME}.edif

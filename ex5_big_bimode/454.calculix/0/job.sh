#!/bin/sh
    /research/rraju2/ece752/gem5/build/ARM/gem5.opt /research/rraju2/ece752/gem5/configs/example/se.py --cpu-type=ex5_big --fast-forward=1000000000 --caches --l2cache --mem-size=2GB --cpu-clock=2GHz --sys-clock=2GHz --maxinsts=1000000000 --cmd=454.calculix --options="-i  stairs" --output=454.calculix.stdout --errout=454.calculix.stderr 
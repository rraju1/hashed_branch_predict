#!/bin/sh
    /research/rraju2/ece752/gem5/build/ARM/gem5.opt /research/rraju2/ece752/gem5/configs/example/se.py --cpu-type=ex5_big --fast-forward=1000000000 --caches --l2cache --mem-size=2GB --cpu-clock=2GHz --sys-clock=2GHz --maxinsts=1000000000 --cmd=470.lbm --options="300 reference.dat 0 1 100_100_130_cf_b.of" --output=470.lbm.stdout --errout=470.lbm.stderr 
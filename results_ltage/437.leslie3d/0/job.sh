#!/bin/sh
    /research/rraju2/ece752/gem5/build/ARM/gem5.opt /research/rraju2/ece752/gem5/configs/example/se.py --cpu-type=O3_ARM_v7a_3 --caches --l2cache --mem-size=2GB --cpu-clock=2GHz --sys-clock=2GHz --maxinsts=1000000000 --fast-forward=1000000000 --cmd=437.leslie3d --input=leslie3d.in --output=437.leslie3d.stdout --errout=437.leslie3d.stderr 
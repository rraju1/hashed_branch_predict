#!/bin/sh
    /research/rraju2/ece752/gem5/build/ARM/gem5.opt /research/rraju2/ece752/gem5/configs/example/se.py --cpu-type=ex5_big --fast-forward=1000000000 --caches --l2cache --mem-size=2GB --cpu-clock=2GHz --sys-clock=2GHz --maxinsts=1000000000 --cmd=444.namd --options="--input namd.input --iterations 1 --output namd.out" --output=444.namd.stdout --errout=444.namd.stderr 
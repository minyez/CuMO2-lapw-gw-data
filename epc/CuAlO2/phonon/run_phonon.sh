#!/usr/bin/env bash

module load vasp/5.4.4-intel-2019.3-avx512 intel/2019.3
cp INCAR.phonon INCAR

mpirun -np 12 vasp_std



#!/usr/bin/env bash

module load vasp/5.4.4-intel-2019.3-avx512 intel/2019.3
cp INCAR.opt INCAR

cp POSCAR.0 POSCAR
for i in {1..1}; do
  echo "Start optimization loop $i"
  mpirun -np 12 vasp_std
  cp vasprun.xml vasprun.xml.$i
  cp OUTCAR OUTCAR.$i
  cp OSZICAR OSZICAR.$i
  cp CONTCAR CONTCAR.$i
  cp CONTCAR POSCAR
done

cp INCAR.static INCAR
echo "Start static calculation"
mpirun -np 12 vasp_std


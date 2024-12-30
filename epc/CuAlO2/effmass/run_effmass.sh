#!/usr/bin/env bash

if (( $# != 1 )); then
  echo "Usage: $0 <dir>"
  echo ""
  echo "Example: $0 gamma"
  exit 1
fi

dir="$1"
cwd=$(pwd)

[[ ! -d "$dir" ]] && { echo "$dir not found"; exit 2; }

module load vasp/5.4.4-intel-2019.3-avx512 intel/2019.3
cd "$dir"

emc.py emc.in
[[ ! -f "KPOINTS" ]] && { echo "KPOINTS not generated, error in emc.py"; exit 3; }

mpirun -np 6 vasp_std > effmass.log 2>&1

cd "$cwd"

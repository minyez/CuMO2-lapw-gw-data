#!/usr/bin/env bash
#SBATCH -A hpc0006175276
#SBATCH -n 8
#SBATCH -N 1
#SBATCH --qos=low
#SBATCH --partition=C028M256G
#SBATCH -J cgo-rk7-k6-Ga-nlo2
#SBATCH -o jobid%j-%N.out
#SBATCH -e jobid%j-%N.err

module load intel/2017.1

np=8
gap2cmpi=/gpfs/share/home/1501210186/program/gap2c/gap2c-mpi.x
hosts_all=slurm.hosts.allocated
hosts_run=slurm.hosts.run

srun hostname -s | sort -n > slurm.hosts.allocated
ntasks_per_node=$(uniq "$hosts_all" | wc -l | awk "{print($np/\$1)}")
balanced=$(for i in $(seq 1 $ntasks_per_node); do uniq "$hosts_all"; done)
echo "$balanced" | sort -n > "$hosts_run"

mpirun -np $np -machinefile $hosts_run $gap2cmpi


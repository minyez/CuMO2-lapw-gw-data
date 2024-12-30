#!/usr/bin/env python
#find_VBM.py
from __future__ import print_function
import os
import scipy
#from scipy.optimize import fmin
#from scipy.optimize import fmin_bfgs
#from scipy.optimize import fmin_powell
#from scipy.optimize import fmin_cg
from scipy.optimize import brute

#kpt=[-0.3889,-0.2222,0.1111]

# Search for CBM
vbm = False

# number of electrons
nelec = 34

iband = nelec // 2
if not vbm:
    iband += 1

def f(kpt):
    os.system('echo "find_VBM" > KPOINTS')
    os.system('echo "1">>KPOINTS')
    os.system('echo "R">>KPOINTS')
    file=open('KPOINTS','a')
    file.write("   ")  
    file.write(str(kpt[0]))  
    file.write(" ")  
    file.write(str(kpt[1]))  
    file.write(" ")  
    file.write(str(kpt[2]))  
    file.write(" ")  
    file.write("1.0")  
    file.close()
    os.system('mpirun -np 6 vasp_std')
#    os.system("E1=$(pv_gap.py OUTCAR | grep VBM | awk '{print($4}')"))
    os.system("grep ' %3d     ' EIGENVAL | awk '{print$2}'>CBM" % iband)
    file2=open('CBM','r')
    Energy=float(file2.read())
    file2.close()
#    print(Energy)

    print("CBM Energy: ", Energy)
    print("kpt: ", kpt)
    file3=open('kpt_change','a')
    file3.write(str(kpt))
    file3.write("\n")
    file3.close()
    if vbm:
        Energy=-Energy
    return Energy


#kopt=fmin(f,kpt,ftol=0.01)
#kopt=fmin_powell(f,kpt,maxiter=500)
rrange=((0,1),(0,1),(0,1))
kopt=brute(f,rrange)
#kopt=fmin_cg(f,kpt,epsilon=0.001,gtol=0.001,maxiter=500)
print(kopt)

#x0=[1.3]
#xopt=fmin(f,x0)
#print(xopt)

#!/usr/bin/env python3

# Metropolis para um gás de Bosões em 3D

import numpy as np
import matplotlib.pyplot as plt
import time
from metropolis_quantum_gas import metropolis_3D_boson
from generate_NN_table import *

if __name__ == '__main__':
    n_equi = 2000
    n_measure = 2000

    N = 200
    n_max = 60
    TC = 0.671253 * N**(2/3)

    T_vals = np.arange(TC/10, 2*TC, 5)
    NT = len(T_vals)
    
    E_mean = np.zeros(NT)
    E2_mean = np.zeros(NT)
    nk_mean = np.zeros((n_max**3, NT))

    print(f"Starting computations for {NT} temperatures with TC = {TC}.")
    print("With the following parameters: ")
    print(f"n_equi = {n_equi}; n_measures = {n_measure}")
    print()

    start_loop = time.perf_counter()

    for k,T in enumerate(T_vals):
        start_it = time.perf_counter()

        (E_mean[k], 
        E2_mean[k], 
        nk_mean[:, k]) = metropolis_3D_boson(T, N, n_max, n_equi, n_measure)
        
        print(f"Done for T: {k+1}/{NT} in {time.perf_counter() - start_it}")
    
    print()
    print(f"Simulations time: {time.perf_counter() - start_loop}")
    
    E_mean_exact = np.zeros(NT)
    for i,T in enumerate(T_vals):
        if T <= TC:
            E_mean_exact[i] = TC * 0.7701 * (T/TC)**(5/2)
        else:
            E_mean_exact[i] = 3 * T / 2

    C_mean = (E2_mean - E_mean**2) / T_vals**2
    C_mean_exact = 1.925 * (T_vals/TC)**(3/2)

    z = nk_mean[0, :] / (nk_mean[0, :] + 1)
    z_exact = np.zeros(NT)
    for i,T in enumerate(T_vals):
        if T <= TC:
            z_exact[i] = 1
        else:
            z_exact[i] = 2.612 * (TC/T)**(3/2)

    f0 = nk_mean[0, :] / N
    f0_exact = 1 - (T_vals/TC)**(3/2)

    plt.figure(1)
    plt.plot(T_vals/TC, E_mean / N, 'or')
    plt.plot(T_vals/TC, E_mean_exact, '-ob')
    
    plt.figure(2) 
    plt.plot(T_vals/TC, C_mean / N, 'or')
    plt.plot(T_vals/TC, C_mean_exact, '-ob')

    plt.figure(3) 
    plt.plot(T_vals/TC, z, 'or')
    plt.plot(T_vals/TC, z_exact, '-ob')
    
    plt.figure(4) 
    plt.plot(T_vals/TC, f0, 'or')
    plt.plot(T_vals/TC, f0_exact, '-ob')


    plt.show()













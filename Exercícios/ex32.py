#!/usr/bin/env python3

# Metropolis para um gás de Bosões em 2D

import numpy as np
import matplotlib.pyplot as plt
import time
from scipy.special import spence
from metropolis_quantum_gas import metropolis_2D_boson

if __name__ == '__main__':
    n_equi = 5000
    n_measure = 2000

    N = 100
    n_max = 50

    NT = 30
    T_vals = np.linspace(3, 300, NT)
    
    E_mean = np.zeros(NT)
    E2_mean = np.zeros(NT)
    nk_mean = np.zeros((n_max**2, NT))

    print(f"Starting computations for {NT} temperatures.")
    print("With the following parameters: ")
    print(f"n_equi = {n_equi}; n_measures = {n_measure}")
    print()

    start_loop = time.perf_counter()

    for k,T in enumerate(T_vals):
        start_it = time.perf_counter()

        (E_mean[k], 
        E2_mean[k], 
        nk_mean[:, k]) = metropolis_2D_boson(T, N, n_max, n_equi, n_measure)
        
        print(f"Done for T: {k+1}/{NT} in {time.perf_counter() - start_it}")
    
    print()
    print(f"Simulations time: {time.perf_counter() - start_loop}")

    E_mean_exact = np.pi * T_vals**2 * spence(np.exp(- 4*N / (np.pi*T_vals))) / 4

    C = (E2_mean - E_mean**2) / T**2

    plt.figure(1)
    plt.plot(T_vals, C, '-or')

    plt.figure(2)
    plt.plot(T_vals, E_mean - 2*N, '-or' )
    plt.plot(T_vals, E_mean_exact, '-b')



    plt.show()













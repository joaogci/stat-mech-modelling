#!/usr/bin/env python3

import numpy as np
import time
from matplotlib import pyplot as plt

def metropolis_GC(bmu, N, V, n_equi, n_measure):
    Nt = np.zeros(n_measure)
    k = 0
    
    ni = np.zeros(V, dtype=np.int64)
    site_particle = np.zeros(V, dtype=np.int64)
    n = 0
    while n < N:
        i_state = np.random.randint(V)
        if ni[i_state] == 0:
            ni[i_state] = 1
            site_particle[n] = i_state
            n += 1
    
    for t in range(n_equi + n_measure):
        for a in range(V):
            if np.random.rand() <= 0.5:
                i_state = np.random.randint(V)
                if ni[i_state] == 0:
                    ratio = np.min([1, (V/(N+1)) * np.exp(bmu)])
                    if np.random.rand() <= ratio:
                        ni[i_state] = 1
                        site_particle[N] = i_state
                        N += 1
            else:
                if N > 0:
                    ip = np.random.randint(N)
                    ratio = np.min([1, (N/V) * np.exp(- bmu)])
                    if np.random.rand() <= ratio:
                        i_state = site_particle[ip]
                        ni[i_state] = 0
                        N += -1
                        site_particle[ip] = site_particle[N]
        if t > n_equi:
            Nt[k] = N
            k += 1

    return Nt

if __name__ == '__main__':
    N = 10
    L = 10
    V = L**2
    
    n_equi = 1000
    n_measure = 2000
    
    bmu_vals = np.array([-5, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 5])
    
    N_mean = np.zeros(len(bmu_vals))
    Nt = list()
    
    for k,bmu in enumerate(bmu_vals):
        time_init = time.perf_counter()
        
        Nt_met = metropolis_GC(bmu, N, V, n_equi, n_measure)
        
        Nt.append(Nt_met)
        N_mean[k] = np.sum(Nt_met) / n_measure
        print(f"bmu: {k+1}/{len(bmu_vals)}; time: {time.perf_counter() - time_init}s")
        
        N_mean_theo = V * np.exp(bmu) / (1 + np.exp(bmu))
        print(f"Computed: {N_mean[k]}; Theoretical: {N_mean_theo}")
   
    x = np.arange(-5, 5, 0.01)
    N_mean_exact = V * np.exp(x) / (1 + np.exp(x))
    
    plt.figure(1)
    plt.plot(bmu_vals, N_mean, '-or')
    plt.plot(x, N_mean_exact, '-b')
    
    plt.show()
    
        
    

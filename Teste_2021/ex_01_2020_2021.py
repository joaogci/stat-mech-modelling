#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import time

# Global variables

kB = 1.38 * 1E-23       # J K-1
m = 16 * 1.66 * 1E-27   # kg
g = 9.8                 # m s-1
delta = 10 * 1E3        # m

def metropolis(beta, t_max, t_equi):
    n_measure = t_max - t_equi
    E_mean_vals = np.zeros(n_measure)
    h_mean_vals = np.zeros(n_measure)
    
    h = 0
    E = 0
    
    k = 0
    for t in range(t_max):
        dh = (np.random.rand() * (- delta)) + delta / 2
        if h + dh < 0:
            continue
        
        dE = m * g * dh
        ratio = np.min([1, np.exp(- dE * beta)])
        
        if np.random.rand() <= ratio:
            h += dh
            E += dE
        
        if t > t_equi:
            E_mean_vals[k] = E
            h_mean_vals[k] = h
            k += 1
             
    return E_mean_vals, h_mean_vals


def main():
    # Simulation parameters
    
    t_max = int(1E6)
    t_equi = int(1E5)
    
    T = 200                 # K
    beta = 1 / (kB * T)
   
    # Metropolis simulation
   
    start = time.perf_counter() 
    E_mean_vals, h_mean_vals = metropolis(beta, t_max, t_equi)
   
    print(f"Wall time: {time.perf_counter() - start}s") 
    print(f"<E> = {np.mean(E_mean_vals)}")
    print(f"<h> = {np.mean(h_mean_vals)}")
   
    # Histogram
   
    h_vals = np.arange(0, 2E5, 1) 
    Ph_t = m * beta * g * np.exp(- beta * m * g * h_vals)
    
    h_max = np.max(h_mean_vals)
    h_min = np.min(h_mean_vals)
    n_bins = 30
    dh = (h_max - h_min) / n_bins

    values, bins = np.histogram(h_mean_vals, bins=np.linspace(h_min+dh/2, h_max+dh/2, n_bins))
    values = values / (dh * np.sum(values))

    plt.figure(1)
    plt.plot(h_vals, Ph_t, '-b')
    plt.plot(bins[0:-1], values, '*r')
    plt.xlabel("h values")
    plt.ylabel("normalized histogram")
    
    plt.show()
    
    return 

if __name__ == "__main__":
    main()
    
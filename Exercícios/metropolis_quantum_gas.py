# 2D gás de Bosões

import numpy as np
from generate_NN_table import *

def metropolis_2D_boson(T, N, n_max, n_equi, n_measure):
    E_mean = 0
    E2_mean = 0
    nk_mean = np.zeros(n_max**2, dtype=int)

    NN_table, NN = NN_create_2D(n_max)

    nk = np.zeros(n_max**2, dtype=int)
    nk[0] = N
    state_particle = np.zeros(N, dtype=int)
    E = 2 * N

    for t in range(int(n_equi + n_measure)):
        for a in range(N):
            idx_p = np.random.randint(N)
            state_p = state_particle[idx_p]
            state_v = NN_table[state_p, np.random.randint(NN[state_p])]

            nx_p = state_p % n_max + 1
            ny_p = state_p // n_max + 1
            
            nx_v = state_v % n_max + 1
            ny_v = state_v // n_max + 1
            
            dE = nx_v**2 + ny_v**2 - (nx_p**2 + ny_p**2)

            ratio = np.min( [ 1, (NN[state_p] * (nk[state_v] + 1)) * np.exp(- dE / T) / (NN[state_v] * nk[state_p]) ] )

            if np.random.rand() <= ratio:
                E += dE
                nk[state_p] -= 1
                nk[state_v] += 1
                state_particle[idx_p] = state_v

        if t >  n_equi:
            E_mean += E
            E2_mean += E**2
            nk_mean += nk
    
    return E_mean/n_measure, E2_mean/n_measure, nk_mean/n_measure



def metropolis_3D_boson(T, N, n_max, n_equi, n_measure):
    E_mean = 0
    E2_mean = 0
    nk_mean = np.zeros(n_max**3, dtype=int)

    NN_table, NN = NN_create_3D(n_max)

    nk = np.zeros(n_max**3, dtype=int)
    nk[0] = N
    state_particle = np.zeros(N, dtype=int)
    E = 3 * N

    for t in range(int(n_equi + n_measure)):
        for a in range(N):
            idx_p = np.random.randint(N)
            state_p = state_particle[idx_p]
            state_v = NN_table[state_p, np.random.randint(NN[state_p])]

            nx_p = (state_p % n_max**2) % n_max + 1
            ny_p = (state_p % n_max**2) // n_max + 1
            nz_p = state_p // n_max**2 + 1
            
            nx_v = (state_v % n_max**2) % n_max + 1
            ny_v = (state_v % n_max**2) // n_max + 1
            nz_v = state_v // n_max**2 + 1
            
            dE = nx_v**2 + ny_v**2 +nz_v**2 - (nx_p**2 + ny_p**2 + nz_p**2)

            ratio = np.min( [ 1, (NN[state_p] * (nk[state_v] + 1)) * np.exp(- dE / T) / (NN[state_v] * nk[state_p]) ] )

            if np.random.rand() <= ratio:
                E += dE
                nk[state_p] -= 1
                nk[state_v] += 1
                state_particle[idx_p] = state_v

        if t >  n_equi:
            E_mean += E
            E2_mean += E**2
            nk_mean += nk
    
    return E_mean/n_measure, E2_mean/n_measure, nk_mean/n_measure


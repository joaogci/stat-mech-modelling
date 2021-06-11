# Geração de tabelas de vizinhos

import numpy as np 

def NN_create_3D(n_max):
     NN = np.zeros(n_max**3, dtype=int)
     NN_table = np.zeros((n_max**3, 6), dtype=int) - 1
 
     for i in range(n_max**3):
         n = 0

         nx = (i % n_max**2) % n_max
         ny = (i % n_max**2) // n_max
         nz = i // n_max**2
 
         nx1 = nx + 1
         ny1 = ny
         nz1 = nz
         if nx1 < n_max:
             NN_table[i, n] = nx1 + n_max * ny1 + n_max**2 * nz1
             n += 1
 
         nx2 = nx - 1
         ny2 = ny
         nz2 = nz
         if nx2 < n_max and nx2 >= 0:
             NN_table[i, n] = nx2 + n_max * ny2 + n_max**2 * nz2
             n += 1
 
         nx3 = nx
         ny3 = ny + 1
         nz3 = nz
         if ny3 < n_max:
             NN_table[i, n] = nx3 + n_max * ny3 + n_max**2 * nz3
             n += 1
 
         nx4 = nx
         ny4 = ny - 1
         nz4 = nz
         if ny4 < n_max and ny4 >= 0:
             NN_table[i, n] = nx4 + n_max * ny4 + n_max**2 * nz4
             n += 1
 
         nx5 = nx
         ny5 = ny
         nz5 = nz + 1
         if nz5 < n_max:
             NN_table[i, n] = nx5 + n_max * ny5 + n_max**2 * nz5
             n += 1
 
         nx6 = nx
         ny6 = ny
         nz6 = nz - 1
         if nz6 < n_max and nz6 >= 0:
             NN_table[i, n] = nx6 + n_max * ny6 + n_max**2 * nz6
             n += 1
 
         NN[i] = n
     return (NN_table, NN)


def NN_create_2D(n_max):
    NN_table = np.zeros((n_max * n_max, 4), dtype=int) - 1
    NN = np.zeros(n_max * n_max, dtype=int)

    for i in range(n_max**2):
        nx = i % n_max
        ny = i // n_max
        n = 0
		
        nx1 = nx + 1
        ny1 = ny
        if nx1 < n_max: 
            NN_table[i, n] = int(nx1 + n_max * ny1)
            n += 1
		
        nx2 = nx - 1
        ny2 = ny
        if nx2 < n_max and nx2 >= 0:
            NN_table[i, n] = int(nx2 + n_max * ny2)
            n += 1
		
        nx3 = nx
        ny3 = ny + 1
        if ny3 < n_max:
            NN_table[i, n] = int(nx3 + n_max * ny3)
            n += 1
		
        nx4 = nx
        ny4 = ny - 1
        if ny4 < n_max and ny4 >= 0:
            NN_table[i, n] = int(nx4 + n_max * ny4)
            n += 1
		
        NN[i] = n
    return (NN_table, NN)










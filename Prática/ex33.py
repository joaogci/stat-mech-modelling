import numpy as np
from matplotlib import pyplot as plt

def NN_create(n_max):
    NN = np.zeros(n_max**3)
    NN_table = np.zeros((n_max**3, 6), int) - 1

    for i in range(n_max**3):
        n = 0

        nx = (i % n_max**2) % n_max
        ny = (i % n_max**2) // (nx + 1)
        nz = (i // n_max**2)

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


def metropolis(T, N, n_max, n_stop, n_vals):
    nk = np.zeros(n_max**3)
    E = 2 * N
    nk[0] = N

    states_prtc = np.ones(N, int)

    n = n_stop + n_vals

    (NN_table, NN) = NN_create(n_max)

    E_mean = 0
    E2_mean = 0
    nk_mean = np.zeros(n_max**3)

    for t in range(n):
        for step in range(N):
            idx_p = np.random.randint(N)
            idx_state = states_prtc[idx_p]

            idx_neigh = np.random.randint(NN[idx_state])
            idx_neigh = NN_table[idx_state, idx_neigh]

            nx = (idx_state % n_max**2) % n_max
            ny = (idx_state % n_max**2) // (nx + 1)
            nz = (idx_state // n_max**2)

            nx_neigh = (idx_neigh % n_max**2) % n_max
            ny_neigh = (idx_neigh % n_max**2) // (nx + 1)
            nz_neigh = (idx_neigh // n_max**2)

            delta_E = nx_neigh**2 + ny_neigh**2 + nz_neigh**2 - (nx**2 + ny**2 + nz**2)
            ratio = np.min([1, (NN[idx_state] / NN[idx_neigh]) * ((nk[idx_neigh] + 1) / nk[idx_state]) * np.exp(-delta_E / T)])

            if np.random.rand() <= ratio:
                nk[idx_state] += - 1
                nk[idx_neigh] += 1

                E += delta_E

                states_prtc[idx_p] = idx_neigh


        if t > n_stop:
            E_mean += E
            E2_mean += E**2
            nk_mean = nk

    return (E_mean/n_vals, E2_mean/n_vals, nk_mean/n_vals)


if __name__ == '__main__':
    N = 200
    n_max = 20

    Tc = N**(2/3) * 3.31 / (2 * np.pi**2)
    T_vals = np.arange(Tc/10, 2*Tc, Tc/20)

    n_stop = 2000
    n_vals = 20000

    E_mean = np.zeros_like(T_vals)
    E2_mean = np.zeros_like(T_vals)

    cv = np.zeros_like(T_vals)
    z = np.zeros_like(T_vals)

    for k, T in enumerate(T_vals):
        print(f"started simulation for T/Tc={T/Tc}")
        
        (E_mean[k], E2_mean[k], nk_mean) = metropolis(T, N, n_max, n_stop, n_vals)

        cv[k] = (E2_mean[k] - E_mean[k]**2) / T
        z[k] = np.exp(0/T) * nk_mean[0] / (nk_mean[0] + 1)

    print("Done!")


    E1 = Tc * 0.7701 * (T_vals / Tc)**(5/2)
    E2 = (3/2) * T_vals

    cv1 = 1.925 * (T_vals / Tc)**(3/2)


    z1 = 1
    z2 = 2.612 * (Tc / T_vals)**(3/2)

    f01 = 1 - (T_vals / Tc)**(3/2)

    plt.figure(1)
    plt.plot(T_vals[T_vals<=Tc], E1, '-r')
    plt.plot(T_vals[T_vals>Tc], E2, '-r')
    plt.plot(T_vals, E_mean/N, 'xb')

    plt.figure(2)
    plt.plot(T_vals(T_vals<=Tc), cv1, '-r')
    plt.plot(T_vals(T_vals>Tc), E2, '-r')

    plt.figure(3)

    plt.figure(4)

    plt.show()









    





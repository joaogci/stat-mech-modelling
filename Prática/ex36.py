import time
import numpy as np
import matplotlib.pyplot as plt

def metropolis(N, V, b_mu, t_max, t_equi):
    rec_vals = t_max - t_equi
    Nt = np.zeros(rec_vals)
    
    Ni = np.zeros(V)
    state = np.zeros(V)

    k = 0
    while k < N:
        idx_s = np.random.randint(V)
        if Ni[idx_s] == 0:
            Ni[idx_s] += 1
            state[k] = idx_s
            k += 1

    for t in range(t_max):
        for idx in range(V):
            if np.random.rand() <= 0.5:
                # add a particle
                
                idx_state = np.random.randint(V)
                if Ni[idx_state] == 0:
                    if np.random.rand() <= np.min([1, V/(N+1) * np.exp(b_mu)]):
                        Ni[idx_state] = 1
                        state[N + 1] = idx_state
                        N += 1
            else:
                # remove a particle
                
                idx_p = np.random.randint(N)
                if np.random.rand() <= np.min([1, N/V * np.exp(- b_mu)]):
                    idx_state = int(state[idx_p])
                    Ni[idx_state] = 0
                    state[idx_p] = state[N]
                    N -= 1
        
        if t >= t_equi:
            Nt[t-t_equi] = N
    
    return Nt

if __name__ == "__main__":
    L = 10
    V = L**2
    N = 10

    b_mu_vals = np.array([0.5, 1, 1.5, 2])
   
    for b_mu in b_mu_vals:
        
        start = time.perf_counter()
        
        Nt = metropolis(N, V, b_mu, int(5E4), int(1E3))
        
        wall_time = time.perf_counter() - start
        print(f"Wall time for m_bu {b_mu} is {wall_time}s")
        
        N_mean = np.average(Nt)
        N_mean_theo = V * (np.exp(b_mu))/(1 + np.exp(b_mu))
        
        print(f"Computed value for N: {N_mean};\nTheoretical value for N: {N_mean_theo}")
        print()
        
        rhot = Nt / V
        n_bins = 20
        drho = (np.max(rhot) - np.min(rhot)) / n_bins
        
        values, bins = np.histogram(rhot, bins=np.arange(np.min(rhot)+drho/2, np.max(rhot)+drho/2, drho))

        values = values / np.sum(values) / drho
        
        plt.figure(1)
        x = np.arange(0, 1, 0.001)
        xm = np.exp(b_mu) / (1 + np.exp(b_mu))
        sigma = np.sqrt(V * np.exp(b_mu) / (1 + np.exp(b_mu))**2)
        
        P = V / (sigma * np.sqrt(2 * np.pi)) * np.exp(- (V**2) * ((x - xm)**2) / (2 * sigma**2))
        
        plt.plot(bins[:-1], values, '*')
        plt.plot(x, P)
        plt.xlim([0, 1])
    
    plt.show()
    
    


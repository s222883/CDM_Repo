import sage.all

def FFT_(n, p, w, k = 0): 
    k += 1
    r0 = 0; r1 = 0;
    f = p.coefficients(sparse = False)
    if (n == 1):
        return f[0]
    for j in range(n/2):
        r0 += (f[j] + f[j+n/2]) * x^j
        r1 += (f[j] - f[j+n/2]) * w^j * x^j
    print(r0)
    print(r1)
    FFT(n/2, p, w^2, k = k)
    ret = []
    for i in range(n/2 - 1):
        ret.append([r0[w^(2*i)], r1[w^(2*i)]])
    return ret

# Compute the FFT of a polynomial using the Cooley-Tukey algorithm
def fft_poly(p, omega, n):
    # Generate a sequence of n complex roots of unity
    omega_sequence = [omega^i for i in range(n)]
    # Convert the polynomial to a sequence of complex numbers
    f = [c for c in p.coefficients(sparse=False)]
    # Compute the FFT of the complex sequence
    F = fft(n, f, omega_sequence)
    # Convert the result back to a polynomial
    P = sum([F[i] * x^i for i in range(0, n)])
    return P

# Compute the FFT using the Cooley-Tukey algorithm
def fft(n, f, omega):
    if n == 1:
        return f
    else:
        f_even = [f[i] for i in range(0, n, 2)]
        f_odd = [f[i] for i in range(1, n, 2)]
        omega_even = [omega[i] for i in range(0, n, 2)]
        omega_odd = [omega[i] for i in range(1, n, 2)]
        F_even = fft(n/2, f_even, omega_even)
        F_odd = fft(n/2, f_odd, omega_odd)
        F = [0] * n
        for k in range(0, n/2):
            F[k] = F_even[k] + omega[k] * F_odd[k]
            F[k + n/2] = F_even[k] - omega[k] * F_odd[k]
        return F
   


R.<x> = PolynomialRing(Integers(5))
n = 4
w = 2
p = x^3 + x + 1
ret = fft_poly(p,n, w)
print(ret)

        
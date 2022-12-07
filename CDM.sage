import sage.all
import numpy as np
# Extended Euclidean Algorithm
def EEA(p1, p2):
    rho0 = p1.leading_coefficient()
    rho1 =  p2.leading_coefficient()
    r0 = p1/rho0
    r1 = p2/rho1
    s0 = 1/rho0
    s1 = 0
    t0 = 0
    t1 = 1/rho1
    i = 0
    while (r1!=0):
        q, rem = r0.quo_rem(r1)
        print(f'q_{i} = {q}')
        rho0 = rho1
        if (rem == 0):
            rho1 = 1
        else:
            rho1 = rem.leading_coefficient()
        r0 = rem/ rho1 
        temp = r1
        r1 = r0
        r0 = temp

        s0 = (s0 - q*s1)/ rho1
        temp = s1
        s1 = s0
        s0 = temp

        t0 = (t0 - q*t1)/ rho1
        temp = t1
        t1 = t0
        t0 = temp
        i+=1
    
    return i-1, rho0, r0, s0, t0

if __name__ == '__main__': 
    R.<x> = PolynomialRing(QQ)
    p1 = 18*x^3 - 42*x^2 + 30*x - 6
    p2 = -12*x^2 + 10*x - 2
    l, rho0, r0, s0, t0 = EEA(p1, p2)
    print(f'l = {l}')
    print(f'rho = {rho0}')
    print(f'r = {r0}')
    print(f's = {s0}')
    print(f't = {t0}')

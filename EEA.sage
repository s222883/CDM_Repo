import sage.all
import numpy as np
# Extended Euclidean Algorithm
def EEA(p1, p2, typ = 'pol'):
    """Compute the 
    Args:
        p1 (_type_): pol1
        p2 (_type_): pol2
    Returns:
        _type_: EEA(pol1, pol2)
    """
    if typ == 'pol':
        rho0 = p1.leading_coefficient() ;rho1 =  p2.leading_coefficient()
        r0 = p1/rho0; r1 = p2/rho1
    else:
        rho0 = 1; rho1 =  1
        r0 = p1; r1 = p2
        
    s0 = 1/rho0; s1 = 0; t0 = 0; t1 = 1/rho1
    i = 0
    while (r1!=0):
        if typ == 'pol':
            q, rem = r0.quo_rem(r1)
            if (rem == 0):
                rho1 = 1
            else:
                rho0 = rho1
                rho1 = rem.leading_coefficient()
        elif typ == 'int':
            q, rem = divmod(r0, r1)
        elif typ == 'complex':
            gaussian_quo = lambda a,b : ZI(real(a/b).round() + I*imag(a/b).round())
            gaussian_rem = lambda a,b: a - gaussian_quo(a,b)*b
            q = gaussian_quo(r0,r1)
            rem = gaussian_rem(r0,r1)

        print(f'q_{i} = {q}')
        rho0 = rho1; r0 = rem/ rho1; temp = r1
        r1 = r0; r0 = temp
        s0 = (s0 - q*s1)/ rho1
        temp = s1
        s1 = s0; s0 = temp
        t0 = (t0 - q*t1)/ rho1
        temp = t1
        t1 = t0; t0 = temp
        i+=1
    l = i-1
    print(f'l = {l}')
    print(f'rho = {rho0}')
    print(f'r = {r0}')
    print(f's = {s0}')
    print(f't = {t0}')
    print('------------------------------------------------')
    print(f'gcd(p1,p2) = {r0} = ({s0})({p1}) + ({t0}) ({p2})')
    print('------------------------------------------------')
    return l, rho0, r0, s0, t0

if __name__ == '__main__': 
    #R.<x> = PolynomialRing(QQ)
    R.<x> = PolynomialRing(Integers(5))
    p1 =  x^3 - x + 2 #Integer(126) # 18 *x^3 - 42*x^2 + 30*x - 6
    p2 =  x^2 #Integer(35) #-12 *x^2 + 10*x - 2
    l, rho0, r0, s0, t0 = EEA(p1, p2, 'pol')
    
    # Complex
    ZI = QuadraticField(-1, 'I').ring_of_integers()
    p1 = ZI(7 + 8*I)
    p2 = ZI(2 + 3*I)
    l, rho0, r0, s0, t0 = EEA(p1, p2, 'complex')

    # Equation
    p1 = 17
    p2 = 1000
    EEA(p1, p2, 'complex')

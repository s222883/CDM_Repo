import sage.all

def EEA(p1, p2, field, typ = 'pol'):
    """Compute the 
    Args:
        p1 (_type_): pol1
        p2 (_type_): pol2
    Returns:
        _type_: EEA(pol1, pol2)
    """
    print('-------------------------')
    print(f'Starting EEA with to find gcd({p1}, {p2})')
    if typ == 'pol':
        rho0 = p1.leading_coefficient() ;rho1 =  p2.leading_coefficient()
        r0 = p1/rho0; r1 = p2/rho1
    else:
        rho0 = 1; rho1 =  1
        r0 = p1; r1 = p2
        
    s0 = 1/rho0; s1 = 0; t0 = 0; t1 = 1/rho1
    i = 1
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
            print('r0=',r0)
            print('r1=',r1)
            print('q=',q)

            rem = gaussian_rem(r0,r1)
        print('-----------')
        print('i =', i)
        print('-----------')
        print(f'q_{i} = {q}')
        rho0 = rho1; 
        r0 = rem/ rho1
        print(f'r_{i+1} = {r0}')
        temp = r1
        r1 = r0
        r0 = temp
        s0 = (s0 - q*s1)/ rho1
        print(f's_{i+1} = {s0}')
        temp = s1
        s1 = s0; s0 = temp
        t0 = (t0 - q*t1)/ rho1
        print(f't_{i+1} = {t0}')
        temp = t1
        t1 = t0; t0 = temp
        i+=1
    print('-----------')
    print('RESULTS:')
    print('-----------')
    l = i-1
    print(f'l = {l}')
    print(f'rho = {rho0}')
    print(f'r = {r0}')
    print(f's = {s0}')
    print(f't = {t0}')
    print('------------------------------------------------')
    print(f'gcd(p1,p2) = {r0} = ({s0})p1 + ({t0})p2 = ({s0})({p1}) + ({t0}) ({p2})')
    print('End of EEA, back to CRT')
    print('------------------------------------------------')
    return l, rho0, r0, s0, t0


# Chinese Remainder Theorem
def chinese_remainder(remainders, modules, field, quo=lambda a,b:a//b, typ = 'int'):
    """
    INPUT:
        A list of remainders v_i and pairwise coprime modules m_i
        representing a system of congruences {x == v_i mod },
        where v_i, m_i belong to an euclidean domain ED
    OUTPUT:
        A solution of the system of congruences in the domain ED
    """
    i = 0
    m = reduce(lambda x,y:x*y, modules)
    c = 0
    print(f'With m = {m}')
    for v_i, m_i in zip(remainders, modules):
        print('---------------------')
        print(f'Iteration of CRT: {i}:')
        m_div_m_i = quo(m, m_i)
        _,_,_, s_i, _ = EEA(m_div_m_i, m_i, field = field, typ = typ)

        a = v_i * s_i; b = m_i
        c_i = a - quo(a,b)*b

        c += c_i * m_div_m_i
       
        print(f'c_{i} = {c_i}')
        print(f'm_{i} = {m_i}')
        print(f's_{i} = {s_i}')
        print(f'v_{i} = {v_i}')
        i+=1
    return c

if __name__ == '__main__':
    # EXAMPLE ON Z
    # remainders = [ZZ(2), ZZ(7)]
    # modules = [ZZ(11), ZZ(13)]
    # print("System to be solved:")
    # for r,m in zip(remainders, modules):
    #     print("x == {} (mod {})".format(r,m))
    # solution = chinese_remainder(remainders, modules)
    # print('---------------------')
    # print("A solution of the system is {}".format(solution))
    # print('---------------------')

    # EXAMPLE ON Z[i]
    # ZI = QuadraticField(-1, 'I').ring_of_integers()
    # gaussian_quo = lambda a,b : ZI(real(a/b).round() + I*imag(a/b).round())
    # gaussian_rem=lambda a,b: a - gaussian_quo(a,b)*b
    # remainders = [ZI(2+3*I),ZI(7+5*I)]
    # modules = [ZI(11), ZI(13-I)]
    # print("System to be solved:")
    # for r,m in zip(remainders, modules):
    #     print("x == {} (mod {})".format(r,m))
    # solution = chinese_remainder(remainders, modules, gaussian_quo, typ = 'complex')
    # print('---------------------')
    # print("A solution of the system is {}".format(solution))
    # print('---------------------')
    #check that the solution is correct
    # for r, m in zip(remainders, modules):
    #     print(gaussian_rem(solution, m) / r)
    #     assert(gaussian_rem(solution - r, m) == 0)

    # EXAMPLE ON Z[x]
    Z.<x> = PolynomialRing(Integers(5))
    remainders = [1, 2, 4]
    modules = [x, (x-1), (x-2)]
    print("System to be solved:")
    for r,m in zip(remainders, modules):
        print("x == {} (mod {})".format(r,m))
    solution = chinese_remainder(remainders, modules, field = Z, typ = 'pol')
    print('---------------------')
    print("A solution of the system is {}".format(solution))
    print('---------------------')

import sage.all

def FFT(n, p, w, k=0, flag = 'Initial'): 
    # print(n, p)
    r0 = [0]*(n//2); r1 = [0]*(n//2)
    if (n == 1):
        return p
    # print(p, n)
    for j in range(n/2):
        r0[j] = (p[j] + p[j+n/2])
        r1[j] = (p[j] - p[j+n/2]) * w^j
    print('--------------')
    print(k, flag)
    print(r0)
    print(r1)
    print('--------------')
    sol1 = FFT(n//2, r0, w^2,k=k+1, flag = 'R0')
    sol2 = FFT(n//2, r1, w^2,k=k+1, flag = 'R1')
    # print(sol1)
    # print(sol2)
    ret = [0]*Integer(n)
    for i in range(n/2):
        ret[2*i] = sol1[i]
        ret[2*i+1] = sol2[i]
    return ret

R.<x> = PolynomialRing(Integers(5))
n = 4
w = 2
#p = x^3 + x + 1
p=[1, 1, 0, 1]
ret = FFT(n, p, w, flag = 'Initial')

print('The solution is:', ret)

        
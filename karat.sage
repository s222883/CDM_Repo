def karat(n,f,g):
	# n has to be power of 2
	# f and g are a list of coefficient of polynomials of length n (starting with the lower exponent)
	if len(f)!=n and len(g)!=n:
		raise TypeError("f and g have to be list of length n = "+str(n))
	elif n==1:
		return [f[0]*g[0]]
	else:
		k=n//2
		f0=[0]*k
		f1=[0]*k
		g0=[0]*k
		g1=[0]*k
		ff1=[0]*k
		gg1=[0]*k
		for i in range(k):
			f0[i]=f[i]
			f1[i]=f[i+k]
			g0[i]=g[i]
			g1[i]=g[i+k]
			ff1[i]=f[i]+f[i+k]
			gg1[i]=g[i]+g[i+k]
		z=karat(k,f0,g0)
		w=karat(k,f1,g1)
		y=karat(k,ff1,gg1)
		ans=[0]*(2*n)
		for i in range(len(w)):
			ans[i+n]+=w[i]
			ans[i+k]+=y[i]-z[i]-w[i]
			ans[i]+=z[i]
		return ans
			
f=[1,1,1,1,1,1,1,1]
g=[1,5,4,5,1,2,3,4]
n=8

fg=karat(n,f,g)
ss=str(fg[0])

for i in range(1,len(fg)):
	ss+=" + "+str(fg[i])+"x^"+str(i)
print(ss)

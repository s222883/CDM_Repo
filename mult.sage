def print_pol(l,bef=""):
	n=len(l)
	s=bef+" "
	for i in range(n-1,1,-1):
		if l[i-1]<0:
			ss=" - "
		else:
			ss=" + "
		if i!=n-1:
			s+=str(abs(l[i]))+"x^"+str(i)+ss
		else:
			s+=str(l[i])+"x^"+str(i)+ss
	if l[0]<0:
		ss="x - "
	else:
		ss="x + "
	s+=str(abs(l[1]))+ss+str(abs(l[0]))
	print(s)


def l2(n):
	# calculates log_2(n) exactly, if n is power of 2, otherwise error is raised
	k=0
	pp=n
	while pp!=0:
		pp=pp//2
		k+=1
	k=k-1
	if (2**k!=n):
		raise TypeError("n is not power of 2")
	return k


def karat(n,f,g):
	# n has to be power of 2
	# f and g are a list of coefficient of polynomials of length n
	l2(n)
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
		ans=[0]*(2*n-1)
		for i in range(len(w)):
			ans[i+n]+=w[i]
			ans[i+k]+=y[i]-z[i]-w[i]
			ans[i]+=z[i]
		return ans


def long(l):
	# elongaetes list l to have len power of 2
	n=len(l)
	p=1
	while p<n:
		p=2*p
	ans=[0]*p
	ans[:n]=l[:]
	return ans

def sp(l):
	# returns a shorter list eliminating zeros that are at the end
	n=len(l)
	i=n-1
	while l[i]==0:
		i-=1
	return l[:i+1]

def gen_mij(l):
	# l is list of u_i's
	# l must have length power of 2
	n=len(l)
	k=l2(n)
	M=[0]*(k+1)
	pp=n
	for i in range(k+1):
		M[i]=[0]*pp
		pp=pp//2
	for j in range(n):
		M[0][j]=[-l[j],1] # x - u_j
	for i in range(1,k+1):
		p2=2**i
		p3=2**(k-i)
		for j in range(p3):
			if len(M[i-1][2*j])!= p2:
				f=long(M[i-1][2*j])
			else:
				f=M[i-1][2*j]
			if len(M[i-1][2*j+1])!=p2:
				g=long(M[i-1][2*j+1])
			else:
				g=M[i-1][2*j+1]
			M[i][j]=sp(karat(p2,f,g))
	return M

def print_mij(M,n,k):
	for j in range(n):
		print_pol(M[0][j],"M_0,"+str(j)+" =")
		print('------------')
	for i in range(1,k+1):
		p2=2**i
		p3=2**(k-i)
		for j in range(p3):
			print_pol(M[i][j],"M_"+str(i)+","+str(j)+" =")
			print('------------')

l=list(range(1,9))
M=gen_mij(l)
n=len(l)
k=l2(n)
print_mij(M,n,k)

f=[1,1,1,1,1,1,1,1]
g=[1,-4,4,5,1,2,3,-4]
n=8
fg=karat(n,f,g)


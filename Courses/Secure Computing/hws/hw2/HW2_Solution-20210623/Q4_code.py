from Crypto.Util.number import inverse, long_to_bytes

#####    data   #####

# p = 1830213987675567884451892843232991595746198390911664175679946063194531096037459873211879206428207
# q = 1830213987675567884451892843232991595746198390911664175679946063194531096037459873211879206428213
e = 65537
ct = 2313195752542497971491031851562670810625455536918526752828462894760233019309262121284094881375024592057853084050356639206083254842113256208272961255132533718385419499135351324957142526657429040
n = 3349683240683303752040100187123245076775802838668125325785318315004398778586538866210198083573169673444543518654385038484177110828274648967185831623610409867689938609495858551308025785883804091

#####  factorization without tools #####

def isqrt(n):
  x = n
  y = (x + n // x) // 2
  while y < x:
    x = y
    y = (x + n // x) // 2
  return x

# fermat factorization
def fermat(n, verbose=False):
    a = isqrt(n) # int(ceil(n**0.5))
    b2 = a*a - n
    b = isqrt(n) # int(b2**0.5)
    count = 0
    while b*b != b2:
        if verbose:
            print('Trying: a=%s b2=%s b=%s' % (a, b2, b))
        a = a + 1
        b2 = a*a - n
        b = isqrt(b2) # int(b2**0.5)
        count += 1
    p=a+b
    q=a-b
    assert n == p * q
    return p, q
 
######
p, q = fermat(n)
phi = (p - 1) * (q - 1)
d = inverse(e, phi)
plain = pow(ct,d,n)
print(long_to_bytes(plain))
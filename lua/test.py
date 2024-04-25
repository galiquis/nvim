'''
This is a test file to check the type hinting in Python.
'''

from typing import List


def primes(n: int) -> List[int]:
    """Return a list of prime numbers less than n."""
    if n < 2:
        return []
    primes = [2]
    for i in range(3, n):
        for p in primes:
            if i % p == 0:
                break
        else:
            primes.append(i)
    x = 0
    return primes


xs = primes(100)
ys = primes("foo")
print(xs)

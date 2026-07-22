---
title: "Math"
comments: true
date: '2026-05-24T15:45:30+08:00'
draft: false
categories: []
tags: []
description: ""
type: docs
---

> Translated from Chinese by an LLM.

## Essential Math

Essential math knowledge (in Bi Dao's words, this is all second-grade material).
### Modular Arithmetic
This is very important - many problems require taking the remainder of the result.<br>
$$
\begin{gathered}
    \text{If } a \equiv b \pmod{n} \text{ and } c \equiv d \pmod{n}\text{, then} \\
    a \pm c \equiv b \pm d \pmod{n}\\
    ac \equiv bd \pmod{n}
\end{gathered}
$$
#### Modular Inverse

$$
\begin{gathered}
    \text{If there exists a number }x\text{ such that } b \cdot x \equiv 1 \pmod{c}\\
    \text{then }x\text{ is the modular inverse of }b\text{, denoted }b^{-1}\text{. In that case } \frac{a}{b} = a \cdot x \pmod{n}
\end{gathered}
$$


### Parity
**Modulo method**<br>
`return x % 2;`<br>
**`AND` operation**<br>
Essentially an `AND` operation with `1`.
`return x & 1;`<br>

Bitwise operations are clearly much faster than the modulo method.

### Factorial
For any positive integer $n$, $n! = n*(n-1)*(n-2)*...*1$<br>
When you need to use `factorials of different numbers` extensively, a lot of redundant computation occurs. In that case, you can build an array to store them.

### Sum of the first $n$ natural numbers
#### Loop / Recursion method
This method is too slow, but the logic is simple. Time complexity $O(n)$ - very slow.
``` cpp
int sum(int n){
    int ans = 0;
    for(int i = 1;i<=n;i++){
        ans += i;
    }
    return ans;
}
```

#### Formula method
This is clearly an arithmetic series, so:
$$
S = \frac{(n+1)n}{2}
$$
In this formula, $(n+1)n$ is too large. Rearranging slightly:
$$
S = (\frac{n+1}{2})n
$$
This reduces the risk of overflow. ~If you don't cast to `double`, remember to check the parity of `n`.~

### Fast Exponentiation
$$
\begin{gathered}
    \text{If } a + b = n\text{, then:}\\
    x^{n} = x^{a} \cdot x^{b}\\
    \text{By this principle, a positive integer }n\text{ can be decomposed into } 2^a + 2^b + 2^c +...+1
\end{gathered}
$$

Hence the following code:
``` cpp
long long qpow(long long a, long long b) {
    long long res = 1;
    for (; b; b >>= 1, a = a * a) // WTF, AI writes code this well?
        if (b & 1) res *= a;
    return res;
}
```

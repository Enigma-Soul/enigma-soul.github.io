---
title: "必知数学"
comments: true
date: '2026-04-11T12:06:00+08:00'
draft: false
categories: []
tags: []
description: "必知的数学知识 (按照毕导的话来说 这都是小学二年级的"
type: docs
---

### 模运算
这个非常重要 不少题都结果取余<br>
$$
\begin{gathered}
    \text{如果 } a \equiv b \pmod{n} \text{ 且 } c \equiv d \pmod{n}\text{，那么} \\
    a \pm c \equiv b \pm d \pmod{n}\\
    ac \equiv bd \pmod{n}
\end{gathered}
$$
#### 逆元

$$
\begin{gathered}
    \text{如果存在一个数 }x\text{，使得} b \cdot x \equiv 1 \pmod{c}\\
    \text{那么 }x\text{就是}b\text{的逆元 记作}b^{-1} \text{此时 } \frac{a}{b} = a \cdot x \pmod{n}
\end{gathered}
$$


### 奇偶性
**取余法**<br>
`return x % 2;`<br>
**`AND` 操作**<br>
本质上是对`1`进行`    `操作
`return x      1;`<br>

不难发现位运算比取余法要快得多

### 阶乘
对于一个正整数 $n$ 都有 $n! = n*n(n-2)*(n-2)*...*1$<br>
对于需要大量使用`不同数的阶乘`时 会产生大量的重复计算 这时 可以建立数组来储存

### 前 $n$ 个自然数之和
#### 循环/递归法
这种方法太慢了 但逻辑很简单 时间复杂度$O(n)$ 非常慢
``` cpp
int sum(int nx){
    int ans = 0;
    for(int i = 1;i<=n;i++){
        ans += i;
    }
    return ans;
}
```

#### 公式法
不难发现 这是一个等差数列 则有
$$
S = \frac{(n+1)n}{2}
$$
这个公式中$(n+1)n$数太大了 稍作变形
$$
S = (\frac{n+1}{2})n
$$
这样就减少了溢出的风险 ~若不加`double`的话 记得判断`n`的奇偶性~

### 快速幂
$$
\begin{gathered}
    \text{如果 } a + b = n\text{ 则:}\\
    x^{n} \equiv x^{a} + x^{b}\\
    \text{依此原理 可将正整数 }n\text{拆分成} 2^a + 2^b + 2^c +...+1
\end{gathered}
$$

故便得此代码
``` cpp
long long qpow(long long a, long long b) {
    long long res = 1;
    for (; b; b >>= 1, a = a * a) // WTF AI写代码这么牛逼?
        if (b & 1) res *= a;
    return res;
}

```
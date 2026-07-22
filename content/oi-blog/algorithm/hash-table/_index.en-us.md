---
title: "Hash Table"
comments: true
date: '2026-06-06T12:57:32+08:00'
draft: false
categories: [OI]
tags: []
description: "Insert, delete, update, and query any value in nearly O(1) complexity"
type: docs
---

> Translated from Chinese by an LLM.

### 0. Prerequisites

- **Required**: "Arrays / `vector`", "Time complexity analysis"
- **Strongly related**: "`Hash` functions"

---

### 1. Basic Concepts

- **Definition**:
  Also called a `hash table` - a data structure that stores data in key-value form.
  ![Index](./gif/insert.gif)
- **What problem it solves**:
  Slow insert, delete, update, and query. A hash table achieves nearly $O(1)$ time complexity.
- **Core idea**:
  Trade space for time.
- **Key terms**:
  Load factor: $\text{load factor}=\frac{\text{number of elements}}{\text{number of buckets}}$
  Resize: when $\text{number of elements} > \text{load factor} * \text{number of buckets}$, increase the bucket count.

---

### 2. Algorithm Flow / Derivation

1. **Step 1**: Allocate a large contiguous block of memory.
2. **Step 2**: Take an input `key` and `hash` it.
3. **Step 3**: Look up the memory at the `hash` position and read or write the value.
4. **Step 4**: Check the `bucket count` and `element count`; if the threshold is exceeded, `resize`.

**Why this is correct**:

- Every `key` has a unique `hash`.

**Diagram / Manual example**:

**Insert**
![Insert](gif/insert.gif)
**Delete**
![Delete](gif/delete.gif)
**Search**
![Search](gif/search.gif)
**Collision handling**
![Collision](gif/collision.gif)

---

### 3. Complexity Analysis

**Ideal case**

| Complexity | Best | Average | Worst |
|--------|------|------|------|
| Time   | $O(1)$ | $O(1)$ | $O(1)$ |
| Space   | $O(n)$ | $O(n)$ | $O(n)$ |

- **Where the complexity comes from**:
  $$
  \begin{matrix}
    f(hash(key)) = value
  \end{matrix}
  $$
- **Feasible data range**: limited by memory size.

---

### 4. Applicable Scenarios

- **Suitable problem types**: simplifying computation, heavy insert/delete/update/query.
- **Data range**: no restriction.
- **When not to use / failure cases**: insufficient memory. ~~rarely happens~~

---

### 5. Code Template

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);

    unordered_map<int,int> _map;

    return 0;
}
```

---

### 6. Key Points & Caveats

1. **Boundary conditions**:
   None.
2. **Common pitfalls**:
   Haven't implemented one by hand yet - will update when I do.
3. **Optimization tips**:
   This itself is the optimization technique. Some problems can be optimized with `unordered_map`.
4. **Easily confused points**:
   `map` is implemented with a `red-black tree`.
   `unordered_map` is implemented with a `hash table`.

---

### 7. Example Problems

| Problem | Source | Difficulty | Link |
|------|------|------|------|
| [Template] Hash Table | Luogu | Orange | [P11615](https://www.luogu.com.cn/problem/P11615) |

**P11615**:
- Problem:
  Fast-read numbers and store them in a `hash table`. Some numbers share congruence relations, causing `TLE`.
- Approach:
  Hand-write a `hash table` for heavy insert/delete/update/query. Due to congruence relations, a bijection or a hand-written `hash table` is needed.
  ``` cpp
  char buf[1 << 23], *p1 = buf, *p2 = buf;
  #define gc() (p1==p2&&(p2=(p1=buf)+fread(buf,1,1<<21,stdin),p1==p2)?EOF:*p1++)

  inline void rd(ull &x) { // Read a 64-bit unsigned integer
      x = 0;
      char ch = gc();
      while (!isdigit(ch))
          ch = gc();
      while (isdigit(ch))
          x = x * 10 + (ch ^ 48), ch = gc();
  }


  // A trick: use this function to build a bijection and break congruence relations
  inline void fuck_rd(ull &x) {
      x = 0;
      ull len = 1;
      bool flag = false;
      char ch = gc();
      while (!isdigit(ch))
          ch = gc();
      while (isdigit(ch)){
          int cur = (ch ^ 48);
          if(cur){
              x += len * (ch ^ 48);
              ch = gc();
              if(flag) x -= len/10;
              len *= 10;
              flag = false;
          }else{
              x += len;
              ch = gc();
              if(flag) x -= len/10;
              len *= 10;
              flag = true;
          }
      }
      x += len; // x += len * (positive integer) prevents excessive collisions when the bijection is reversed
      if(flag) x -= len/10;
  }

  ```
- Pitfall: **A large number of numbers sharing congruence relations causes** `unordered_map` **to degrade to** $O(n)$.

---

### 8. Related Algorithms / Extensions

- **One-line summary**: $O(1)$ insert, delete, update, and query.

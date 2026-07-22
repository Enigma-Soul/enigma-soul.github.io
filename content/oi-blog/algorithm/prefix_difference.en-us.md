---
title: "Prefix Sum & Difference"
comments: true
date: '2026-03-20T19:00:22+08:00'
draft: false
categories: [OI]
tags: [prefix,difference]
description: "Notes on prefix sums and difference arrays"
type: docs
---

> Translated from Chinese by an LLM.

## Prefix Sum & Difference

### 1. Basic Concepts

- **Definition**:
  Prefix sum: the sum of all preceding elements in an array.<br>
  Difference: the difference between an element and its predecessor in an array.

  Divided into 1D prefix sums and multi-dimensional prefix sums.

  The inclusion-exclusion principle makes it unrestricted (just verbose).

- **Purpose**:
  Fast query and fast increment/decrement over intervals.
- **Core idea**:
  [Inclusion-exclusion principle](https://oi-wiki.org/math/combinatorics/inclusion-exclusion-principle/)

### 2. Complexity Analysis

| Complexity | Best | Average | Worst |
|--------|------|------|------|
| Time   |      |$ O(1) $|      |
| Space   |      |$ O(n) $|      |

### 3. Applicable Scenarios

- Suitable problem types: simultaneous increment/decrement over different intervals.
- Data range: the sum must fit below `__int128`, otherwise big integers are needed.
- Constraints: memory must be contiguous.

### 4. Code Templates

#### 1D Prefix Sum
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5 + 10;
int a[N], sum[N];  // a is the original array, sum is the prefix sum array

// Build the prefix sum
void buildPrefix(int n) {
    sum[0] = 0;
    for (int i = 1; i <= n; i++) {
        sum[i] = sum[i - 1] + a[i];
    }
}

// Query the sum of interval [l, r]
int query(int l, int r) {
    return sum[r] - sum[l - 1];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    buildPrefix(n);

    // Query m times
    while (m--) {
        int l, r;
        cin >> l >> r;
        cout << query(l, r) << '\n';
    }

    return 0;
}
```

#### 2D Prefix Sum
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1010;
int a[N][N], sum[N][N];

// Build the 2D prefix sum
void buildPrefix(int n, int m) {
    for (int i = 0; i <= n; i++) sum[i][0] = 0;
    for (int j = 0; j <= m; j++) sum[0][j] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            // Inclusion-exclusion: S[i][j] = S[i-1][j] + S[i][j-1] - S[i-1][j-1] + a[i][j]
            sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + a[i][j];
        }
    }
}

// Query the sum of submatrix (x1,y1) to (x2,y2)
int query(int x1, int y1, int x2, int y2) {
    return sum[x2][y2] - sum[x1 - 1][y2] - sum[x2][y1 - 1] + sum[x1 - 1][y1 - 1];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m, q;
    cin >> n >> m >> q;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cin >> a[i][j];
        }
    }

    buildPrefix(n, m);

    // Query q times
    while (q--) {
        int x1, y1, x2, y2;
        cin >> x1 >> y1 >> x2 >> y2;
        cout << query(x1, y1, x2, y2) << '\n';
    }

    return 0;
}
```

#### 1D Difference
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5 + 10;
int a[N], diff[N];  // a is the original array, diff is the difference array

// Build the difference array
void buildDiff(int n) {
    diff[1] = a[1];
    for (int i = 2; i <= n; i++) {
        diff[i] = a[i] - a[i - 1];
    }
}

// Add c to every element in interval [l, r]
void add(int l, int r, int c) {
    diff[l] += c;
    diff[r + 1] -= c;
}

// Restore the array
void restore(int n) {
    for (int i = 1; i <= n; i++) {
        a[i] = a[i - 1] + diff[i];
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    buildDiff(n);

    // m interval modifications
    while (m--) {
        int l, r, c;
        cin >> l >> r >> c;
        add(l, r, c);
    }

    // Restore and output
    restore(n);
    for (int i = 1; i <= n; i++) {
        cout << a[i] << " \n"[i == n];
    }

    return 0;
}
```

#### 2D Difference
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1010;
int a[N][N], diff[N][N];

// Interval modification: add c to every element from (x1,y1) to (x2,y2)
void add(int x1, int y1, int x2, int y2, int c) {
    diff[x1][y1] += c;
    diff[x2 + 1][y1] -= c;
    diff[x1][y2 + 1] -= c;
    diff[x2 + 1][y2 + 1] += c;  // Inclusion-exclusion
}

// Restore the 2D array
void restore(int n, int m) {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            // diff[i][j] represents the prefix sum of difference effects
            diff[i][j] += diff[i - 1][j] + diff[i][j - 1] - diff[i - 1][j - 1];
            a[i][j] += diff[i][j];
        }
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m, q;
    cin >> n >> m >> q;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cin >> a[i][j];
        }
    }

    // q interval modifications
    while (q--) {
        int x1, y1, x2, y2, c;
        cin >> x1 >> y1 >> x2 >> y2 >> c;
        add(x1, y1, x2, y2, c);
    }

    // Restore and output
    restore(n, m);
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cout << a[i][j] << " \n"[j == m];
        }
    }

    return 0;
}
```

### 5. Key Points & Caveats

1. **Boundary conditions**: just don't overflow.
2. **Common pitfalls**:
   - When querying the interval a[i] ~ a[j] via prefix sum, you need a[j] - a[i-1].
   - When incrementing the interval a[i] ~ a[j] by x via difference, you need a[i] += x; a[j+1] -= x;

3. **Optimization tips**:
   You can use the difference + prefix sum approach<br>
   to achieve $O(2n+m)$ time complexity for range modifications.<br>
   Note: the brute-force approach is $O(n*m)$.

   Clearly very fast, isn't it?

### 6. Example Problems
[Luogu P8218](https://www.luogu.com.cn/problem/P8218)


**Example 1**:
- Problem: 1D prefix sum.
- Approach: As shown above, query in $O(1)$ after building the prefix sum.

### 7. Related Algorithms / Extensions

- Related algorithms: segment tree.
- Advanced topics: (don't know yet, will study when I have time).

---
title: "前缀和 差分"
comments: true
date: '2026-03-20T19:00:22+08:00'
draft: false
categories: [OI]
tags: [prefix,difference]
description: "前缀和 差分 相关笔记"
type: docs
---


## 前缀和 差分

### 一、基本概念

- **定义**：
前缀和:一个数组内 前面所有元素的和<br>
差分:  一个数组内 此元素与前一个元素的差

分 一位前缀和 和 多维前缀和

容斥原理 使其无限制(就是麻烦)

- **用途**：
区间内 速查 速增减
- **核心思想**：
[容斥原理](https://oi-wiki.org/math/combinatorics/inclusion-exclusion-principle/)

### 二、复杂度分析

| 复杂度 | 最好 | 平均 | 最坏 |
|--------|------|------|------|
| 时间   |      |$ O(1) $|      |
| 空间   |      |$ O(n) $|      |

### 三、适用场景

- 适合的问题类型：不同区间 同时增减
- 数据范围：和必须低于__int128 否则就要高精度了
- 限制条件：内存必须连续

### 四、代码模板

#### 一维前缀和
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5 + 10;
int a[N], sum[N];  // a为原数组, sum为前缀和数组

// 构建前缀和
void buildPrefix(int n) {
    sum[0] = 0;
    for (int i = 1; i <= n; i++) {
        sum[i] = sum[i - 1] + a[i];
    }
}

// 查询区间 [l, r] 的和
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

    // 查询 m 次
    while (m--) {
        int l, r;
        cin >> l >> r;
        cout << query(l, r) << '\n';
    }

    return 0;
}
```

#### 二维前缀和
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1010;
int a[N][N], sum[N][N];

// 构建二维前缀和
void buildPrefix(int n, int m) {
    for (int i = 0; i <= n; i++) sum[i][0] = 0;
    for (int j = 0; j <= m; j++) sum[0][j] = 0;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            // 容斥原理: S[i][j] = S[i-1][j] + S[i][j-1] - S[i-1][j-1] + a[i][j]
            sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + a[i][j];
        }
    }
}

// 查询子矩阵 (x1,y1) 到 (x2,y2) 的和
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

    // 查询 q 次
    while (q--) {
        int x1, y1, x2, y2;
        cin >> x1 >> y1 >> x2 >> y2;
        cout << query(x1, y1, x2, y2) << '\n';
    }

    return 0;
}
```

#### 一维差分
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5 + 10;
int a[N], diff[N];  // a为原数组, diff为差分数组

// 构建差分数组
void buildDiff(int n) {
    diff[1] = a[1];
    for (int i = 2; i <= n; i++) {
        diff[i] = a[i] - a[i - 1];
    }
}

// 区间 [l, r] 每个元素加 c
void add(int l, int r, int c) {
    diff[l] += c;
    diff[r + 1] -= c;
}

// 还原数组
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

    // m 次区间修改
    while (m--) {
        int l, r, c;
        cin >> l >> r >> c;
        add(l, r, c);
    }

    // 还原并输出
    restore(n);
    for (int i = 1; i <= n; i++) {
        cout << a[i] << " \n"[i == n];
    }

    return 0;
}
```

#### 二维差分
```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 1010;
int a[N][N], diff[N][N];

// 区间修改: (x1,y1) 到 (x2,y2) 每个元素加 c
void add(int x1, int y1, int x2, int y2, int c) {
    diff[x1][y1] += c;
    diff[x2 + 1][y1] -= c;
    diff[x1][y2 + 1] -= c;
    diff[x2 + 1][y2 + 1] += c;  // 容斥原理
}

// 还原二维数组
void restore(int n, int m) {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            // diff[i][j] 表示差分影响的前缀和
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

    // q 次区间修改
    while (q--) {
        int x1, y1, x2, y2, c;
        cin >> x1 >> y1 >> x2 >> y2 >> c;
        add(x1, y1, x2, y2, c);
    }

    // 还原并输出
    restore(n, m);
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cout << a[i][j] << " \n"[j == m];
        }
    }

    return 0;
}
```

### 五、关键点 & 注意事项

1. **边界条件**：别溢出就行
2. **常见坑点**：
   - 通过前缀和查询区间a[i] ~ a[j] 时 需要 a[j] - a[i-1]
   - 通过差分增加区间 a[i] ~ a[j]为 x 时 需要 a[i] += x; a[j+1]-=x;
  
3. **优化技巧**：
可以通过 差分+前缀和的方式<br>
实现$O(2n+m)$的区域修改时间复杂度<br>
注: 暴力解法为 $O(n*m)$

显而易见非常快 不是吗?

### 六、例题
[Luogu P8218](https://www.luogu.com.cn/problem/P8218)


**例题1**：
- 题意：一维前缀和
- 思路：前文所示 前缀和后 $O(1)$查询

### 七、相关算法/扩展

- 相关算法：线段树
- 进阶内容：（不会 有空研究研究）

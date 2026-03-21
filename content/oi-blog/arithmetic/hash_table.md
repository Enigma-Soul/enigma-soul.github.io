---
title: "哈希表"
comments: true
date: '2026-03-20T20:34:00+08:00'
draft: false
categories: [OI]
tags: [hash]
description: "哈希表的基本原理"
type: docs
---

## 哈希表

### 一、基本概念

- **定义**：
  又称映射表 对于一个 key 都有且只有一个 value
  在内存中是一段连续的空间<br>
  即 $f(\text{key}) = \text{value}$
- **用途**：
  快速增删改查 (key为int时相当于array 但占用内存更少)
- **核心思想**：
  映射关系 一个好的hash函数所hash出的key较离散(当然也不能太离散) 较离散的hash函数会减少哈希冲突 以此减少时间复杂度(多多少少会有点的)<br>
  #### 负载因子
    哈希表的空间占有率 即
    $$\text{负载因子} = \frac{\text{元素数量}}{\text{容器数量}}$$
    为了在空间和时间中取得平衡 一般这个数是$0.75$ (太大不行 太小也不行)
  #### 扩容
    当$\text{元素数量} > \text{负载因子} * \text{容器数量}$时<br>
    会进行扩容 一般是原$\text{容器数量}$的两倍 并进行`Rehash`

### 二、复杂度分析

| 复杂度 | 最好 | 平均 | 最坏 |
|--------|------|------|------|
| 时间   |$O(1)$|$O(1)$|$O(\log n)$|
| 空间   |&O(n)&|$O(1.25n)$|$O(n * m)$|

空间最坏情况 : 每个元素都会哈希冲突 空间复杂度受方法影响

### 三、适用场景

- 适合的问题类型：大量不同元素 增删改查(类似于array) 
- 数据范围：无（受内存影响）
- 限制条件：`key` 有且只有一个 `value` 而`value`可以对应多个`key`

### 四、代码模板


算法实现去看`STL` 注:下面这俩好像是用`红黑树`实现的
```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    
    unordered_map<int,int> map1;

    set<int> map2;
    
    return 0;
}
```

### 五、关键点 & 注意事项

1. **边界条件**：无
2. **常见坑点**：唯一性`key` 记得处理`哈希冲突` ~~否则等着WA吧~~
3. **优化技巧**：这个就是优化的顶峰 `2025 CSP-J T3`就是用这个优化 结果忘了(笑)

### 六、例题

| 题目 | 来源 | 难度 | 链接 |
|------|------|------|------|
|【模板】字符串哈希|Luogu|橙|[P3370](https://www.luogu.com.cn/problem/P3370)|

**P3370**：
- 题意：string的hash实现
  当然我偷懒用的`set`
- 思路：`set<string>` (笑


### 七、相关算法/扩展

- 相关算法：红黑树
- 进阶内容：快 小 准

---
title: "二分查找"
date: '2026-03-01T17:50:01+08:00'
draft: false
categories: []
tags: []
description: "STL中Lower_bound/Upper_bound"
type: docs
---

### STL定义
``` c++
lower_bound(_ForwardIterator __first, _ForwardIterator __last, const _Tp& __val);
upper_bound(_ForwardIterator __first, _ForwardIterator __last, const _Tp& __val);
```
两个函数中 均返回一个迭代器 唯一区别便是<br>
lower_bound返回**第一个大于等于**的迭代器 upper_bound返回**第一个大于**的迭代器

### 复杂度
在一般的数组里，这两个函数的时间复杂度均为 \(𝑂(logn)\)<br>
但在 `set` 等关联式容器中，直接调用 `lower_bound(s.begin(),s.end(),val)` 的时间复杂度是 $O(\log n)$的．

`set` 等关联式容器中已经封装了 `lower_bound` 等函数（像 `s.lower_bound(val)` 这样），这样调用的时间复杂度是 $𝑂(log⁡ n)$的．

### 返回值
`*::iterator` 可使用*得到值<br>
对于`vector`可使用`result - v.begin()`来得到其在向量中的索引
### 常用用法
事先定义:
``` c++
vector<int> arr = {1,2,3,4,5};
```
查找数组中是否含有某个数
``` c++
int x = 3;
auto result = lower_bound(arr.begin(),arr.end(),x);
return result!=arr.end() && *result == x;
```
查找数组里某个数的个数
``` c++
int x = 3;
auto lower = lower_bound(arr.begin(),arr.end(),x);
auto upper = upper_bound(arr.begin(),arr.end(),x);
return upper-lower;
```

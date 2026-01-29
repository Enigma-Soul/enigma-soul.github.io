---
title: "数组"
date: '2026-01-29T21:47:41+08:00'
draft: false
categories: []
tags: []
description: ""
type: docs
---

## 概述
数组是C/C++很重要的一环 是一种 **线性表** </br>
特点: **随机访问** ，即可以在 O(1) 的时间复杂度内访问任意一个元素。

## 代码实现
```cpp
int arr[5] = {0}; // 默认初始化为0
std::array<int, 5> arr2 = {0}; // C++11支持
```
以上两种方法等效 但C++标准写法```std::array```更安全 ~~不是哥们谁没事喜欢写着一坨啊~~

## 向量
C++ STL中的向量是一种动态数组 可以在 O(1) 的时间复杂度内访问任意一个元素
```cpp
std::vector<int> arr;
```
我觉得这个可以放```std```里讲

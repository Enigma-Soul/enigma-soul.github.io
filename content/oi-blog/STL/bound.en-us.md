---
title: "Binary Search"
comments: true
date: '2026-03-01T17:50:01+08:00'
draft: false
categories: []
tags: []
description: "lower_bound / upper_bound in the STL"
type: docs
---

> Translated from Chinese by an LLM.

### STL Definition
```cpp
lower_bound(_ForwardIterator __first, _ForwardIterator __last, const _Tp& __val);
upper_bound(_ForwardIterator __first, _ForwardIterator __last, const _Tp& __val);
```
Both functions return an iterator. The only difference is:<br>
`lower_bound` returns an iterator to the **first element greater than or equal to** the value; `upper_bound` returns an iterator to the **first element greater than** the value.

### Complexity
For a regular array, both functions have time complexity $O(\log n)$.<br>
But in associative containers like `set`, calling `lower_bound(s.begin(), s.end(), val)` directly has complexity $O(\log n)$.
Associative containers such as `set` already wrap `lower_bound` and similar functions (e.g. `s.lower_bound(val)`), and calling them this way has complexity $O(\log n)$.

### Return Value
`*::iterator` - dereference with `*` to get the value.<br>
For `vector`, you can use `result - v.begin()` to get the index in the vector.

### Common Usage
Given:
```cpp
vector<int> arr = {1,2,3,4,5};
```
Check whether the array contains a certain number:
```cpp
int x = 3;
auto result = lower_bound(arr.begin(),arr.end(),x);
return result!=arr.end() && *result == x;
```
Count occurrences of a number in the array:
```cpp
int x = 3;
auto lower = lower_bound(arr.begin(),arr.end(),x);
auto upper = upper_bound(arr.begin(),arr.end(),x);
return upper-lower;
```

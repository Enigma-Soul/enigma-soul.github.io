---
title: "对拍与样例检查"
comments: true
date: '2026-10-30T22:28:32+08:00'
draft: false
categories: [OI]
tags: [对拍, check, gen, solver]
description: "Windows 考场上可直接使用的对拍 + 官方样例检查模板（check / gen / solver）"
type: docs
---

本文整理 Windows 考场上使用的一套 `对拍` 模板，由三个文件组成

* `check.cpp`：所有题共用，逐组比较正解输出与 `.ans`
* `gen.cpp`：每题一个，造 `.in` 的同时调用暴力生成 `.ans`
* `solver.cpp`：每题一个，暴力解法

官方样例与 `gen` 造的数据放在同一个文件夹，命名都是 `题名K.in` 与 `题名K.ans`，`check` 不需要区分它们

## 目录约定

以 `lamp` 为例，`check.exe` 放在各题文件夹的上一级

```text
考场目录/
├─ check.cpp / check.exe
└─ lamp/
   ├─ lamp.cpp / lamp.exe        正解（用 freopen）
   ├─ solver.cpp / solver.exe    暴力（用 cin / cout）
   ├─ gen.cpp / gen.exe          造数据
   ├─ lamp1.in / lamp1.ans       官方样例
   └─ lamp6.in / lamp6.ans       gen 造的数据
```

## check.cpp

运行后从 `cin` 读入 `题名 起始编号 结束编号 只测正解(0/1)`，对区间内每个存在 `.in` 的编号

* 把 `题名K.in` 复制成 `题名.in`，运行 `题名.exe`
* 把输出 `题名.out` 与 `题名K.ans` 用 `fc` 比较
* 第一个出错的编号会让 `check` 立刻停下

```cpp
// 用法: 运行 check.exe(在各题文件夹的上一级), 输入: 题名 起始编号 结束编号 只测正解(0/1)
// 例: "lamp 1 999 0"  检查 lamp1 ~ lamp999, 不存在 .in 的编号自动跳过
//     "lamp 100 110 1" 大数据: 只看正解能否跑完及用时, 不比对答案
// 运行前需编译好: 题名/题名.exe(正解, 用 freopen)
// 对每个存在的 题名K.in, 把正解的输出与 题名K.ans 比较(官方样例和 gen 造的数据一视同仁)
#include <bits/stdc++.h>
using namespace std;

const int TL = 1000;  // 时限(ms)

string P;       // 题名
bool timeOnly;  // 只测正解
int ms;         // 正解耗时

// [win32] 调用 cmd 执行命令. 先 cd 进题目文件夹, 这样正解 freopen 的 题名.in/.out 就在该文件夹里
// system 只接受 C 字符串, 这是唯一必须用 c_str() 的地方
int run(string cmd) {
    return system(("cd " + P + " && " + cmd).c_str());
}

// 文件是否存在(P 文件夹内)
bool exist(string file) {
    return ifstream(P + "/" + file).good();
}

// [win32] fc 是 Windows 自带的文件比较命令, /w 忽略行末空白, 相同时返回 0; >nul 丢弃它的输出
bool same(string a, string b) {
    return run("fc /w " + a + " " + b + " >nul") == 0;
}

string judge(string name) {
    // [win32] copy /y 覆盖复制; del 删除旧输出, 防止正解没写输出时误用上一次的结果
    run("copy /y " + name + ".in " + P + ".in >nul");
    run("del " + P + ".out 2>nul");

    // [win32] clock() 在 Windows 上返回程序已运行的真实毫秒数
    // [win32] ".\" 表示当前文件夹下的 exe, 部分环境 cmd 不会自动在当前目录找程序
    clock_t begin = clock();
    int code = run(".\\" + P + ".exe");
    ms = clock() - begin;

    if (code != 0) return "RE";
    if (ms > TL) return "TLE";
    if (timeOnly) return "AC";
    return same(P + ".out", name + ".ans") ? "AC" : "WA";
}

int main() {
    int l, r;
    cin >> P >> l >> r >> timeOnly;

    for (int k = l; k <= r; k++) {
        string name = P + to_string(k);
        if (!exist(name + ".in")) continue;

        string res = judge(name);
        cout << name << ": " << res << " " << ms << "ms" << endl;
        if (res != "AC") {
            cout << "stopped. " << P << ".in=input " << P << ".out=sol " << name << ".ans=answer" << endl;
            return 1;
        }
    }
    cout << "all passed" << endl;
}
```

## solver.cpp

暴力只需要正确，不需要快，直接用 `cin` 读入、`cout` 输出，`gen` 会替它做重定向

骨架如下

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    // 读入用 cin, 输出用 cout, 不要 freopen
}
```

以 `lamp` 为例，用 `O(n^2)` 的 `DP` 枚举最后一段的起点

```cpp
// O(n^2) 枚举最后一段的起点做 DP; 中位数为1 <=> 1 的个数 >= ceil(len/2)
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;
    vector<int> s(n + 1), mx(n + 1, 0), mn(n + 1, 1e9);
    for (int i = 1; i <= n; i++) {
        cin >> s[i];
        s[i] += s[i - 1];  // 前缀和: 1 的个数
    }
    mn[0] = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            int lit = 2 * (s[i] - s[j]) >= i - j;  // 段 (j, i] 的指示灯是否点亮
            mx[i] = max(mx[i], mx[j] + lit);
            mn[i] = min(mn[i], mn[j] + lit);
        }
    }
    cout << mx[n] << " " << mn[n] << endl;
}
```

## gen.cpp

换题时只需要改两处：开头的 `NAME` 与 `make()` 里的造数据逻辑，其余部分不动

* 编号小于 100 的是小数据，造完 `.in` 后立刻调用 `solver.exe` 生成 `.ans`
* 编号不小于 100 的是大数据，只造 `.in`，因为暴力跑不动

```cpp
// 用法(在本文件夹内运行): 运行 gen.exe, 输入 起始编号 数量
// 例: 输入 "6 50" 造 lamp6 ~ lamp55 的 .in, 并用 solver.exe(暴力) 生成对应 .ans
// 编号 >= 100 为大数据: 只造 .in, 不生成 .ans (暴力跑不动), 用 check 的"只测正解"模式计时
// 注意: 会覆盖同编号的文件, 起始编号要避开官方样例(lamp1~lamp5)
#include <bits/stdc++.h>
using namespace std;

const string NAME = "lamp";  // 题名, 换题只改这里和 make()

mt19937 rng;  // 随机数引擎, 同一个种子产生同样的序列, 所以数据可复现

// 返回 [l, r] 内的随机整数
int R(int l, int r) { return rng() % (r - l + 1) + l; }

// 往 stdout 写一组数据
void make(bool big) {
    int n = big ? 1000000 : R(1, 10);
    int p = R(0, 4);  // 点亮概率 p/4: p=0 全灭, p=4 全亮
    cout << n << "\n";
    for (int i = 0; i < n; i++) cout << (R(1, 4) <= p) << " ";
    cout << "\n";
}

int main() {
    int start, count;
    cin >> start >> count;
    for (int k = start; k < start + count; k++) {
        string name = NAME + to_string(k);
        bool big = k >= 100;

        // freopen 只接受 C 字符串; 之后 cout 的输出都写进这个文件
        freopen((name + ".in").c_str(), "w", stdout);
        rng.seed(k);  // 用编号当种子
        make(big);
        fflush(stdout);  // 先把数据写到磁盘, 暴力才能读到完整的 .in

        if (big) continue;
        // [win32] system 调用 cmd; ".\" 表示当前文件夹下的 exe; 暴力读 .in, 输出重定向到 .ans
        system((".\\solver.exe < " + name + ".in > " + name + ".ans").c_str());
    }
}
```

## 使用流程

### 准备

* 写好三个程序
1. 在题目文件夹里写好正解 `lamp.cpp`，用 `freopen` 读写 `lamp.in` 与 `lamp.out`，`main` 返回 `0`
2. 写好暴力 `solver.cpp`
3. 复制 `gen.cpp`，把 `NAME` 改成题名，按题目改写 `make()`
* 编译
1. 把 `lamp.cpp`、`solver.cpp`、`gen.cpp` 都编译成 `.exe`，放在题目文件夹里
2. 把 `check.cpp` 编译成 `check.exe`，放在题目文件夹的上一级

### 造数据

* 运行 `gen`
1. 进入题目文件夹，运行 `gen.exe`
2. 输入 `6 50`，得到 `lamp6` 到 `lamp55` 的 `.in` 与 `.ans`
3. *再次运行 `gen.exe`，输入 `100 3`，得到三组只有 `.in` 的大数据*

### 检查

* 运行 `check`
1. 在上一级目录运行 `check.exe`
2. 输入 `lamp 1 99 0`，依次检查官方样例与 `gen` 造的小数据
3. 全部通过时输出 `all passed`
4. *输入 `lamp 100 102 1`，只测正解能否跑完与用时，不比对答案*

### 出错时

* 定位错误数据
1. `check` 停在第一个出错的编号，例如 `lamp7`
2. 题目文件夹里的 `lamp.in` 就是这组输入，`lamp.out` 是正解输出，`lamp7.ans` 是标准答案
3. 直接运行 `lamp.exe` 即可复现，不需要再复制文件

## 输出含义

| 结果 | 含义 |
| --- | --- |
| `AC` | 输出与 `.ans` 一致（只测正解模式下表示正常跑完且未超时）|
| `WA` | 输出与 `.ans` 不一致 |
| `RE` | 正解的返回值不为 `0`，包括崩溃与 `main` 没有 `return 0` |
| `TLE` | 用时超过 `check.cpp` 中的 `TL`，默认 1000ms |

## 注意事项

* `gen` 会覆盖同编号的文件，起始编号要避开官方样例，比如官方样例是 `lamp1` 到 `lamp5`，就从 6 开始
* `.ans` 由暴力生成，改了 `solver.cpp` 或 `gen.cpp` 后，需要重新运行 `gen` 生成同一段编号
* 暴力本身也可能写错，可以运行 `solver.exe < lamp1.in` 把输出与官方的 `lamp1.ans` 手动比较
* 耗时包含启动 `cmd` 的开销，约 20ms，刚编译好的 `.exe` 首次运行可能被杀毒软件拖慢而误报 `TLE`，重跑一次即可
* 代码里 `.\` 前缀是为了兼容设置了 `NoDefaultCurrentDirectoryInExePath` 的环境，该环境下 `cmd` 不会在当前目录里找程序
* `system`、`fc`、`copy`、`del`、`clock` 都是 Windows 相关的调用，已在代码中用 `[win32]` 标注

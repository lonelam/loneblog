---
  title: 2017 Multi-University Training Contest - Team 1
  tags: hdsummer
  date: 2017-7-21
---

# frustrating process
1001 and 1011 is solved instantly, however, I failed to notice a critical feature in 1002, and stuck on it for hours, no need to say that other problem is too difficult for me.
<h2>1006. Function</h2>
考虑置换 $a$ 的一个循环节，长度为 $l$ ，那么有 $f(i) = b_{f(a_i)} = b_{b_{f(a_{a_i})}} = \underbrace{b_{\cdots b_{f(i)}}}_{l\text{ times }b}$ 。

那么 $f(i)$ 的值在置换 $b$ 中所在的循环节的长度必须为 $l$ 的因数。

而如果 $f(i)$ 的值确定下来了，这个循环节的另外 $l - 1$ 个数的函数值也都确定下来了。

答案就是 $\sum_{i = 1}^{k} \sum_{j | l_i} {j \cdot cal_j}$ 改为 $\prod_{i = 1}^{k} \sum_{j | l_i} {j \cdot cal_j}$ ，其中 $k$ 是置换 $a$ 中循环节的个数， $l_i$ 表示置换 $a$ 中第 $i$ 个循环节的长度， $cal_j$ 表示置换 $b$ 中长度为 $j$ 的循环节的个数。

时间复杂度是 $\mathcal{O}(n + m)$ 。

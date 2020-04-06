---
title: 斜率优化DP——寒假集训
tag: [dp, 动态规划]
date: 2016-1-14
---


# 一道入门题

[hdu3507](http://acm.hdu.edu.cn/showproblem.php?pid=3507)


一行上打印连续k个单词的花费为
![公式](http://acm.hdu.edu.cn/data/images/3507-1.jpg)，
给你每个单词的花费 $C_i$，
求最后总的最小花费。


很容易想到的dp式是： $dp[i] = min\{dp[j] + (\sum_{h=j+1}^{i}C_h)^2+M\}$

然而 $n=500000$ 直接这么做的话肯定是做不到 $O(1)$ 的。
于是把上面的式子变形一下，首先斜率优化是针对决策过程而不是dp的，所以关注 $k<j<i$ 这个决策。
$$
dp[j] + (\sum_{h=j+1}^iC_h)^2 +M< dp[k] + (\sum_{h=k+1}^iC_h)^2+M
$$

其中 $\sum_{h=j+1}^iC_h$可以用前缀和来表示。

$$
dp[j] + (presum_i - presum_j)^2 < dp[k] + (presum_i - presum_k)^2
$$

拆开变形,

$$
dp[j] + presum_j^2 - 2*presum_j*presum_i < dp[k] + presum_k^2 - 2*presum_k*presum_i
$$

$$
(dp[j] + presum_j^2) - (dp[k] + presum_k^2) < 2 * presum_i * (presum_j - presum_k)
$$

$$
\frac {(dp[j] + presum_j^2) - (dp[k] + presum_k^2)}{2*(presum_j - presum_k)} < presum_i
$$

令

$$
g(j,k) = \frac {(dp[j] + {presum_j}^2) - (dp[k] + {presum_k}^2)}{2*(presum_j - presum_k)}
$$

也就是说

$$
g(j,k) < presum_i \Leftrightarrow 选取j优于k
$$

$$
g(j,k) > presum_i \Leftrightarrow 选取k优于j
$$

那么从左到右，对 $k<j<i$ ，如果

$$
g(i, j) <= g(j, k)
$$

此时如果在 $\alpha$ 点做决策。

$$
g(i, j) >= presum_\alpha \Rightarrow g(j, k) >= presum_\alpha \Rightarrow 选取k优于j
$$

$$
g(i, j) < presum_\alpha \Rightarrow 选取i优于j
$$

所以j点可以直接排除。
也就是说，对于做过优化的点集，要求

$$
g(i, j) > g(j, k)
$$

恒成立。对于一般的映射g，要维护这个性质需要 $O(n^2)$ 的复杂度。但是这里很多时候可以用斜率优化。。

# 斜率优化

$$
g(j,k) = \frac {(dp[j] + presum_j^2) - (dp[k] + presum_k^2)}{2*(presum_j - presum_k)}
$$

令 $y(j) = dp[j] + presum_j^2, x(j) = 2*presum_j$，这里 $x(j)$ 满足单调性，因此可以把 $presum$ 离散化。
那 $g(i,j)$ 满足

$$
g(i, j) > g(j, k)
$$
也就是对 $x(j), y(j)$ ，后面的斜率比前面的斜率大，保持下凸性。

![斜率图](http://images.cnitblog.com/blog/366690/201307/11190759-dd544ce3648c49eb824db27b7c25cd9b.jpg)

如上图。
这里维护点集的方法和求凸包时使用的方法一样，维护一个队列（栈），对每一个新加入的点，出栈直到
最后满足

$$
g(i,i - 1) > max\{g(j,k)\}, j,k是已经在队列里面的点
$$

求解的时候，

$$
dp[i] = dp[Q.front] + (presum_i - presum_{Q.front})^2 + M
$$

此时，

$$
i > j, g(j, j - 1) > presum_i
$$

$j$ 就是最优决策！

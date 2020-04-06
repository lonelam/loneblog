---
title: 统计学习方法习题1
tags: machine learning
date: "2018-4-8"
---

# 1.1 说明伯努利模型的极大似然估计以及贝叶斯估计中的统计学习方法三要素。伯努利模型是定义在取值为$0$与$1$的随机变量上的概率分布。假设观测到伯努利模型$n$次独立的数据生成结果，其中$k$次的结果为$1$，这时可以用极大似然估计或贝叶斯估计来估计结果为$1$的概率。

伯努利模型的极大似然估计：
$$
\hat{p} = \bar{x}
$$
贝叶斯估计，先验为$\theta \sim U(0, 1)$，则：
$$
\hat{\theta} = \frac{x + 1}{n + 2}
$$

# 1.2 通过经验风险最小化推导极大似然估计，证明模型是条件概率分布，损失函数是对数损失函数时，经验风险最小化等价于极大似然估计。

## 经验风险最小化中
$$
R_{emp} = \frac{1}{N} \sum_{i=1}^{N}{L(y_i, f(x_i))}
$$
$$
L(y_i, f(x_i)) = -logP(y_i|x_i)
$$

$$
\hat\theta = \arg\min_{\theta}{\frac{1}{N}\sum_{i=1}^{N}{L(y_i, f(x_i))}}
$$
即
$$
\hat\theta = \arg\min_{\theta}{\frac{1}{N}\sum_{i=1}^{N}{-\log{P(y_i|x_i)}}}
$$

## 极大似然估计中
$$
L(y, x) = \prod_{i=1}^{N}{P(y_i|x_i;\theta)}
$$

$$
\hat \theta = \arg\max_\theta \sum_{i = 1} ^ {N} -\log {P(y_i|x_i;\theta)}
$$
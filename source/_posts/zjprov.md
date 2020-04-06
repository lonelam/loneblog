---
    title: 14届浙江省赛部分题解  The 14th Zhejiang Provincial Collegiate Programming Contest
    layout: post
    date: '2017-04-28'
---

-   不知道结果是什么样，但是不挣扎的话，就连RP爆炸摸到牌的机会都没有吧。

<!--more-->
## A.Cooking Competition

### 题意
给你几种操作，让你根据种类给Kobayashi或者Tohru加分，最后让你输出谁的分高。


### 解法
水题直接做就好了，其中3、4两种情况可以直接忽略，因为不产生分差所以对最后结果并没有影响。

### 原题

<div id="content_body">
<hr>
<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB

</center>
<hr>
<p>"Miss Kobayashi's Dragon Maid" is a Japanese manga series written and illustrated by Coolkyoushinja. An anime television series produced by Kyoto Animation aired in Japan between January and April 2017.</p>

<p>In episode 8, two main characters, Kobayashi and Tohru, challenged each other to a cook-off to decide who would make a lunchbox for Kanna's field trip. In order to decide who is the winner, they asked <var>n</var> people to taste their food, and changed their scores according to the feedback given by those people.</p>

<p>There are only four types of feedback. The types of feedback and the changes of score are given in the following table.</p>

<div align="center">
<table border="1" id="sampleTable" style="width: 80%; font-size: 14px; text-align: center" align="center"> <tbody>
<tr><th>Type</th><th>Feedback</th><th>Score Change<br>(Kobayashi)</th><th>Score Change<br>(Tohru)</th></tr>
<tr><td>1</td><td>Kobayashi cooks better</td><td>+1</td><td>0</td></tr>
<tr><td>2</td><td>Tohru cooks better</td><td>0</td><td>+1</td></tr>
<tr><td>3</td><td>Both of them are good at cooking</td><td>+1</td><td>+1</td></tr>
<tr><td>4</td><td>Both of them are bad at cooking</td><td>-1</td><td>-1</td></tr>
</tbody></table>
</div>

<p>Given the types of the feedback of these <var>n</var> people, can you find out the winner of the cooking competition (given that the initial score of Kobayashi and Tohru are both 0)?</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of input contains an integer <var>T</var> (1 ≤ <var>T</var> ≤ 100), indicating the number of test cases. For each test case:</p>

<p>The first line contains an integer <var>n</var> (1 ≤ <var>n</var> ≤ 20), its meaning is shown above.</p>

<p>The next line contains <var>n</var> integers <var>a</var><sub class="lower-index">1</sub>, <var>a</var><sub class="lower-index">2</sub>, ... , <var>a</var><sub class="lower-index"><var>n</var></sub> (1 ≤ <var>a</var><sub class="lower-index"><var>i</var></sub> ≤ 4), indicating the types of the feedback given by these <var>n</var> people.</p>

<h4>Output</h4>

<p>For each test case output one line. If Kobayashi gets a higher score, output "Kobayashi" (without the quotes). If Tohru gets a higher score, output "Tohru" (without the quotes). If Kobayashi's score is equal to that of Tohru's, output "Draw" (without the quotes).</p>

<h4>Sample Input</h4>
<pre>2
3
1 2 1
2
3 4
</pre>

<h4>Sample Output</h4>
<pre>Kobayashi
Draw
</pre>

<h4>Hint</h4>

<p>For the first test case, Kobayashi gets 1 + 0 + 1 = 2 points, while Tohru gets 0 + 1 + 0 = 1 point. So the winner is Kobayashi.</p>

<p>For the second test case, Kobayashi gets 1 - 1 = 0 point, while Tohru gets 1 - 1 = 0 point. So it's a draw.</p>

<hr>
</div>

### 代码
```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000;
int main()
{
    int n;
    int T, typ;
    while(cin >> T)
    {
        while(T--)
        {
            cin >> n;
            int ko = 0, to = 0;
            for (int i = 0; i < n; i++)
            {
                cin >> typ;
                if (typ == 1)
                {
                    ko += 1;
                }
                else if (typ == 2)
                {
                    to += 1;
                }
            }
            if (ko > to)
            {
                cout << "Kobayashi" << endl;
            }
            else if (ko == to)
            {
                cout << "Draw" << endl;
            }
            else{
                cout <<"Tohru" << endl;
            }
        }
    }
}
```


## B.Problem Preparation

### 题意
每个查询都给你一个数列让你判断是否合法，要求n在10-13，然后难度从两个1开始，后面难度差不能超过2，最难的一道只能有一道，且不受难度梯度的限制

### 解法
先排序，然后顺序检查即可。


### 原题
<div id="content_body">

<hr>
<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB
</center>
<hr>
<p>It's time to prepare the problems for the 14th Zhejiang Provincial Collegiate Programming Contest! Almost all members of Zhejiang University programming contest problem setter team brainstorm and code day and night to catch the deadline, and empty bottles of <i>Marjar Cola</i> litter the floor almost everywhere!</p>

<p>To make matters worse, one of the team member fell ill just before the deadline. So you, a brilliant student, are found by the team leader Dai to help the team check the problems' arrangement.</p>

<p>Now you are given the difficulty score of all problems. Dai introduces you the rules of the arrangement:</p>

<ol type="1">
<li> The number of problems should lie between 10 and 13 (both inclusive). </li>
<li> The difficulty scores of the easiest problems (that is to say, the problems with the smallest difficulty scores) should be equal to 1. </li>
<li> At least two problems should have their difficulty scores equal to 1. </li>
<li> After sorting the problems by their difficulty scores in ascending order, the absolute value of the difference of the difficulty scores between two neighboring problems should be no larger than 2. BUT, if one of the two neighboring problems is the hardest problem, there is no limitation about the difference of the difficulty scores between them. The hardest problem is the problem with the largest difficulty score. It's guaranteed that there is exactly one hardest problem. </li>
</ol>

<p>The team members have given you lots of possible arrangements. Please check whether these arrangements obey the rules or not.</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of the input is an integer <var>T</var> (1 ≤ <var>T</var> ≤ 10<sup class="upper-index">4</sup>), indicating the number of test cases. Then <var>T</var> test cases follow.</p>

<p>The first line of each test case contains <font color="red">one integer</font> <var>n</var> (1 ≤ <var>n</var> ≤ 100), indicating the number of problems.</p>

<p>The next line contains <var>n</var> <font color="red">integers</font> <var>s</var><sub class="lower-index">1</sub>, <var>s</var><sub class="lower-index">2</sub>, ... , <var>s</var><sub class="lower-index"><var>n</var></sub> (-1000 ≤ <var>s</var><sub class="lower-index"><var>i</var></sub> ≤ 1000), indicating the difficulty score of each problem.</p>

<p>We kindly remind you that this problem contains large I/O file, so it's recommended to use a faster I/O method. For example, you can use scanf/printf instead of cin/cout in C++.</p>

<h4>Output</h4>

<p>For each test case, output "Yes" (without the quotes) if the arrangement follows the rules, otherwise output "No" (without the quotes).</p>

<h4>Sample Input</h4>
<pre>8
9
1 2 3 4 5 6 7 8 9
10
1 2 3 4 5 6 7 8 9 10
11
999 1 1 2 3 4 5 6 7 8 9
11
999 1 3 5 7 9 11 13 17 19 21
10
15 1 13 17 1 7 9 5 3 11
13
1 1 1 1 1 1 1 1 1 1 1 1 2
10
2 3 4 5 6 7 8 9 10 11
10
15 1 13 3 6 5 4 7 1 14
</pre>

<h4>Sample Output</h4>
<pre>No
No
Yes
No
Yes
Yes
No
No
</pre>

<h4>Hint</h4>

<p>The first arrangement has 9 problems only, which violates the first rule.</p>

<p>Only one problem in the second and the fourth arrangement has a difficulty score of 1, which violates the third rule.</p>

<p>The easiest problem in the seventh arrangement is a problem with a difficulty score of 2, which violates the second rule.</p>

<p>After sorting the problems of the eighth arrangement by their difficulty scores in ascending order, we can get the sequence 1, 1, 3, 4, 5, 6, 7, 13, 14, 15. We can easily discover that |13 - 7| = 6 &gt; 2. As the problem with a difficulty score of 13 is not the hardest problem (the hardest problem in this arrangement is the problem with a difficulty score of 15), it violates the fourth rule.</p>

<hr>
</div>


### 代码
```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000;
int s[maxn];
int main()
{
    int T;
    int n;
    while(scanf("%d", &T)!=EOF)
    {
        while(T--)
        {
            scanf("%d", &n);
            for (int i = 0; i < n; i++)
            {
                scanf("%d", s + i);
            }
            sort(s, s + n);
            bool ok = true;
            if (n < 10 || n > 13) ok = false;
            if (!ok || s[0] != 1 || s[1] != 1) ok = false;
            const int tn = n - 1;
            for (int i = 1; i < tn; i++)
            {
                if (s[i] - s[i - 1] > 2)
                {
                    ok = false;
                }
            }
            if (tn > 0 && s[tn] == s[tn - 1]) ok = false;
            if (ok)
            {
                printf("Yes\n");
            }
            else
            {
                printf("No\n");
            }
        }
    }
}
```

## C.What Kind of Friends Are You?

### 题意
有c种friend的类型，q个询问，n个回答询问的人，询问是一个列表，每个人都回答所有询问，如果这个人的类型在list里边他就会回答yes，否则回答no，让你判断能否判断这个人的friend类型，如果可以那就输出他的friend类型，否则输出Let's go to the library!!

### 解法
一开始脑洞太大了以为这里要考虑排除法的情况，但是实际上这道题还是有点漏洞，还好样例还是比较强，基本只要过了样例应该就没问题了，对所有yes的情况做一个集合交，然后从中间删去被no否定的情况，如果只剩下一个了，那么就可以确定，否则不行。
__除非我读错题意了，否则我觉得这道题应该把可以排除法确定的情况考虑进去。__

另外，我这里用了一个vis数组来处理每个询问之间的关系，这道题据说可以用set强行维护交集。

### 原题
<div id="content_body">

<hr>
<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB

</center>
<hr>
<p>Japari Park is a large zoo home to extant species, endangered species, extinct species, cryptids and some legendary creatures. Due to a mysterious substance known as <i>Sandstar</i>, all the animals have become anthropomorphized into girls known as <i>Friends</i>.</p>

<p>Kaban is a young girl who finds herself in Japari Park with no memory of who she was or where she came from. Shy yet resourceful, she travels through Japari Park along with Serval to find out her identity while encountering more <i>Friends</i> along the way, and eventually discovers that she is a human.</p>

<p>However, Kaban soon finds that it's also important to identify other <i>Friends</i>. Her friend, Serval, enlightens Kaban that she can use some questions whose expected answers are either "yes" or "no" to identitfy a kind of <i>Friends</i>.</p>

<p>To be more specific, there are <var>n</var> <i>Friends</i> need to be identified. Kaban will ask each of them <var>q</var> same questions and collect their answers. For each question, she also gets a full list of animals' names that will give a "yes" answer to that question (and those animals who are not in the list will give a "no" answer to that question), so it's possible to determine the name of a <i>Friends</i> by combining the answers and the lists together.</p>

<p>But the work is too heavy for Kaban. Can you help her to finish it?</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of the input is an integer <var>T</var> (1 ≤ <var>T</var> ≤ 100), indicating the number of test cases. Then <var>T</var> test cases follow.</p>

<p>The first line of each test case contains two integers <var>n</var> (1 ≤ <var>n</var> ≤ 100) and <var>q</var> (1 ≤ <var>q</var> ≤ 21), indicating the number of <i>Friends</i> need to be identified and the number of questions.</p>

<p>The next line contains an integer <var>c</var> (1 ≤ <var>c</var> ≤ 200) followed by <var>c</var> strings <var>p</var><sub>1</sub>, <var>p</var><sub>2</sub>, ... , <var>p</var><sub><var>c</var></sub> (1 ≤ |<var>p</var><sub><var>i</var></sub>| ≤ 20), indicating all known names of <i>Friends</i>.</p>

<p>For the next <var>q</var> lines, the <var>i</var>-th line contains an integer <var>m</var><sub><var>i</var></sub> (0 ≤ <var>m</var><sub><var>i</var></sub> ≤ <var>c</var>) followed by <var>m</var><sub><var>i</var></sub> strings <var>s</var><sub><var>i</var>, 1</sub>, <var>s</var><sub><var>i</var>, 2</sub>, ... , <var>s</var><sub><var>i</var>, <var>m</var><sub><var>i</var></sub></sub> (1 ≤ |<var>s</var><sub><var>i</var>, <var>j</var></sub>| ≤ 20), indicating the number of <i>Friends</i> and their names, who will give a "yes" answer to the <var>i</var>-th question. It's guaranteed that all the names appear in the known names of <i>Friends</i>.</p>

<p>For the following <var>n</var> lines, the <var>i</var>-th line contains <var>q</var> integers <var>a</var><sub><var>i</var>, 1</sub>, <var>a</var><sub><var>i</var>, 2</sub>, ... , <var>a</var><sub><var>i</var>, <var>q</var></sub> (0 ≤ <var>a</var><sub><var>i</var>, <var>j</var></sub> ≤ 1), indicating the answer (0 means "no", and 1 means "yes") to the <var>j</var>-th question given by the <var>i</var>-th <i>Friends</i> need to be identified.</p>

<p>It's guaranteed that all the names in the input consist of only uppercase and lowercase English letters.</p>

<h4>Output</h4>

<p>For each test case output <var>n</var> lines. If Kaban can determine the name of the <var>i</var>-th <i>Friends</i> need to be identified, print the name on the <var>i</var>-th line. Otherwise, print "Let's go to the library!!" (without quotes) on the <var>i</var>-th line instead.</p>

<h4>Sample Input</h4>
<pre>2
3 4
5 Serval Raccoon Fennec Alpaca Moose
4 Serval Raccoon Alpaca Moose
1 Serval
1 Fennec
1 Serval
1 1 0 1
0 0 0 0
1 0 0 0
5 5
11 A B C D E F G H I J K
3 A B K
4 A B D E
5 A B K D E
10 A B K D E F G H I J
4 B D E K
0 0 1 1 1
1 0 1 0 1
1 1 1 1 1
0 0 1 0 1
1 0 1 1 1
</pre>

<h4>Sample Output</h4>
<pre>Serval
Let's go to the library!!
Let's go to the library!!
Let's go to the library!!
Let's go to the library!!
B
Let's go to the library!!
K
</pre>

<h4>Hint</h4>

<p>The explanation for the first sample test case is given as follows:</p>

<p>As Serval is the only known animal who gives a "yes" answer to the 1st, 2nd and 4th question, and gives a "no" answer to the 3rd question, we output "Serval" (without quotes) on the first line.</p>

<p>As no animal is known to give a "no" answer to all the questions, we output "Let's go to the library!!" (without quotes) on the second line.</p>

<p>Both Alpaca and Moose give a "yes" answer to the 1st question, and a "no" answer to the 2nd, 3rd and 4th question. So we can't determine the name of the third <i>Friends</i> need to be identified, and output "Let's go to the library!!" (without quotes) on the third line.</p>
</div>

### 代码

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 200 * 20 + 2;
char p[202][22];
char qs[22][202][22];
int qid[22][202];
int m[22];
int vis[202];
int main()
{
    int T, n, q, c;
    while(scanf("%d", &T)!=EOF)
    {
        while(T--)
        {
            scanf("%d%d%d", &n, &q, &c);
            map<string, int> id;
            for (int i = 0; i < c; i++)
            {
                scanf("%s", p[i]);
                id[string(p[i])] = i;
            }
            for (int i = 0; i < q; i++)
            {
                scanf("%d", m + i);
                for (int j = 0; j < m[i]; j++)
                {
                    scanf("%s", qs[i][j]);
                    qid[i][j] = id[string(qs[i][j])];
                }
            }
            int over;
            for (int i = 0; i < n; i++)
            {
                memset(vis, 0,sizeof(vis));

                int ycnt = 0;
                for (int j = 0; j < q; j++)
                {
                    scanf("%d", &over);
                    if (over)
                    {
                        for (int k = 0; k < m[j]; k++)
                        {
                            ++vis[qid[j][k]];
                        }
                        ycnt++;
                    }
                    else
                    {
                        for (int k = 0; k < m[j]; k++)
                        {

                            vis[qid[j][k]]--;
                        }

                    }
                }
                int standone = -1, standcnt = 0;
                for (int j = 0; j < c; j++)
                {

                    if (ycnt == vis[j])
                    {
                        standone = j;
                        standcnt++;
                    }
                }
                if (standcnt == 1)
                {
                    printf("%s\n", p[standone]);
                }
                else
                {
                    printf("Let's go to the library!!\n");
                }
            }
        }
    }
}
```

## D.Let's Chat

### 题意
A和B连续互发消息m天为就擦出火花，友♂情♂值++，给你每个人给对面发消息的一些区间，求出两人最终的友♂情♂值。

### 解法
由于x, y的范围只有100，至多会搞出来400个区间，那么把这些区间离散化，然后根据数据给的区间，维护这些离散化区间是否被覆盖，最后找出两人互动的时间区间，然后每个分离的区间，对答案的贡献是max{区间长度-m+1,0}

### 原题
<div id="content_body">
<hr>
<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB
</center>
<hr>
<p>ACM (ACMers' Chatting Messenger) is a famous instant messaging software developed by Marjar Technology Company. To attract more users, Edward, the boss of Marjar Company, has recently added a new feature to the software. The new feature can be described as follows:</p>

<p>If two users, A and B, have been sending messages to <b>each other</b> on the last <var>m</var> <b>consecutive days</b>, the "friendship point" between them will be increased by 1 point.</p>

<p>More formally, if user A sent messages to user B on each day between the (<var>i</var> - <var>m</var> + 1)-th day and the <var>i</var>-th day (both inclusive), and user B also sent messages to user A on each day between the (<var>i</var> - <var>m</var> + 1)-th day and the <var>i</var>-th day (also both inclusive), the "friendship point" between A and B will be increased by 1 at the end of the <var>i</var>-th day.</p>

<p>Given the chatting logs of two users A and B during <var>n</var> consecutive days, what's the number of the friendship points between them at the end of the <var>n</var>-th day (given that the initial friendship point between them is 0)?</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of input contains an integer <var>T</var> (1 ≤ <var>T</var> ≤ 10), indicating the number of test cases. For each test case:</p>

<p>The first line contains 4 integers <var>n</var> (1 ≤ <var>n</var> ≤ 10<sup class="upper-index">9</sup>), <var>m</var> (1 ≤ <var>m</var> ≤ <var>n</var>), <var>x</var> and <var>y</var> (1 ≤ <var>x</var>, <var>y</var> ≤ 100). The meanings of <var>n</var> and <var>m</var> are described above, while <var>x</var> indicates the number of chatting logs about the messages sent by A to B, and <var>y</var> indicates the number of chatting logs about the messages sent by B to A.</p>

<p>For the following <var>x</var> lines, the <var>i</var>-th line contains 2 integers <var>l</var><sub class="lower-index"><var>a</var>, <var>i</var></sub> and <var>r</var><sub class="lower-index"><var>a</var>, <var>i</var></sub> (1 ≤ <var>l</var><sub class="lower-index"><var>a</var>, <var>i</var></sub> ≤ <var>r</var><sub class="lower-index"><var>a</var>, <var>i</var></sub> ≤ <var>n</var>), indicating that A sent messages to B on each day between the <var>l</var><sub class="lower-index"><var>a</var>, <var>i</var></sub>-th day and the <var>r</var><sub class="lower-index"><var>a</var>, <var>i</var></sub>-th day (both inclusive).</p>

<p>For the following <var>y</var> lines, the <var>i</var>-th line contains 2 integers <var>l</var><sub class="lower-index"><var>b</var>, <var>i</var></sub> and <var>r</var><sub class="lower-index"><var>b</var>, <var>i</var></sub> (1 ≤ <var>l</var><sub class="lower-index"><var>b</var>, <var>i</var></sub> ≤ <var>r</var><sub class="lower-index"><var>b</var>, <var>i</var></sub> ≤ <var>n</var>), indicating that B sent messages to A on each day between the <var>l</var><sub class="lower-index"><var>b</var>, <var>i</var></sub>-th day and the <var>r</var><sub class="lower-index"><var>b</var>, <var>i</var></sub>-th day (both inclusive).</p>

<p>It is guaranteed that for all 1 ≤ <var>i</var> &lt; <var>x</var>, <var>r</var><sub class="lower-index"><var>a</var>, <var>i</var></sub> + 1 &lt; <var>l</var><sub class="lower-index"><var>a</var>, <var>i</var> + 1</sub> and for all 1 ≤ <var>i</var> &lt; <var>y</var>, <var>r</var><sub class="lower-index"><var>b</var>, <var>i</var></sub> + 1 &lt; <var>l</var><sub class="lower-index"><var>b</var>, <var>i</var> + 1</sub>.</p>

<h4>Output</h4>

<p>For each test case, output one line containing one integer, indicating the number of friendship points between A and B at the end of the <var>n</var>-th day.</p>

<h4>Sample Input</h4>
<pre>2
10 3 3 2
1 3
5 8
10 10
1 8
10 10
5 3 1 1
1 2
4 5
</pre>

<h4>Sample Output</h4>
<pre>3
0
</pre>

<h4>Hint</h4>

<p>For the first test case, user A and user B send messages to each other on the 1st, 2nd, 3rd, 5th, 6th, 7th, 8th and 10th day. As <var>m</var> = 3, the friendship points between them will be increased by 1 at the end of the 3rd, 7th and 8th day. So the answer is 3.</p>

</div>

### 代码
```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 202;
int Aocc[maxn * 2];
int Bocc[maxn * 2];
int disc[maxn * 2];
int A[maxn][2];
int B[maxn][2];
int main()
{
    int T, n, m, x, y;
    while(scanf("%d", &T)!=EOF)
    {
        while(T--)
        {
            scanf("%d%d%d%d",&n, &m, &x, &y);
            int tot = 0;
            for (int i = 0; i < x; i++)
            {
                scanf("%d%d", A[i], A[i] + 1);
                disc[tot++] = A[i][0];
                disc[tot++]= A[i][1] + 1;
            }
            for (int i = 0; i < y; i++)
            {
                scanf("%d%d", B[i], B[i] + 1);
                disc[tot++] = B[i][0];
                disc[tot++] = B[i][1] + 1;
            }
            sort(disc, disc + tot);
            tot = unique(disc, disc + tot) - disc;
            memset(Aocc, 0, sizeof(Aocc));
            memset(Bocc, 0, sizeof(Bocc));
            for (int i = 0; i < x; i++)
            {
                int L = lower_bound(disc, disc + tot, A[i][0]) - disc;
                int R = lower_bound(disc, disc + tot, A[i][1]) - disc;
                while(L < R)
                {
                    Aocc[L++] = 1;
                }
            }
            for (int i = 0; i < y; i++)
            {
                int L = lower_bound(disc, disc + tot, B[i][0]) - disc;
                int R= lower_bound(disc, disc + tot, B[i][1]) - disc;
                while(L < R)
                {
                    Bocc[L++] = 1;
                }
            }
            int l = 0, r = 0, ans = 0;
            for (int i = 0; i < tot; i++)
            {
                if (Aocc[i] && Bocc[i])
                {
                    r = i + 1;
                }
                else
                {
                    //r = i;
                    int len = disc[r] - disc[l];
                    if (len >= m)
                    {
                        ans += len - m + 1;
                    }
                    l = r = i + 1;
                }
            }
            printf("%d\n", ans);
        }
    }
}
```

## E.Seven Segment Display

### 题意
有一个8位的7段液晶数字显示器（总之就是计算器上那种显示方式来表示一个16进制数），每个数位的显示要根据组成它的段的多少每秒付出能量，输入秒数n和初始值，每秒这个数字自增1，如果到了FFFFFFFF下一秒会变00000000，问你n秒后消耗了多少能量。

### 做法
很显然，数字的递增是有规律的，第0位 $16$ s一循环，第1位 $16^2$ s一循环，以此类推，因此就根据这个逐位运算就可以了。把n逐次减去16的幂次就可以顺推出cost了。我的代码里为了减少变数用了先尽可能把低位变0的办法来简化思考的复杂度。由于保证低位全是0，每次第i位自增一个数，要经过 $16^i$ s，在不断减1s的过程当中，高位数位全部不变，低位数位走循环，当前位数字根据n的大小和数位当前字改变一定周期，根据上面这些条件我们可以在常数时间内算出每一位增加到0所花的时间和需要的cost。然后我的做法是先从低位推到高位，然后高位推回低位，这样保证低于当前位的数位全是0，如果不这样做的话需要考虑的因素可能会多一点，虽然队友用直接从高位搞到低位的方法没有AC，但是我觉得应该也是能做的。

### 原题
<div id="content_body">
<hr>
<center>
<font color="green">Time Limit: </font> 1 Second
    &nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB
</center>
<hr>
<p>A seven segment display, or seven segment indicator, is a form of electronic display device for displaying decimal numerals that is an alternative to the more complex dot matrix displays. Seven segment displays are widely used in digital clocks, electronic meters, basic calculators, and other electronic devices that display numerical information.</p><p>Edward, a student in Marjar University, is studying the course "Logic and Computer Design Fundamentals" this semester. He bought an eight-digit seven segment display component to make a hexadecimal counter for his course project.</p><p>In order to display a hexadecimal number, the seven segment display component needs to consume some electrical energy. The total energy cost for display a hexadecimal number on the component is the sum of the energy cost for displaying each digit of the number. Edward found the following table on the Internet, which describes the energy cost for display each kind of digit.</p>

<center>
<table><tbody>
<tr>
<td><table border="1" style="font-size: 14px; text-align: center; margin: 5px;">
<tbody><tr><th>Digit</th><th>Energy Cost<br>(units/s)</th></tr>
<tr><td>0</td><td>6</td></tr>
<tr><td>1</td><td>2</td></tr>
<tr><td>2</td><td>5</td></tr>
<tr><td>3</td><td>5</td></tr>
<tr><td>4</td><td>4</td></tr>
<tr><td>5</td><td>5</td></tr>
<tr><td>6</td><td>6</td></tr>
<tr><td>7</td><td>3</td></tr>
</tbody></table></td>

<td><table border="1" style="font-size: 14px; text-align: center; margin: 5px;">
<tbody><tr><th>Digit</th><th>Energy Cost<br>(units/s)</th></tr>
<tr><td>8</td><td>7</td></tr>
<tr><td>9</td><td>6</td></tr>
<tr><td>A</td><td>6</td></tr>
<tr><td>B</td><td>5</td></tr>
<tr><td>C</td><td>4</td></tr>
<tr><td>D</td><td>5</td></tr>
<tr><td>E</td><td>5</td></tr>
<tr><td>F</td><td>4</td></tr>
</tbody></table></td>

</center>

<p>For example, in order to display the hexadecimal number "5A8BEF67" on the component for one second, 5 + 6 + 7 + 5 + 5 + 4 + 6 + 3 = 41 units of energy will be consumed.</p>

<p>Edward's hexadecimal counter works as follows:</p>

<ul type="disc">
<li> The counter will only work for <var>n</var> seconds. After <var>n</var> seconds the counter will stop displaying. </li>
<li> At the beginning of the 1st second, the counter will begin to display a previously configured eight-digit hexadecimal number <var>m</var>. </li>
<li> At the end of the <var>i</var>-th second (1 ≤ <var>i</var> &lt; <var>n</var>), the number displayed will be increased by 1. If the number displayed will be larger than the hexadecimal number "FFFFFFFF" after increasing, the counter will set the number to 0 and continue displaying. </li>
</ul>

<p>Given <var>n</var> and <var>m</var>, Edward is interested in the total units of energy consumed by the seven segment display component. Can you help him by working out this problem?</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of input contains an integer <var>T</var> (1 ≤ <var>T</var> ≤ 10<sup class="upper-index">5</sup>), indicating the number of test cases. For each test case:</p>

<p>The first and only line contains an integer <var>n</var> (1 ≤ <var>n</var> ≤ 10<sup class="upper-index">9</sup>) and a capitalized eight-digit hexadecimal number <var>m</var> (00000000 ≤ <var>m</var> ≤ FFFFFFFF), their meanings are described above.</p>

<p>We kindly remind you that this problem contains large I/O file, so it's recommended to use a faster I/O method. For example, you can use scanf/printf instead of cin/cout in C++.</p>

<h4>Output</h4>

<p>For each test case output one line, indicating the total units of energy consumed by the eight-digit seven segment display component.</p>

<h4>Sample Input</h4>
<pre>3
5 89ABCDEF
3 FFFFFFFF
7 00000000
</pre>

<h4>Sample Output</h4>
<pre>208
124
327
</pre>

<h4>Hint</h4>

<p>For the first test case, the counter will display 5 hexadecimal numbers (89ABCDEF, 89ABCDF0, 89ABCDF1, 89ABCDF2, 89ABCDF3) in 5 seconds. The total units of energy cost is (7 + 6 + 6 + 5 + 4 + 5 + 5 + 4) + (7 + 6 + 6 + 5 + 4 + 5 + 4 + 6) + (7 + 6 + 6 + 5 + 4 + 5 + 4 + 2) + (7 + 6 + 6 + 5 + 4 + 5 + 4 + 5) + (7 + 6 + 6 + 5 + 4 + 5 + 4 + 5) = 208.</p>

<p>For the second test case, the counter will display 3 hexadecimal numbers (FFFFFFFF, 00000000, 00000001) in 3 seconds. The total units of energy cost is (4 + 4 + 4 + 4 + 4 + 4 + 4 + 4) + (6 + 6 + 6 + 6 + 6 + 6 + 6 + 6) + (6 + 6 + 6 + 6 + 6 + 6 + 6 + 2) = 124.</p>
<hr>
</div>

### 代码
```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000;

char pad[100];
int digit[100];
int cost[] = {6,2,5,5,4,5,6,3,7,6,6,5,4,5,5,4};
int presum[20];
int idx(char x)
{
    if (isdigit(x))
    {
        return x - '0';
    }
    else
    {
        return 10 + x - 'A';
    }
}
int main()
{
    int T;
    ll n;
    presum[0] = cost[0];
    for (int i = 1; i < 16; i++)
    {
        presum[i] = presum[i - 1] + cost[i];
    }
    cout << presum[15];
    while(scanf("%d", &T)!=EOF)
    {
        while(T--)
        {
            scanf("%lld%s", &n, pad);
            ll hmask = 1, upcost = 0, downcost = 0;
            for (int i = 0; i < 8; i++)
            {
                digit[i] = idx(pad[7 - i]);
                upcost += cost[digit[i]];
            }
            int i;
            ll ans = 0;

            for (i = 0; i < 8; i++)
            {
                //if (!digit[i]) continue;
                if (n >= (16 - digit[i]) * hmask)
                {
                    n -= (16 - digit[i]) * hmask;
                    upcost -= cost[digit[i]];
                    ans += downcost * (16 - digit[i]);
                    ans += upcost * (16 - digit[i]) * hmask;
                    if (digit[i]) ans += hmask * (presum[15] - presum[digit[i] - 1]);
                    else ans += hmask * presum[15];
                //    cout <<"debug  "<< ans <<" "<< n << endl;
                    downcost *= 16LL;
                    downcost += hmask * presum[15];
                    digit[i] = 0;
                    for (int j = i + 1; j < 8; j++)
                    {
                        upcost -= cost[digit[j]];
                        if (digit[j] != 15)
                        {

                            digit[j]++;
                            upcost += cost[digit[j]];
                            break;
                        }
                        else
                        {
                            digit[j] = 0;
                            upcost += cost[digit[j]];
                        }
                    }
                    hmask *= 16;
                }
                else
                {
                    upcost -= cost[digit[i]];
                    downcost *= 16LL;
                    downcost += hmask * presum[15];
                    hmask *= 16;
                    break;
                }
            }
            if (i == 8) i--;

            for (; i >= 0; i--)
            {
                hmask /= 16;
                downcost -= hmask * presum[15];
                downcost /= 16;
                int t = n / hmask;
                ans += upcost * t * hmask;
        //        cout <<"ddbug   "<< ans << " "<< n << endl;
                ans += downcost * t;
                if (digit[i]) ans += (presum[digit[i] + t - 1] - presum[digit[i] - 1]) * hmask;
                else if (t) ans += presum[t - 1] * hmask;
                digit[i] += t;
                upcost += cost[digit[i]];
                n %= hmask;
            }
            printf("%lld\n", ans);
        }
    }
}
```


## F.Heap Partition
### 题意
要求把序列S分成尽可能少的子序列，使得这个子序列能够组成一个二叉树，满足 $j为i的父结点时$ $s_j ≤ s_i$ 且 $j < i$ 成立，并且输出这些子序列

### 解法
关键是要想到贪心的方法：对于每一个序列，下标i最小的那个结点一定是作为根出现，因此直接从左到右把第一个未被加入树的点作为根，然后尽可能的把之后的结点加到二叉树里面去，用multiset来维护二叉树的叶子结点的可行性（因为只有大于等于 $s_i$ 的结点可以作为 $i$ 结点的儿子）。

### 代码
```cpp

#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000 + 100;
int a[maxn];
vector<int> icnt[maxn];
multiset<int> seat;
int main()
{
    int T, n;
    while(scanf("%d", &T) !=EOF)
    {
        while(T--)
        {
            scanf("%d", &n);
            set<int> left;
            for (int i = 0; i < n; i++)
            {
                left.insert(i);
                scanf("%d", a + i);
                //nex[i] = (i + 1) % n;
            }
        //    memset(vis, 0, sizeof(vis));
            //int R = 0;

            int cnt = n;
            int id = 0;
            while(cnt)
            {
                id++;
                icnt[id].clear();
                seat.clear();
                int pre = 0;
                set<int> to_d;
                for (int i : left)
                {
                    //if (vis[i]) continue;
                    if (seat.empty())
                    {
                        //vis[i] = id;
                        to_d.insert(i);
                        seat.insert(a[i]);
                        seat.insert(a[i]);
                        --cnt;
                        icnt[id].push_back(i + 1);
                        continue;
                    }
                    multiset<int>::iterator ub = seat.upper_bound(a[i]);
                    if (ub != seat.begin())
                    {
                        to_d.insert(i);
                        --ub;
                        seat.erase(ub);
                        seat.insert(a[i]);
                        seat.insert(a[i]);
                        //vis[i] = id;
                        --cnt;
                        icnt[id].push_back(i + 1);
                    }
                }
                for (int i : to_d)
                {
                    left.erase(i);
                }
            }
            printf("%d\n", id);
            for (int i = 1; i <= id; i++)
            {
                printf("%d", icnt[i].size());
                for (int j : icnt[i])
                    printf(" %d", j);
                printf("\n");
            }

        }
    }
}
/*Sample Input

4
4
1 2 3 4
4
2 4 3 1
4
1 1 1 1
5
3 2 1 4 1
Sample Output

1
4 1 2 3 4
2
3 1 2 3
1 4
1
4 1 2 3 4
3
2 1 4
1 2
2 3 5
*/
```
## G.Yet Another Game of Stones

本题ref: <http://blog.csdn.net/dormousenone/article/details/70599659>

### 题意

Alice 和 Bob玩一个nim游戏的变种，Alice受到的限制比Bob多，最关键要想到Bob必胜的两种情况，也就是把b_i == 2的堆变成只有一个，那么Bob只要不管怎么取都只在最后取b_i == 2那一堆就必胜。所以Alice在这种情况下的唯一策略就是取走全部，取不走就输了，取走的话变成bob先手的nim游戏
有一堆b_i == 1且a_i > 1 的情况下，Alice取这堆不一定能够使nim平衡，那么bob只要构造高位必须选这一堆才能平衡，最低位不能平衡的情况就可以了（想得不严谨）

### 原题

<div id="content_body">

<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB
</center>
<hr>
<p>Alice and Bob are playing yet another game of stones. The rules of this game are as follow:</p>
<ul type="disc">
<li> The game starts with <var>n</var> piles of stones indexed from 1 to <var>n</var>. The <var>i</var>-th pile contains <var>a</var><sub><var>i</var></sub> stones and a special constraint indicated as <var>b</var><sub><var>i</var></sub>. </li>
<li> The players make their moves alternatively. <b>The allowable moves for the two players are different</b>. </li>
<li> An allowable move of Bob is considered as removal of some positive number of stones from a pile. </li>
<li> An allowable move of Alice is also considered as removal of some positive number of stones from a pile, but is limited by the constraint <var>b</var><sub><var>i</var></sub> of that pile.
<ul type="circle">
<li> If <var>b</var><sub><var>i</var></sub> = 0, there are no constraints. </li>
<li> If <var>b</var><sub><var>i</var></sub> = 1, Alice can only remove some odd number of stones from that pile. </li>
<li> If <var>b</var><sub><var>i</var></sub> = 2, Alice can only remove some even number of stones from that pile. </li>
</ul>
Please note that there are no constraints on Bob. </li>
<li> The player who is unable to make an allowable move loses. </li>
</ul>
<p>Alice is always the first to make a move. Do you know who will win the game if they both play optimally?</p>
<h4>Input</h4>
<p>There are multiple test cases. The first line of input contains an integer <var>T</var>, indicating the number of test cases. For each test case:</p>
<p>The first line contains an integer <var>n</var> (1 ≤ <var>n</var> ≤ 10<sup class="upper-index">5</sup>), indicating the number of piles.</p>
<p>The second line contains <var>n</var> integers <var>a</var><sub>1</sub>, <var>a</var><sub>2</sub>, ..., <var>a</var><sub><var>n</var></sub> (1 ≤ <var>a</var><sub><var>i</var></sub> ≤ 10<sup class="upper-index">9</sup>), indicating the number of stones in each pile.</p>
<p>The third line of each test case contains <var>n</var> integers <var>b</var><sub>1</sub>, <var>b</var><sub>2</sub>, ..., <var>b</var><sub><var>n</var></sub> (0 ≤ <var>b</var><sub><var>i</var></sub> ≤ 2), indicating the special constraint of each pile.</p>
<p>It is guaranteed that the sum of <var>n</var> over all test cases does not exceed 10<sup>6</sup>.</p>
<p>We kindly remind you that this problem contains large I/O file, so it's recommended to use a faster I/O method. For example, you can use scanf/printf instead of cin/cout in C++.</p>
<h4>Output</h4>
<p>For each test case, output "Alice" (without the quotes) if Alice will win the game. Otherwise, output "Bob" (without the quotes).</p>
<h4>Sample Input</h4>
<pre>3
2
4 1
1 0
1
3
2
1
1
2
</pre>
<h4>Sample Output</h4>
<pre>Alice
Bob
Bob
</pre>
<h4>Hint</h4>
<p>For the first test case, Alice can remove 3 stones from the first pile, and then she will win the game.</p>

<p>For the second test case, as Alice can only remove some even number of stones, she is unable to remove all the stones in the first move. So Bob can remove all the remaining stones in his move and win the game.</p>

<p>For the third test case, Alice is unable to remove any number of stones at the beginning of the game, so Bob wins.</p>

<hr>
</div>


### 代码

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000 + 10;

int a[maxn], b[maxn];

int main()
{
    int n, T;
    while(scanf("%d", &T) != EOF)
    {
        while(T--)
        {
            scanf("%d", &n);
            for (int i = 0; i < n; i++)
            {
                scanf("%d", a + i);
            }
            int cnt = 0, tar = -1;
            for (int i = 0; i < n;i ++)
            {
                scanf("%d", b + i);
                if (b[i] == 2 || b[i] == 1 && a[i] > 1)
                {
                    tar = i;
                    cnt++;
                }
            }
            int awin = -1;
            int xsum =0;
            if (!cnt)
            {
                for (int i = 0; i < n; i++)
                {
                    xsum ^= a[i];
                }
                if (xsum)
                {
                    awin = 1;
                }
                else
                {
                    awin = 0;
                }
            }
            else if (cnt == 1)
            {
                //cout << tar << " "<< a[tar] << endl;
                if (b[tar] == 1)
                {
                    if (a[tar] & 1)
                    {
                        a[tar] = 0;
                    }
                    else
                    {
                        a[tar] = 1;
                    }
                }
                else
                {
                    if (a[tar] & 1)
                    {
                        awin = 0;
                    }
                    else
                    {
                        a[tar] = 0;
                    }
                }
                for (int i = 0; i < n; i++)
                {
                    xsum ^= a[i];
                }
                if (awin == 0 || xsum)
                {
                    awin = 0;
                }
                else
                {
                    awin = 1;
                }
            }
            else
            {
                awin = 0;
            }
            if (awin)
            {
                printf("Alice\n");
            }
            else
            {
                printf("Bob\n");
            }
        }
    }
}

```
## H. Binary Tree Restoring

### 题意

给你两个dfs序列，不一定先访问哪个儿子，让你还原出符合这两个dfs序列的二叉树

### 解法
ref：<https://www.cnblogs.com/weeping/p/6777603.html>

和上文解法有细微差别，但是基本思想就那样。

首先同一个子树，dfs序的长度是一定的，那么：如果同一对兄弟，ab用了不同的dfs顺序，取a[i], b[i]在另一个dfs序上的下标就可以得出两个子树分别有多大了，那么dfs序里除掉两个子树之外还剩下的部分，大概就是之前ab用了相同dfs序的兄弟的另外一个子树的部分，可是位置怎么取呢？其实可以做下移，也就是说，在没有冲突的情况下尽量往儿子上放，这样如果子树根的左右儿子发生了反转的顺序，确定这个子树的范围，后面的部分只要继续接在父亲结点上就可以啦。

因此我的做法是递归返回被加入二叉树的结点的数量，如果对p的一个儿子，做完一次搜索之后返回的结点数量比区间内有的结点数量少，就说明下一步搜索的时候出现了p的儿子出现了左右儿子反转的情况，而这种情况下又发现左右儿子反转之后还有一些结点既不在左儿子又不在右儿子，那么我们把这部分放到p的另一个儿子上来处理：
若可以处理全部结点，那么就结束，返回结点数量，如果不能处理，即p的另一个儿子也出现左右儿子反转，返回已经处理的结点数量，由上一层来处理这些未被处理的结点。
同时，由于未被处理的结点一定在我们传下去的区间的末尾，因此区间应该是从L+ processed到R

### 原题

<div id="content_body">

<center>
<font color="green">Time Limit: </font> 1 Second
&nbsp;&nbsp;&nbsp;&nbsp;
<font color="green">Memory Limit: </font> 65536 KB

</center>
<hr>
<p>Given two depth-first-search (DFS) sequences of a binary tree, can you find a binary tree which satisfies both of the DFS sequences?</p>

<p>Recall that a binary tree is a tree in which each vertex has at most two children, and the depth-first search is a tree traversing method which starts at the root and explores as far as possible along each branch before backtracking.</p>

<h4>Input</h4>

<p>There are multiple test cases. The first line of input contains an integer <var>T</var>, indicating the number of test cases. For each test case:</p>

<p>The first line contains an integer <var>n</var> (1 ≤ <var>n</var> ≤ 10<sup>5</sup>), indicating the number of vertices in the binary tree.</p>

<p>The second line contains <var>n</var> integers <var>a</var><sub>1</sub>, <var>a</var><sub>2</sub>, ..., <var>a</var><sub><var>n</var></sub> (1 ≤ <var>a</var><sub><var>i</var></sub> ≤ <var>n</var>, ∀ 1 ≤ <var>i</var> &lt; <var>j</var> ≤ <var>n</var>, <var>a</var><sub><var>i</var></sub> ≠ <var>a</var><sub><var>j</var></sub>), indicating the first DFS sequence of the binary tree.</p>

<p>The third line of each test case contains <var>n</var> integers <var>b</var><sub>1</sub>, <var>b</var><sub>2</sub>, ..., <var>b</var><sub><var>n</var></sub> (1 ≤ <var>b</var><sub><var>i</var></sub> ≤ <var>n</var>, ∀ 1 ≤ <var>i</var> &lt; <var>j</var> ≤ <var>n</var>, <var>b</var><sub><var>i</var></sub> ≠ <var>b</var><sub><var>j</var></sub>), indicating the second DFS sequence of the binary tree.</p>

<p>It is guaranteed that the sum of <var>n</var> over all test cases does not exceed 10<sup>6</sup>, and there always exists at least one possible binary tree.</p>

<p>We kindly remind you that this problem contains large I/O file, so it's recommended to use a faster I/O method. For example, you can use scanf/printf instead of cin/cout in C++.</p>

<h4>Output</h4>

<p>For each test case, output one line which contains <var>n</var> integers seperated by one space. The <var>i</var>-th integer indicates the father of the <var>i</var>-th vertex in the binary tree which satisfies both of the DFS sequence. If the <var>i</var>-th vertex is the root of the binary tree, output 0 as its father. If there are multiple valid answers, you can output any of them.</p>

<p>Please, DO NOT print extra spaces at the end of each line, or your program may get a "wrong answer" verdict as this problem is special judged.</p>

<h4>Sample Input</h4>
<pre>2
6
3 4 2 5 1 6
3 4 5 2 1 6
3
1 2 3
1 2 3
</pre>

<h4>Sample Output</h4>
<pre>3 4 0 3 4 1
0 1 2
</pre>
</div>

### 代码

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
const int inf = 0x3f3f3f3f;
const int maxn = 100000 + 100;
int par[maxn];
int seq1[maxn];
int seq2[maxn];
int pos1[maxn];
int pos2[maxn];
int chcnt[maxn];
int gener(int L1, int R1, int L2, int R2, int p)
{
    if (L1 == R1)
    {
        return 0;
    }
    if (L2 == R2)
    {
        cout <<"debug"<< endl;
        return 0;
    }
    if (seq1[L1] == seq2[L2])
    {
        par[seq1[L1]] = p;
        chcnt[p] += 1;
        int ret = 1 + gener(L1 + 1, R1, L2 + 1, R2, seq1[L1]);
        if (p && ret < R1 - L1)
        {
            p = seq1[L1];
            while(p && chcnt[p] == 2) p = par[p];
            ret += gener(L1 + ret, R1, L2 + ret, R2, p);
        }
        return ret;
    }
    else
    {

        //par[seq1[L1]] = par[seq2[L2]] = p;
        //chcnt[p] += 1;
        //cnt1 += 2;
        int ret = gener(L1, pos1[seq2[L2]], pos2[seq1[L1]], pos2[seq1[L1]] + pos1[seq2[L2]] - L1, p);
        ret += gener(pos1[seq2[L2]], pos1[seq2[L2]] + pos2[seq1[L1]] - L2, L2, pos2[seq1[L1]], p);
        return ret;
    }
}
int main()
{
    int T;
    int n;
    while(scanf("%d", &T)!=EOF)
    {
        while(T--)
        {
            scanf("%d", &n);
            memset(chcnt, 0, sizeof(chcnt));
            for (int i = 0; i < n; i++)
            {
                scanf("%d", seq1 + i);
                pos1[seq1[i]] = i;
            }
            for (int i = 0; i < n; i++)
            {
                scanf("%d", seq2 + i);
                pos2[seq2[i]] = i;
            }
            gener(0, n, 0, n, 0);
            for (int i = 1; i < n; i++)
            {
                printf("%d ", par[i]);
            }
            printf("%d\n", par[n]);
        }
    }
}
/*

100
11
1 2 4 8 5 3 6 10 9 11 7
1 2 5 4 8 3 6 10 9 11 7
*/

```

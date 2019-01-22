---
title: "MACM 316 - Computing Report #1"
author: "David Pham / dhpham@sfu.ca / 301318482"
geometry: "margin=1in"
header-includes:
 - \usepackage{graphicx}
---

## (a) Obtain values $ε_{res}(N)$ for several values of $N$. 
I chose values
$$
N = \{~n\times2^4 \mid n \in \mathbb{N}, 1 \leq n \leq 64~\}
\text{ and }
N_{ex} = 1,000
$$
since I started the assignment pretty late. I needed to both compute $ε_{res}(N)$ and finish this assignment within an hour or two.  
\
I decided on multiples of $2^4 = 16$ since they gave me a decent amount of data points to work with, while also growing at a fast enough rate that would work within my time constraints. 

### Accuracy, Robustness, and Efficiency
Of course I'd like to have more accuracy by setting a higher bound for $n$, but Gaussian Elimination grows at $O(N^3)$. Computing a square matrix of size $(64\times2^4)^3 = 1024$ takes $1.07\times10^9$ operations, so if I double the higher bound of $n$, then the number of operations required to solve a 2048x2048 matrix is increased by a factor of $2^3 = 8$, almost a factor of ten. Since $N_{ex} = 1,000$, this factor is multiplied by $1,000$. Solving matrices of size 2048x2048 already takes my computer a few minutes, so this increased cost is unaffordable.  
\
I try to get around the lack of gargantuan-sized matrices in my dataset by increasing the number of smaller-sized matrices, and by taking $N_{ex}=1,000$. I've found that this large value of $N_{ex}$ results in an approximation of the normal distribution by the samples of res_err^{k} for each $k = 1, 2, ..., N_{ex}$.

## (b) Include a plot of the points $(log_{10}N, ε_{res}(N))$.

\begin{center}
    \includegraphics[scale=0.60]{fig1.eps}
\end{center}

## (c) Use your plot from (b) to argue for your value of an estimated value $N^{*}$ where $ε_{res}(N^{∗}) ≈ 0$.
The plot from (b) suggests a linear relationship between $log_{10}N$ and $ε_{res}(N)$. If I take the points $P_{0} = (x_{0},y_{0})$ to be the first point in my dataset and $P_{1} = (x_{1},y_{1})$ to be the last point, then 

\begin{center}
    $P_{0} = (log_{10}(16),~ε_{res}(16))$ and $P_{1} = (log_{10}(1024),~ε_{res}(1024))$.
\end{center}

The line $L$ running through $P_{0}$ and $P_{1}$ has the equation $y = L(x) = mx+b$, and an approximation of the slope $m$ can be determined by 
$$
\begin{aligned}
    m \approx \frac{y_{1}-y_{0}}{x_{1}-x_{0}} \approx 0.4773.
\end{aligned}
$$
Using $m$, we can solve for the y-intercept $b$ by substituting in the values of $P_{0}(x_{0},y_{0})$, such that

$$
\begin{aligned}
    y &= mx+b \\
    &\Rightarrow y_{0} = mx_{0}+b \\
    &\Leftrightarrow ε_{res}(1024) = (0.4773)log_{10}(1024) + b \\
    &\Leftrightarrow b \approx -15.9661.
\end{aligned}
$$

We can now solve for the x-intercept $(x,0)$, which can be interpreted as the value of $log_{10}N^{*}$ that produces a mean residual error $ε_{res}(N^{*})$ equal to the solution, such that no digits of accuracy remain.

$$
\begin{aligned}
    y &= mx+b \\
    \Rightarrow 0 &= (0.4733)x -15.9661 \\
    \Rightarrow x &\approx 33.7336 
\end{aligned}
$$

If we round up our result for $x$, we get $x \approx 34$. Since this is the value of $log_{10}(N^{*})$, this implies that $N^{*}=10^{34}$. We would need a matrix of size $10^{34}\times10^{34}$ before $ε_{res}(N^{*}) \approx 0$, eliminating all accuracy. Clearly, since the number of operations in Gaussian Elimination is bounded by $O(N^3)$, this means that $(10^{34})^{3} \approx 10^{102}$ is the number of operations for solving a matrix of size $N^{*}$. Even if a computer existed that could perform one quintillion operations per second, that is, $10^{18}$ operations/sec, the amount of time required to finish one matrix solve is

$$
\begin{aligned}
    \frac{10^{102} \text{ operations}}{10^{18} \text{ operations/sec}} \cdot \frac{1 \text{ min}}{60 \text{ secs}} \cdot \frac{1 \text{ hr}}{60 \text{ mins}} \cdot \frac{1 \text{ day}}{24 \text{ hrs}} \cdot \frac{1 \text{ year}}{365 \text{ days}} \approx 3\times10^{76} \text{ years.}
\end{aligned}
$$
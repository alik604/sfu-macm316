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
N_{ex} = 10,000
$$
since I started the assignment pretty late. I needed to both compute $ε_{res}(N)$ and finish this assignment within an hour or two.  
\
I decided on multiples of $2^4 = 16$ since they gave me a decent amount of data points to work with, while also growing at a fast enough rate that would work within my time constraints. 

### Accuracy, Robustness, and Efficiency
Of course I'd like to have more accuracy by setting a higher bound for $n$, but Gaussian Elimination grows at $O(n^3)$. Computing a square matrix of size $(64\times2^4)^3 = 1024$ takes $1.07\times10^9$ operations, so if I double the higher bound of $n$, then the number of operations required to solve a 2048x2048 matrix is increased by a factor of $2^3 = 8$, almost a factor of ten. Solving matrices sized 2048x2048 already takes my computer a few minutes when $N_{ex} = 10,000$, so this increased cost is unaffordable.  
\
I try to get around the lack of gargantuan-sized matrices in my dataset by increasing the number of datapoints, and by taking $N_{ex}=10,000$. I've found that this large value of $N_{ex}$ results in normally distributed samples of $ε_{res}(N)$ for each matrix sized $N \times N$.

## (b) Include a plot of the points $(log_{10}N, ε_{res}(N))$.

\begin{center}
    \includegraphics[scale=1.0]{fig1.eps}
\end{center}

## (c) Use your plot from (b) to argue for your value of an estimated value $N^{*}$ where $ε_{res}(N^{∗}) ≈ 0$. You only need to present a rough order of magnitude here, and you should indicate how achievable, or not, your value of N∗ is.
The plot from (b) suggests a linear relationship between $log_{10}N$ and $ε_{res}(N)$. If I take the points $P_{0} = (x_{0},y_{0})$ and $P_{1} = (x_{1},y_{1})$, then
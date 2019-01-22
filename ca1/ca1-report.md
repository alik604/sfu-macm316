---
title: "MACM 316 - Computing Report #1"
author: "David Pham / dhpham@sfu.ca / 301318482"
geometry: "margin=1in"
---

## (a) Obtain values $ε_{res}(N)$ for several values of $N$. 

I chose values
$$
N = \{~n\times2^4 \mid n \in \mathbb{N}, 1 \leq n \leq 64~\}
\text{ and }
N_{ex} = 1000
$$
since I started the assignment pretty late. I needed to both compute $ε_{res}(N)$ and finish this assignment within an hour or two.  
\
I decided on multiples of $2^4 = 16$ since they gave me a decent amount of data points to work with, while also growing at a fast enough rate that would work within my time constraints. 

### Accuracy, Robustness, and Efficiency
Of course I'd like to have more accuracy by setting a higher bound for $n$, but Gaussian Elimination grows at $O(n^3)$. Computing a square matrix of size $(64\times2^4)^3 = 1024$ takes $1.07\times10^9$ operations, so if I double the higher bound of $n$, then the number of operations required to solve a 2048x2048 matrix is increased by a factor of $2^3 = 8$, almost a factor of ten. Solving matrices sized 2048x2048 already takes my computer a few minutes when $N_{ex} = 1000$, so this increased cost is unaffordable. 
\
I try to get around the lack of gargantuan-sized matrices in my dataset by increasing the number of datapoints, and by taking $N_{ex}=1000$. I've found that this large value of $N_{ex}$ results in a normally distributed sample for any matrix sized $N \times N$.


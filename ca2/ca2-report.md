---
geometry: "margin=1in"
header-includes: \usepackage{booktabs}
---

# MACM 316 — Computing Assignment \#2
David Pham / dhpham@sfu.ca / 301318482

## Values of $N$ and $N_{ex}$
I knew that I was eventually going to take $log_{10}(N)$ to explore a potential power-law relationship between matrices of size $N$ and flop counts involved in GE, so I chose to define $N = 10^{k}$, where $k = 1, 2, 3, 4$, to correspond nicely with $log_{10}$ values. I chose not to include $N = 10^{0}$, since this is a trivial $1 \times 1$ matrix, which takes no operations to solve.  

I started by defining $\texttt{dense\_Nex}$, $\texttt{tri\_Nex}$, and $\texttt{perm\_Nex}$ to be the number of solves for each type of matrix $[M_{d}], [M_{t}]$, and $[M_{p}]$, respectively. I fiddled around with each, until the time to solve each type of matrix $\texttt{*\_Nex}$ times was around 1 second.

\begin{center}
\begin{tabular}{ |r|l|l|l|l| }
    \hline
                              &  $N = 10$            &  $N = 100$              &  $N = 1,000$              & $N = 3,163$   \\
    \hline \rule{0pt}{3ex}
    \texttt{dense\_Nex}       &  $3 \times 10^{5}$   &  $3.5 \times 10^{4}$    &  $3.5 \times 10^{4}$      &  \\ [0.1cm]
    \texttt{avg\_dense\_time} &  $4 \times 10^{-6}$  &  $1.68 \times 10^{-4}$  &  $2.2472 \times 10^{-2}$  &  \\ [1ex]
    \hline \rule{0pt}{3ex}
    \texttt{tri\_Nex}         &  $2 \times 10^{6}$   &  $8 \times 10^{5}$      &  $8 \times 10^{5}$        &  \\ [0.1cm]
    \texttt{avg\_tri\_time}   &  $1 \times 10^{-6}$  &  $6 \times 10^{-6}$     &  $4.84 \times 10^{-3}$    &  \\ [1ex]
    \hline \rule{0pt}{3ex}
    \texttt{perm\_Nex}        &  $1.2 \times 10^{6}$ &  $1.2 \times 10^{5}$    &  $1.2 \times 10^{5}$      &  \\ [0.1cm]
    \texttt{avg\_perm\_time}  &  $1 \times 10^{-6}$   &  $3.4 \times 10^{-5}$   &  $4.550 \times 10^{-3}$   &  \\ [1ex]
    \hline
\end{tabular}
\end{center}
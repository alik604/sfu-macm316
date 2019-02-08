---
header-includes: |
    \usepackage{graphicx}
    \usepackage{subcaption}
    \usepackage{caption}
    \usepackage{nicefrac}
geometry: "margin=1in"
---

\newcommand*\textfrac[2]{
  \frac{\text{#1}}{\text{#2}}
}

# MACM 316 — Computing Assignment #3
David Pham // dhpham@sfu.ca // 301318482

## Reproducing the Rough Sketch

\begin{figure}[h]
    \begin{subfigure}[h]{0.5\linewidth}
        \captionsetup{justification=centering,margin=1cm}
        \includegraphics[scale=0.65]{fig1.eps}
        \caption{Traced by BiS $(\Delta s=0.6,~\delta = \displaystyle\frac{3\pi}{4}) \linebreak \texttt{Nsteps}=24$}
    \end{subfigure}
    \begin{subfigure}[h]{0.5\linewidth}
        \captionsetup{justification=centering,margin=1cm}
        \includegraphics[scale=0.65]{fig2smooth.eps}
        \caption{Visually smooth curve traced by BiS $(\Delta s=0.02,~\delta = \displaystyle\frac{3\pi}{4}) \linebreak \texttt{Nsteps}=728$}
    \end{subfigure}
\end{figure}

## How $\delta$ and $\Delta s$ Affect Convergence
Both methods required a $\Delta s = 0.02$ to produce a visually smooth curve. However, the BiS method can work with both large and small values of $\Delta s$, whereas SM requires a relatively small $\Delta s$ value. With regards to $\delta$, the BiS method requires values of $\delta$ where $2\delta$ gets close enough to $2\pi$, such that the interval $[\theta-\delta,\theta+\delta]$ represents something close to a closed circle. If $\delta$ is too small, then the values searched may be too narrow: maybe only a half-circle in the direction of $\theta_{n}$ is searched and no sign change is found, since the root lies on the other half of the circle. This becomes less of an issue if $\Delta s$ becomes smaller alongside $\delta$. For example, $\Delta s = 0.6,~\delta =\nicefrac{\pi}{2}$ makes BiS fail as it rounds the bottom-left bend of the contour, but BiS using $\Delta s = 0.0001,~\delta =\nicefrac{\pi}{2}$ is able to trace the contour.  
\
The opposite is true for SM: values of $\Delta s \ge 0.1$ practically don't converge at all, and smaller values of $\delta$ are better. SM can handle values like $\delta =\nicefrac{\pi}{10^{10}}$, whereas the smallest $\delta$ that BiS can handle is $\frac{\pi}{3}$ for $\Delta s = 0.0001$. For any smaller values of $\delta$, BiS fails no matter how small $\Delta s$ gets. However, for larger $\delta$s, it becomes increasingly difficult for SM to converge.

## Cost
With my implementation of BiS, larger $\delta$ values lead to higher cost. Since the sign of $\theta$ may change multiple times over $[\theta-\delta,\theta+\delta]$, I evaluate $HI$ at each point in \texttt{[$\theta-\delta$:0.1:$\theta+\delta$]}. This, in addition with the $\texttt{avg\_evals = 31}$ it takes for BiS to reach convergence, makes BiS much more costly than SM to run.  
\
For SM, as both $\Delta s$ and $\delta$ get smaller, SM begins to converge faster. At $\Delta s = 0.1,~\delta =\nicefrac{\pi}{2},~\texttt{avg\_evals = 8.34}$. For a smaller $\Delta s = 0.001$ and the same $\delta$ as before, $\texttt{avg\_evals = 5.99}$. With a smaller $\delta =\nicefrac{\pi}{10^{10}}$ and $\Delta s = 0.1,~\texttt{avg\_evals = 5.86}$. With both $\Delta$ and $\delta$ small at $\Delta s = 0.001,~\delta =\nicefrac{\pi}{10^{10}},~\texttt{avg\_evals = 3.98}$. Thus at its fastest, SM is only using two extra function evaluations, aside from the two required evaluations.

Boxed environment
==================
```
\begin{boxed}{Title of the Box}
    This is the text formatted by the boxed environment
\end{boxed}
```

From Sveta:

```
%%%% Notation
\def\diss@notations{Notation}
\newcommand{\setnotations}[1]{\gdef\diss@notations{#1}}

\newenvironment{notations}{\chapter*{\diss@notations}%
                          \begin{itemize}%
                          \setlength{\itemsep}{0ex}
                          \renewcommand{\makelabel}[1]{\makebox[3cm][l]{ ##1}}
                          }%
                         {\thispagestyle{empty}%
                          \end{itemize}}
\newcommand{\notation}[2]{\item[#1]#2}

Example:

\begin{notations}
\notation{$:=$}{equals by definition}
\notation{$\hookrightarrow$}{compact embedding}
\notation{$\equiv$}{logical equivalence}
\notation{$\forall$}{for all}
\notation{$a \cdot b$}{scalar product of vectors}
%
....
\end{notations}
```
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yb}[21/4/2021 0.1.0 Template for my documents]
\LoadClass[12pt]{article}
\RequirePackage{xcolor}
  \definecolor{yb-blue}{RGB}{5,60,94}
\RequirePackage[normalem]{ulem}
\RequirePackage[hidelinks]{hyperref}
  \makeatletter\begingroup
    \catcode`\$=6 %
    \catcode`\#=12 %
    \gdef\href@split$1#$2#$3\\$4{%
      \hyper@@link{$1}{$2}{\uline{$4}}%
      \endgroup
    }%
  \endgroup\makeatother
\RequirePackage{graphicx}
\RequirePackage{svg}
\RequirePackage{microtype}
\RequirePackage{libertine}
\RequirePackage[absolute]{textpos}
  \TPGrid{16}{16}
\RequirePackage[top=2\TPVertModule, bottom=2\TPVertModule, left=3\TPHorizModule, right=2\TPHorizModule]{geometry}
\RequirePackage{tikz}
\RequirePackage{lastpage}
\RequirePackage{everypage}
\AddEverypageHook{%
  \begin{textblock}{2}(0,0){
    \tikz[x=\TPHorizModule,y=\TPVertModule] \filldraw[fill=yb-blue, draw=none] (0,0) rectangle (2,16);
  }\end{textblock}
  \ifnum\value{page}=1
    \begin{textblock}{2}[0,1](0,16){
      \begin{center}
        \includesvg[width=0.5\textwidth]{../images/icon-white.svg}
      \end{center}
    }\end{textblock}
  \else\fi
}
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \fancyfoot[C]{{
    \ifnum\value{page}=1\else
      \color{gray} page \thepage{} of \pageref{LastPage}
    \fi
  }}

\AtBeginDocument{%
  \setlength{\topskip}{0mm}
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{5pt}
  \tolerance=2000
  \raggedbottom
  \large
}

\newcommand\ybPrintPhoto{%
  \begin{textblock}{2.4}[1,0](14,1.5){
    \includegraphics[width=\textwidth]{../images/face-1200x1200.jpg}
  }\end{textblock}
}

\endinput
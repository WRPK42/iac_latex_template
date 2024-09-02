\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iac}[2014/07/24 International Astronautical Congress conference paper LaTeX class]

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsfonts}

\LoadClass[twocolumn,letter paper,10pt]{article}

\RequirePackage[margin=1in,top=1.25in,headheight=\baselineskip]{geometry} % page layout
\RequirePackage{graphicx}
%\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{overcite}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage[explicit,compact]{titlesec}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{alphalph}

\renewcommand{\headrulewidth}{0pt}

\newcounter{authcount}
\newcommand{\IACauthor}[3]{%
	\stepcounter{authcount}%
	\csdef{iac@author\theauthcount}{#1}%
	\csdef{iac@affiliation\theauthcount}{#2}
	\csdef{iac@type\theauthcount}{#3}}% #3 is the author type: "main" or "co"

\setlength\parindent{12pt}
\RequirePackage[]{caption}
\captionsetup[figure]{name=Fig.,format=hang,indention=-20pt}
\captionsetup[table]{format=hang,indention=-24pt}

\titlespacing{\section}{0pt}{*3}{*1.5}
\titlespacing{\subsection}{0pt}{*2.5}{*0.5}
\titlespacing{\subsubsection}{12pt}{*2}{*0.5}
\titleformat{\section}{\centering\normalfont}{\Roman{section}. }{0.5em}{\uline{\textsc{#1}}}
\titleformat{\subsection}{\normalfont}{\Roman{section}.\roman{subsection}}{0.5em}{\uline{#1}}
\titleformat{\subsubsection}{\normalfont}{}{0pt}{\uline{#1}}

\renewcommand{\abstract}[1]{\def\iac@abstract{#1}}
\newcommand*{\IACpaperyear}[1]{\def\iac@paperyear{#1}}\IACpaperyear{}
\newcommand*{\IACpapernumber}[1]{\def\iac@papernumber{#1}}\IACpapernumber{}
\newcommand*{\IACconference}[1]{\def\iac@conference{#1}}\IACconference{}
\newcommand*{\IACcopyright}[1]{\def\iac@copyright{#1}}\IACcopyright{}
\newcommand*{\IAClocation}[1]{\def\iac@location{#1}}\IAClocation{}

\newcommand{\IACcopyrightA}[2]{\def\iac@copyright{Copyright \copyright\,#1 by #2. All rights reserved.}}
\newcommand{\IACcopyrightB}[2]{\def\iac@copyright{Copyright \copyright\,#1 by #2. Published by the International Astronautical Federation with permission.}}
\newcommand{\IACcopyrightC}{\def\iac@copyright{This material is declared a work of the U.S.\ Government and is not subject to copyright protection in the United States.}}
\newcommand{\IACcopyrightD}[1]{\def\iac@copyright{Copyright \copyright\,#1 by the International Astronautical Federation. The U.S.\ Government has a royalty-free license to exercise all rights under the copyright claimed herein for Governmental purposes. All other rights are reserved by the copyright owner.}}
\newcommand{\IACcopyrightDAPL}[1]{\def\iac@copyright{Copyright \copyright\,#1 by the International Astronautical Federation. Under the copyright claimed herein, the U.S.\ Government has a royalty-free license to exercise all rights for Governmental purposes. All other rights are reserved by the copyright owner.}} 
\newcommand\iac@makecopyright{{\iac@copyright}}

\renewcommand\maketitle{\twocolumn[
  \begin{@twocolumnfalse}
  \lhead{}\chead{\footnotesize \iac@conference th International Astronautical Congress, {\iac@location}. \iac@makecopyright}\rhead{}%
  \lfoot{IAC--\iac@paperyear--\iac@papernumber}\cfoot{}\rfoot{Page \thepage\ of \pageref{LastPage}}%
  \begingroup
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \@thanks
  \endgroup
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\date\relax
  \global\let\and\relax
  \end{@twocolumnfalse}
  ]}
\def\@maketitle{%
  \begin{center}%
    IAC--\iac@paperyear--\iac@papernumber\par%
    \vskip1em
    {\large \textsc{\@title} \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      % Ensure authnum is defined and initialize it
      \newcounter{authnum}%
      \setcounter{authnum}{0}%
      % Define affnum counter for affiliations
      \newcounter{affnum}%
      \setcounter{affnum}{0}%
      
      % Command to generate superscript letters (a, b, c, ...)
      \newcommand{\affmark}{\stepcounter{affnum}\textsuperscript{\alph{affnum}}} 
      
      % Define corresponding author superscript
      \newcommand{\correspondingmark}{\textsuperscript{*}}

      % Display all authors in a single line with superscripts
      \normalsize
      \whileboolexpr
      { test {\ifnumcomp{\value{authnum}}{<}{\theauthcount}} }%
      {\stepcounter{authnum}%
        \textbf{\csuse{iac@author\theauthnum}}%
        \affmark% Add alphabetic superscript
        \ifcsstring{iac@type\theauthnum}{main}{\correspondingmark}{}% Add * if author is main
        \ifnumcomp{\value{authnum}}{<}{\theauthcount}{, }{}%
      }%
      \par%
    }%
  \end{center}%
  \vskip 1em%
  % List affiliations as a left-aligned paragraph in italics with no hyphenation
  \noindent
  \setcounter{affnum}{0}%
  \raggedright% Prevent hyphenation and align left
  \hyphenpenalty=10000 % Disable hyphenation
  \exhyphenpenalty=10000 % Disable explicit hyphenation
  \normalsize
  \whileboolexpr
  { test {\ifnumcomp{\value{affnum}}{<}{\theauthcount}} }%
  {\stepcounter{affnum}%
    \textsuperscript{\alph{affnum}} \textit{\csuse{iac@affiliation\theaffnum}}\par%
  }%
  % Add footnote for corresponding author(s)
  \vskip 1em%
  \noindent\textsuperscript{*} \textit{Corresponding author(s).}\par%
  \vskip 1.5em%
  % Centered and bold "Abstract" title
  \begin{center}
    \textbf{Abstract}
  \end{center}
  \indent\iac@abstract\par%
  \vskip 1em%
  \indent\iac@keywords\par%
  \vskip 4.5ex}%
  \pagestyle{fancy}%
  
\makeatletter
\newcommand*{\fnsymbolsingle}[1]{%
  \ensuremath{%
    \ifcase#1%
    \or *%
    \or \dagger
    \or \ddagger
    \or \mathsection
    \or \mathparagraph
    \else
      \@ctrerr
    \fi
  }%
}
\makeatother
\newalphalph{\fnsymbolmult}[mult]{\fnsymbolsingle}{}
\renewcommand*{\thefootnote}{%
  \fnsymbolmult{\value{footnote}}%
}
\makeatletter
	\def\tagform@#1{\maketag@@@{[#1]\@@italiccorr}}
\makeatother
\endinput

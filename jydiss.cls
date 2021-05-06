% Written by Antti-Juhani Kaijanaho on November 2004
% Subsequently modified by Alexander Sayenko and Matthieu Weber.
% You may treat this file as if it were in the public domain.

% You can access the most recent version at
%  https://yousource.it.jyu.fi/latex-thesis-classes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     PLEASE READ THE MANUAL!                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\filedate{2015/01/08}
\def\fileversion{1.17}
\def\fileinfo{JY Dissertations}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jydiss}[\filedate\space\fileversion\space\fileinfo]
\typeout{jydiss <\filedate:\fileversion> - University of Jyvaskyla Dissertations}

%% Some packages need special handling if the output is PDF, this \if is just
%% in case we need it
\newif\ifjydiss@pdf
\ifx\pdfoutput\undefined
  \jydiss@pdffalse
\else
  \ifnum\pdfoutput=1
    \jydiss@pdftrue
  \else
    \jydiss@pdffalse
  \fi
\fi

%% fix handling of empty pages
\let\jydiss@origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\jydiss@origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage

%% Input encoding
\def\diss@useutf{}
\def\diss@inputenc{latin1}
\DeclareOption{ansinew}{\gdef\diss@inputenc{ansinew}}
\DeclareOption{applemac}{\gdef\diss@inputenc{applemac}}
\DeclareOption{ascii}{\gdef\diss@inputenc{ascii}}
\DeclareOption{cp1250}{\gdef\diss@inputenc{cp1250}}
\DeclareOption{cp1252}{\gdef\diss@inputenc{cp1252}}
\DeclareOption{cp437}{\gdef\diss@inputenc{cp437}}
\DeclareOption{cp437de}{\gdef\diss@inputenc{cp437de}}
\DeclareOption{cp850}{\gdef\diss@inputenc{cp850}}
\DeclareOption{cp852}{\gdef\diss@inputenc{cp852}}
\DeclareOption{cp865}{\gdef\diss@inputenc{cp865}}
\DeclareOption{decmulti}{\gdef\diss@inputenc{decmulti}}
\DeclareOption{latin1}{\gdef\diss@inputenc{latin1}}
\DeclareOption{latin2}{\gdef\diss@inputenc{latin2}}
\DeclareOption{latin3}{\gdef\diss@inputenc{latin3}}
\DeclareOption{latin5}{\gdef\diss@inputenc{latin5}}
\DeclareOption{latin9}{\gdef\diss@inputenc{latin9}}
\DeclareOption{utf8x}{\gdef\diss@useutf{\RequirePackage{ucs}}\gdef\diss@inputenc{utf8x}}
\DeclareOption{utf8}{\gdef\diss@inputenc{utf8}}
\DeclareOption{next}{\gdef\diss@inputenc{next}}

\newif\ifdiss@chapter@allowed
\diss@chapter@allowedtrue

\newif\ifdiss@fi
\diss@fifalse

\DeclareOption{finnish}{\diss@fitrue}
\DeclareOption{english}{\diss@fifalse}

% tocloft needs to know if subfigure is used, so we make it a class
% option
\newif\ifdiss@subfigure
\diss@subfigurefalse

\newif\ifdiss@licentiate
\diss@licentiatefalse

\newif\ifdiss@lof
\diss@loffalse

\newif\ifdiss@lot
\diss@lotfalse

\newif\ifdiss@loar
\diss@loarfalse

\newif\ifdiss@loa
\diss@loafalse

\newif\ifdiss@shortloft
\diss@shortloftfalse

\DeclareOption{subfigure}{\diss@subfiguretrue}
\DeclareOption{licentiate}{\diss@licentiatetrue}
\DeclareOption{lof}{\diss@loftrue}
\DeclareOption{lot}{\diss@lottrue}
\DeclareOption{loa}{\diss@loatrue}
\DeclareOption{loar}{\diss@loartrue}
\DeclareOption{shortloft}{\diss@shortlofttrue}

%\newif\ifdiss@captiondot
%\diss@captiondotfalse
%\DeclareOption{captiondot}{\diss@captiondottrue}

\newif\ifdiss@altlongcaption
\diss@altlongcaptionfalse
\DeclareOption{altlongcaption}{\diss@altlongcaptiontrue}

\newif\ifdiss@index
\diss@indexfalse
\DeclareOption{index}{\diss@indextrue}

\newif\ifdiss@hyperref
\diss@hyperreffalse
\DeclareOption{hyperref}{\ClassError{jydiss}{The option ``hyperref'' is
deprecated}{jydiss does not load the hyperref package automatically anymore.
You must load it in the preamble of your document with
\string\usepackage{hyperref} if you need it.}}
  
\newif\ifdiss@natbib
\diss@natbibfalse

\newif\ifdiss@alttt
\diss@altttfalse
\DeclareOption{alttt}{\diss@alttttrue}

\newif\ifdiss@contrib@in@loar
\diss@contrib@in@loarfalse
\DeclareOption{contribinloar}{\diss@contrib@in@loartrue}

\newif\ifdiss@contrib@before
\diss@contrib@beforefalse
\DeclareOption{contribbefore}{\diss@contrib@beforetrue}

\newif\ifdiss@bold@art@ref
\diss@bold@art@reffalse
\DeclareOption{boldartref}{\diss@bold@art@reftrue}

\newif\ifdiss@listings
\diss@listingsfalse
\DeclareOption{listings}{\diss@listingstrue}

\def\jydiss@bib@startlanguage#1{\begingroup\selectlanguage{#1}}
\def\jydiss@bib@endlanguage{\endgroup}
\DeclareOption{bibweaklang}{%
  \gdef\jydiss@bib@startlanguage#1{\begin{hyphenrules}{#1}}
  \gdef\jydiss@bib@endlanguage{\end{hyphenrules}}
}

% Deprecated, kept for compatibility
\newif\ifdiss@stupid
\diss@stupidfalse
\DeclareOption{stupid}{\diss@stupidtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper,12pt]{book}

\ifdiss@fi%
\ifdiss@licentiate\relax\else\diss@fifalse%
\typeout{Doctoral theses cannot be written in Finnish, ignoring "finnish"
option}%
\fi%
\fi%

%%%% Index (This must appear before Babel)
\ifdiss@index
\RequirePackage{makeidx}

\let\gradu@oldtheindex\theindex
\def\theindex{%
  \gradu@oldtheindex%
  \typeout{\indexname.}%
  \addcontentsline{toc}{schapter}{\HyMakeUppercase{\indexname}}%
}
\else
  \newcommand\printindex{}
\fi

\RequirePackage{calc}
\newcounter{jydiss@lastdigit}

%%%% Babel

\RequirePackage[finnish,english]{babel}
\ifdiss@fi
\def\selectdefaultlanguage{\selectlanguage{finnish}}
\else
\def\selectdefaultlanguage{\selectlanguage{english}}
\fi

% These terms are not defined in the english babel
\addto\captionsfinnish{% Adding these to babel's finnish
\def\bibname{L\"ahteet}%
\def\acknowledgementsname{Kiitokset}%
\def\termlistname{Sanasto}%
\def\appendicesname{Liitteet}%
\def\includedarticlesname{Sis\"allytetyt artikkelit}%
\def\listarticlename{Artikkelit}%
\def\loftname{Kuviot ja taulukot}%
\def\listfigurename{Kuviot}% Babel's default value is "Kuvat"
\def\listalgorithmname{Algoritmit}% No default in Babel
% for jydiss.bst
\def\jydiss@bib@ed{toim.}%
\def\jydiss@bib@eds{toim.}%
\def\jydiss@bib@vol{osa}%
\def\jydiss@bib@In{Teoksessa}%
\def\jydissbibpp{ss.}%
\def\jydiss@bib@mastersthesis{Pro gradu -ty\"o}%
\def\jydiss@bib@phdthesis{V\"ait\"oskirja}%
\def\jydiss@bib@accessed#1#2#3{Viitattu #3.#2.#1}%
\def\jydiss@bib@edition#1{%
  #1%
  \ifnum9<1#1%
  .%
  \fi%
  ~painos%
}%
}
\addto\captionsenglish{%
\def\bibname{References}%
\def\acknowledgementsname{Acknowledgements}%
\def\termlistname{Glossary}%
\def\appendicesname{Appendices}%
\def\includedarticlesname{Included Articles}%
\def\listarticlename{List of Included Articles}%
\def\loftname{List of Figures and Tables}%
\def\finnishsummaryheading{Yhteenveto (Finnish Summary)}%
\def\finnishsummaryabstract{\\Finnish summary}%
% for jydiss.bst
\def\jydiss@bib@ed{Ed.}%
\def\jydiss@bib@eds{Eds.}%
\def\jydiss@bib@vol{Vol.}%
\def\jydiss@bib@mastersthesis{Master's Thesis}%
\def\jydiss@bib@phdthesis{Ph.~D.~Thesis}%
\def\jydiss@bib@In{In}%
\def\jydissbibpp{pp.}%
\def\jydiss@bib@accessed#1#2#3{Accessed on #1--#2--#3}%
\def\jydiss@bib@edition#1{%
  #1%
  \ifnum9<1#1%
  \setcounter{jydiss@lastdigit}{#1 - #1 / 10 * 10}%
  \ifcase\thejydiss@lastdigit th\or st\or nd\or rd\else th\fi%
  \fi~%
  edition%
}%
}

\diss@useutf
\RequirePackage[\diss@inputenc]{inputenc}
\RequirePackage{textcomp}
\RequirePackage[T1]{fontenc}
%\RequirePackage{palatino}
% palatino.sty is deprecated, the following 3 lines replace it
\RequirePackage{mathpazo}
\RequirePackage[scaled=.95]{helvet}
\ifdiss@alttt
\renewcommand*\ttdefault{txtt}
\else
\RequirePackage{courier}
\fi
\linespread{1.05}
\newcommand{\cftdotsep}{0.5}
\ifdiss@subfigure
\RequirePackage[subfigure]{tocloft}
\else
\RequirePackage{tocloft}
\fi
\RequirePackage{everyshi}
\RequirePackage{url}
\urlstyle{rm}

\RequirePackage[left=3cm,right=3cm,top=3cm,bottom=2.5cm,headsep=0.5cm,headheight=0.5cm]{geometry}
\RequirePackage{remreset}
\RequirePackage[hang]{footmisc}
\setlength{\footnotemargin}{1cm}

%%%% Captions

%\long\def\@caption#1[#2]#3{%
%  \par
%  \addcontentsline{\csname ext@#1\endcsname}{#1}%
%    {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
%  \begingroup
%    \@parboxrestore
%    \if@minipage
%      \@setminipage
%    \fi
%    \normalsize
%    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3\ifdiss@captiondot .\fi}\par
%  \endgroup}

\RequirePackage[font=small,labelsep=quad,format=hang, singlelinecheck=false]{caption}
\DeclareCaptionLabelFormat{uppercase}{\bothIfFirst{\MakeUppercase{#1}}{\nobreakspace}#2}
\captionsetup{labelformat=uppercase}
\ifdiss@altlongcaption
\captionsetup{format=default}
\fi

%%%% listings.sty configuration
\ifdiss@listings
\RequirePackage{listings}
\lstset{captionpos=b,floatplacement=t}
\@removefromreset{lstlisting}{chapter}
\renewcommand{\thelstlisting}{\@arabic\c@lstlisting}
\ifdiss@fi\def\lstlistingname{Listaus}\fi
\fi



%%%% Sectioning

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%% jydiss@toc@space controls the insertion of vertical space in the TOC between a \chapter
%% entry followed by a \chapter*
\newif\ifjydiss@toc@space
\jydiss@toc@spacefalse

%% A MakeUppercase replacement compatible with Hyperref-PDF bookmarks
\newif\ifdiss@pdfmark % For hyperref with dvips/pdfmark driver
\diss@pdfmarkfalse

\newcommand\HyMakeUppercase[1]{%
  \ifdiss@hyperref
    \ifjydiss@pdf
      \texorpdfstring{\MakeUppercase{#1}}{#1}%
    \else
      \ifdiss@pdfmark
        \texorpdfstring{\MakeUppercase{#1}}{#1}%
      \else
        \MakeUppercase{#1}%
      \fi
    \fi
  \else
    \MakeUppercase{#1}%
  \fi
}

\newcounter{schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}{\HyMakeUppercase{#1}}}%
                       \else
                         \addcontentsline{toc}{chapter}{\HyMakeUppercase{#1}}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{\HyMakeUppercase{#1}}%
                    \fi
                    \chaptermark{#1}%
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\def\@schapter[#1]#2{\refstepcounter{schapter}%
										 \if@mainmatter
                       \addcontentsline{toc}{chapter}%
                                   {\HyMakeUppercase{#1}}%
										 \else
											 \if#1\relax
											 \else
											   \ifjydiss@toc@space
                           \addtocontents{toc}{\vskip\cftbeforechapskip}
                           \global\jydiss@toc@spacefalse
                         \fi%
                         \addcontentsline{toc}{schapter}%
                                     {\HyMakeUppercase{#1}}%
												 %\addtocontents{toc}{\MakeUppercase{#1}\par}
											 \fi%
										 \fi
                     \if@twocolumn
                       \@topnewpage[\@makeschapterhead{#2}]%
                     \else
                       \@makeschapterhead{#2}%
                       \@afterheading
                     \fi}

\newcommand\tailmatter{%
  \@tailmattertrue
}

\renewcommand\appendix{\clearpage%
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@appendix\@appendix}
\AtBeginDocument{
  %%%% List of algorithms
  \ifdiss@loa
    \let\c@algorithm=\relax % already defined by algorithm.sty
    \newlistof{algorithm}{loa}{\listalgorithmname}
    \ifdiss@shortloft
      \renewcommand{\@cftmakeloatitle}{\almostchapter*[]{\listalgorithmname}}
    \else
      \renewcommand{\@cftmakeloatitle}{\chapter*{\listalgorithmname}}
    \fi
    \setlength{\cftalgorithmnumwidth}{8em}
    \renewcommand{\cftalgorithmpresnum}{\MakeUppercase{\ALG@name}\space}
    \renewcommand{\cftalgorithmindent}{0em}
  \fi
}

%% This requires extensive explanation.
%%
%% Hyperref expects \@schapter to have only one parameter, but jydiss defines
%% \@schapter to have 2 parameters. Therefore, after hyperref has been loaded,
%% jydiss must overwrite the defninition of \@schapter made by hyperref.
%%   But hyperref  must be loaded by the user, not by jydiss, because hyperref
%% overwrites definitions made in many packages. The user may use such
%% packages, therefore hyperref must be loaded *after* these packages. In
%% addition, hyperref must be loaded before packages based on the float package,
%% because the latter is incompatible with hyperref.
%% jydiss therefore expects the user to potentially load hyperref, and if it is
%% the case, it redefines its \@schapter just before \begin{document}.  This
%% could not be done with \AtBeginDocument, because hyperref also uses
%% \AtBeginDocument extensively, and jydiss' \AtBeginDocument{\def\@schapter...}
%% would have been executed *before* hyperref's redefinition of \@schapter
%% (\begin{document} hooks are executed in the same order they are defined, and
%% jydiss would define its hook before hyperref defines its ones).
%% Defining a hook in a hook i.e., \AtBeginDocument{\AtBeginDocument{\def\whatever}}
%% does not work, jydiss therefore needs to define its own hook, independently
%% from the normal \begin{document} hooks. The proper way of doing so would be to
%% redefine \document, but for some obscure reason, this does not work. The
%% working solution consists in redefining \begin and check if it is
%% \begin{document} (and then execute jydiss' own hook before actually executing
%% \begin{document}) or \begin{sometingelse} (then do nothing special).
%%   jydiss' own hook is one \AtBeginDocument that puts its own commands after
%% every others (redefining \@schapter, then calling \maketitle).

%%%% Begin dirty hack
\def\diss@before@begin@document{
\AtBeginDocument{
  \@ifpackageloaded{hyperref}{
  \diss@hyperreftrue
  \def\@schapter[##1]##2{%
    \def\@currentlabelname{##1}%
    \H@old@schapter[##1]{##2}
    \begingroup
      \let\@mkboth\@gobbletwo
      \Hy@GlobalStepCount\Hy@linkcounter
      \xdef\@currentHref{\Hy@chapapp*.\the\Hy@linkcounter}%
      \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
    \endgroup
  }%
  \def\toclevel@schapter{0}%
  \def\toclevel@appendix{0}%
  \def\toclevel@algorithm{0}%

  \define@Hy@TotPages@putlabel
  \@ifl@aded{def}{pdfmark}{\diss@pdfmarktrue}{\diss@pdfmarkfalse}
  }{%
  \diss@hyperreffalse
  \define@TotPages@putlabel
  }%

  \@ifpackageloaded{natbib}{\diss@natbibtrue}{\diss@natbibfalse}
  \let\@cite@rig=\@cite
  \let\@citex@rig=\@citex
  \ifdiss@natbib
    \def\@cite##1##2##3{\ifdiss@artcite{\ifdiss@bold@art@ref\bfseries \fi##1}\endgroup\else\@cite@rig{##1}{##2}{##3}\fi\diss@artcitefalse}
    \def\@citex[##1][##2]##3{\@ifundefined{diss@artcite@##3}{\diss@artcitefalse\@citex@rig[##1][##2]{##3}}{\diss@artcitetrue\@citex@rig[##1][##2]{##3}}}%
    \def\@lbibitem[##1]##2{%
      \if\relax\@extra@b@citeb\relax\else
        \@ifundefined{br@##2\@extra@b@citeb}{}{%
         \@namedef{br@##2}{\@nameuse{br@##2\@extra@b@citeb}}}\fi
       \@ifundefined{b@##2\@extra@b@citeb}{\def\NAT@num{}}{\NAT@parse{##2}}%
       \@ifundefined{diss@artcite@##2}{%
         \item[\hfil\hyper@natanchorstart{##2\@extra@b@citeb}\@biblabel{\NAT@num}%
           \hyper@natanchorend]%
       }{%
         \@ifundefined{NAT@name}{%
           \item[?]%
         }{%
           \item[\hfil\hyper@natanchorstart{##2\@extra@b@citeb}\@biblabel{\NAT@name}%
             \hyper@natanchorend]}%
       }
        \NAT@ifcmd##1(@)(@)\@nil{##2}}
  \else
    \ifdiss@bold@art@ref
      \def\@cite##1##2{\ifdiss@artcite\textbf{##1}\else\@cite@rig{##1}{##2}\fi\diss@artcitefalse}
      \def\@citex[##1]##2{\@ifundefined{diss@artcite@##2}{\diss@artcitefalse\@citex@rig[##1]{##2}}{\diss@artcitetrue\@citex@rig[##1]{##2}}}%
    \fi
  \fi
  \@mainmatterfalse
  \pagestyle{empty}
  \selectdefaultlanguage
  \maketitle
}}

\RequirePackage{ifthen}
\let\diss@begin=\begin
\renewcommand*{\begin}[1]{%
\ifthenelse{\equal{#1}{document}}{%
\diss@before@begin@document
}{}%
\diss@begin{#1}%
}
%%%% End dirty hack

\newcommand\almostchapter{\vskip3em
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdefalt\@chapter\@schapter}
\renewcommand\chapter{\clearpage
                    \ifdiss@chapter@allowed\else
                    \ClassError{jydiss}{\noexpand\chapter is not
                    allowed here}{\noexpand\chapter cannot be used after
                    \noexpand\backmatter or \noexpand\appendices}\fi
                    \if@tailmatter\else
                    \thispagestyle{empty}%
                    \global\@topnum\z@\fi
                    \@afterindentfalse
                    \secdefalt\@chapter\@schapter}

\newcommand\openanychapter{\clearpage
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdefalt\@chapter\@schapter}


\newcounter{TotPages}
\newif\ifTotPages@todo\TotPages@todotrue
\EveryShipout{\stepcounter{TotPages}}
%% The definition of \TotPages@putlabel must be delayed, since hyperref is not
%% yet loaded at this point, all the \ifHy@xxx are undefined but latex
%% still complains about the corresponding \fi
\def\define@Hy@TotPages@putlabel{
\def\TotPages@putlabel{%
  \addtocounter{page}{-1}%
  \if@filesw
    \begingroup
      \ifHy@pageanchor
        \ifHy@hypertexnames
          \ifHy@plainpages
             \def\Hy@temp{\arabic{page}}%
          \else
             \let\textlatin\@firstofone
             \edef\Hy@temp{\thepage}%
          \fi
        \else
          \def\Hy@temp{\the\Hy@pagecounter}%
        \fi
      \fi
      \immediate\write\@mainaux{%
          \string\newlabel{TotPages}{{\theTotPages}{\thepage}{}{%
          \ifHy@pageanchor page.\Hy@temp\fi
        }{}}%
      }%
			\global\TotPages@todofalse
    \endgroup
  \fi
  \addtocounter{page}{1}%
}}
\def\define@TotPages@putlabel{
\def\TotPages@putlabel{%
  \addtocounter{page}{-1}%
  \if@filesw
    \begingroup
      \immediate\write\@mainaux{%
          \string\newlabel{TotPages}{{\theTotPages}{\thepage}}%
      }%
			\global\TotPages@todofalse
    \endgroup
  \fi
  \addtocounter{page}{1}%
}}%

\AtEndDocument{%
%\addtocontents{loar}{\protect\end{thelistofarticles}}
\immediate\write\@auxout{\string\@writefile{loar}{\string\end{thelistofarticles}}}
\ifTotPages@todo\clearpage\TotPages@putlabel\fi
}

\renewcommand{\author}{\ClassError{jydiss}{\noexpand\author is disabled, use \noexpand\setauthor instead!}{}}

\let\diss@subtitle\relax
\def\diss@inclsummary{\\Your document is in English, it requires a Finnish
summary!}
\def\diss@isbnmissing{\\ISBN \textbf{??}}
\def\diss@isbn{\diss@isbnmissing}
\ifdiss@licentiate
\def\diss@series{Jyv\"askyl\"a Licentiate Theses in Computing}
\ifdiss@fi
\def\diss@type{Lisensiaatintutkielman k\"asikirjoitusluonnos}
\def\diss@inclsummary{}
\else
\def\diss@type{Licentiate's thesis draft manuscript}
\fi
\def\diss@issn{1795-9713}
\def\diss@number{\textbf{??}}
\def\diss@diss{}
\else
\def\diss@series{Jyv\"askyl\"a Studies in Computing}
\def\diss@type{Dissertation draft manuscript}
\def\diss@issn{1456-5390}
\def\diss@number{\textbf{??}}
\def\diss@diss{\\Diss.}
\fi
\def\diss@address{Jyv\"askyl\"a}
\def\diss@publisher{University of Jyv\"askyl\"a}
\def\diss@abstract{Lorem ipsum}
\def\diss@keywords{None, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none}
\def\diss@people{\item }
\newcommand{\setauthor}[2]{\gdef\diss@surname{#2}\gdef\diss@forename{#1}}
\renewcommand{\title}[1]{\gdef\diss@title{#1}}
\newcommand{\subtitle}[1]{\gdef\diss@subtitle{#1}}
\newcommand{\entitle}[1]{\gdef\diss@entitle{#1}}
\newcommand{\disstype}[1]{\gdef\diss@type{#1}}
\newcommand{\abstract}[1]{\gdef\diss@abstract{\ignorespaces #1}}
\newcommand{\people}[1]{\gdef\diss@people{#1}}
\newcommand{\keywords}[1]{\gdef\diss@keywords{#1}}
\newcommand{\epigraph}[1]{\long\gdef\diss@epigraph{#1}}
\newcommand{\series}[1]{\gdef\diss@series{#1}}
\newcommand{\issn}[1]{\gdef\diss@issn{#1}}
\newcommand{\isbn}[2][]{%
  \global\let\diss@isbnmissing\relax%
  \expandafter\gdef\expandafter\diss@isbn\expandafter{%
    \diss@isbn\\%
    ISBN~#2\ifthenelse{\equal{#1}{}}{}{~(#1)}
  }%
}
\newcommand{\serialnumber}[1]{\gdef\diss@number{#1}}
\newcommand{\email}[1]{
  \ifdiss@hyperref
    \href{mailto:#1}{\texttt{#1}}%
  \else
    \texttt{#1}%
  \fi
}

\pagenumbering{roman}
\newsavebox{\diss@kw}
\savebox{\diss@kw}{\normalfont\normalsize Keywords:~}
\newlength{\diss@kwlen}
\settowidth{\diss@kwlen}{\usebox{\diss@kw}}
\renewcommand{\maketitle}{%
  \ifdiss@hyperref\ifjydiss@pdf
    \hypersetup{
      pdftitle={\diss@title},
      pdfauthor={\diss@forename\ \diss@surname},
      pdfkeywords={\diss@keywords}
     }
  \fi\fi
  %\begin{titlepage}%
  %  \mbox{}\vfill%
  %  \centering%
  %  \textbf{\LARGE\ }\par%
  %  \vspace{1cm}%
  %  \textbf{\LARGE\diss@title}\par%
  %  \vspace{1cm}%
  %  {\Large\ }\par%
  %  \vspace{1cm}%
  %  {\large\ }\par%
  %  \vfill%
  %  \ %
  %\end{titlepage}%
  %\cleardoublepage
  \begin{titlepage}%
    \setcounter{TotPages}{0}
    \mbox{}\vfill%
    \centering%
    \textbf{\LARGE\diss@forename\ \diss@surname}\par%
    \vspace{1cm}%
    {\bf\LARGE\diss@title\ifx\diss@subtitle\relax\else\\\medskip\diss@subtitle\fi\par}%
    \vspace{1cm}%
    {\Large\today}\par%
    \vspace{1cm}%
    {\large\diss@type}\par%
    \vfill%
    \ifdiss@fi JYV\"ASKYL\"AN YLIOPISTO\else UNIVERSITY OF JYV\"ASKYL\"A\fi\ \the\year%
  \end{titlepage}%
  \ifdefined\diss@epigraph%
  \thispagestyle{empty}\cleardoublepage%
  \vspace*\fill%
  \diss@epigraph
  \vspace*\fill%
  \fi%
  \thispagestyle{empty}\cleardoublepage%
  \selectlanguage{english}%
  \pagenumbering{arabic}%
  \setcounter{page}{3}%
  \setcounter{TotPages}{2}%
  \chapter*{\abstractname}%
  \diss@surname, \diss@forename\\%
  \ifdiss@fi\diss@entitle\else\diss@title\ifx\diss@subtitle\relax\else. \diss@subtitle.\fi\fi\\%
  \diss@address: \diss@publisher, \the\year, \ref{TotPages} p.%
  \ifdiss@loar\ (+included articles)\fi\\%
  (\diss@series\\%
  ISSN \diss@issn; \diss@number)%
  \diss@isbn%
  \diss@inclsummary%
  \diss@diss\par%
  \vspace{2em}\noindent%
  \diss@abstract\par%
  \begin{list}{}{%
      \setlength{\topsep}{1em}%
      \setlength{\leftmargin}{\diss@kwlen}%
      \setlength{\labelwidth}{\diss@kwlen}%
      \setlength{\itemindent}{0pt}%
      \setlength{\labelsep}{0pt}%
      \setlength{\itemsep}{0pt}%
      \setlength{\parsep}{\smallskipamount}%
      \usecounter{enumiv}\renewcommand{\theenumiv}{}}%
  \item[\usebox{\diss@kw}]\diss@keywords%
  \end{list}%
  \selectdefaultlanguage
  \newpage%
  \thispagestyle{empty}%
  \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\itemindent}{0pt}%
      \setlength{\labelwidth}{4cm}%
      \setlength{\labelsep}{1cm}%
      \setlength{\leftmargin}{\labelwidth}%
			\addtolength{\leftmargin}{\itemindent}%
			\addtolength{\leftmargin}{\labelsep}%
      \setlength{\itemsep}{1em}%
      \setlength{\parsep}{2ex}%
      \renewcommand{\makelabel}[1]{\mbox{\bf ##1}}%
      \usecounter{enumiv}\renewcommand{\theenumiv}{}}%
    \diss@people%
  \end{list}%
}

\newif\if@tailmatter
\@tailmatterfalse
\newif\if@backmatter
\@backmatterfalse


\renewcommand\mainmatter{%
  \clearpage
  % LOF and LOT can start on any page (odd or even), but they are chapters,
  % and chapters always start on an odd page. So let's redefine chapter
  % temporarily so that it can start on any page
  \let\diss@old@chapter\chapter
  \let\chapter\openanychapter
  \ifdiss@lof\listoffigures\fi
  \ifdiss@lot\listoftables\fi
  \ifdiss@loa\listofalgorithm\fi
  % Back to real chapters
  \let\chapter\diss@old@chapter

  \cleardoublepage
  \tableofcontents
  \ifdiss@loar % This is ugly
    \ifdiss@contrib@before
      \listofarticles
    \else
      \listofarticles
      \ifdiss@contrib@in@loar

        \jydiss@contrib@body
      \fi
    \fi
  \fi
  \cleardoublepage
  \@mainmattertrue
  \@backmatterfalse
  \pagestyle{myheadings}
}

\renewcommand\backmatter{
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \@tailmatterfalse
  \@backmattertrue
  \diss@chapter@allowedfalse
}

\setlength{\parindent}{1cm}

\renewcommand{\Large}{%
\fontfamily{ppl}\fontseries{m}\fontsize{16}{20pt plus 0.15pt}\selectfont}
\renewcommand{\large}{%
\fontfamily{ppl}\fontseries{m}\fontsize{14}{16pt plus 0.15pt}\selectfont}

\def\ps@jydiss{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
}
\ps@jydiss

%%%% Chapters

\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip \cftbeforechapskip
    {\leftskip \cftchapindent\relax
     \rightskip \@tocrmarg
     \parfillskip -\rightskip
     \parindent \cftchapindent\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima \cftchapnumwidth\relax
     \let\@cftbsnum \cftchappresnum
     \let\@cftasnum \cftchapaftersnum
     \let\@cftasnumb \cftchapaftersnumb
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {\cftchapfont #1}\nobreak
     \cftchapfillnum{#2}}
  \fi}
%\fi

\newcommand*{\l@schapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
		\if@mainmatter
    \vskip \cftbeforechapskip
		\fi
    {{\cftchapfont #1}\par}
  \fi}

\renewcommand{\cftchapfont}{}
\renewcommand{\cftchappagefont}{}
%\renewcommand{\cftdotsep}{0.5}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\setlength{\cftchapnumwidth}{1cm}
\setlength{\cftsecindent}{1cm}
\setlength{\cftsecnumwidth}{1cm}
\setlength{\cftsubsecindent}{2cm}
\setlength{\cftsubsecnumwidth}{1.4cm}
\setlength{\cftsubsubsecindent}{3.4cm}
\setlength{\cftsubsubsecnumwidth}{1.4cm}
\renewcommand{\@cftmaketoctitle}{\chapter*{\contentsname}}
\ifdiss@shortloft
\renewcommand{\@cftmakeloftitle}{\chapter*[\loftname]{\listfigurename}}
\renewcommand{\@cftmakelottitle}{\almostchapter*[]{\listtablename}}
\else
\renewcommand{\@cftmakeloftitle}{\chapter*{\listfigurename}}
\renewcommand{\@cftmakelottitle}{\chapter*{\listtablename}}
\fi

\def\secdefalt#1#2{\@ifstar{\@dblarg{#2}}{\@dblarg{#1}}}

\def\@makechapterhead#1{%
  \vspace*{6cm}\vspace*{-\topskip}\nointerlineskip%
  \global\jydiss@toc@spacetrue%
  {\parindent \z@ \raggedright \normalfont
    \Large \bfseries 
    \ifnum \c@secnumdepth >\m@ne
		  \@tempdima 1cm\relax
	    \sbox\@tempboxa{\thechapter}%
	    \advance\@tempdima -\wd\@tempboxa 
      \@hangfrom{\thechapter\hskip\@tempdima}%
    \fi
    \MakeUppercase{#1}\par\nobreak
    \vskip 28pt
  }}

\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \large \bfseries  \MakeUppercase{#1}\par\nobreak
    \vskip 2em
  }}

%%%% Appendices

\newcommand{\@appeapp}{\appendixname}
\newcommand\appendices{\par
\setcounter{chapter}{0}%
\setcounter{section}{0}%
\diss@chapter@allowedfalse

\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-28pt}%
                                   {28pt}%
                                   {\normalfont\large\bfseries\noindent\MakeUppercase{\@appeapp}\space}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-14pt}%
                                     {14pt}%
                                     {\normalfont\normalsize\bfseries\noindent\MakeUppercase{\@appeapp}\space}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-14pt}%
                                     {14pt}%
                                     {\normalfont\normalsize\bfseries\noindent\MakeUppercase{\@appeapp}\space}}
}


\def\@appendix[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@appeapp\space\thechapter.}%
                         \addcontentsline{toc}{appendix}%
                                   {\protect\numberline{\HyMakeUppercase{\@appeapp}\space\thechapter}{\HyMakeUppercase{#1}}}%
                       \else
                         \addcontentsline{toc}{appendix}{\HyMakeUppercase{#1}}%
                       \fi
                    \else
                      \addcontentsline{toc}{appendix}{\HyMakeUppercase{#1}}%
                    \fi
                    \chaptermark{#1}%
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makeappendixhead{#2}]%
                    \else
                      \@makeappendixhead{#2}%
                      \@afterheading
                    \fi}

\def\@makeappendixhead#1{%
  \global\jydiss@toc@spacetrue%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \large \bfseries
    \ifnum \c@secnumdepth >\m@ne
		  \@tempdima 1cm\relax
	    \sbox\@tempboxa{\thechapter}%
	    \advance\@tempdima -\wd\@tempboxa 
      \@hangfrom{\MakeUppercase{\@appeapp\ }\thechapter\hskip\@tempdima}%
	  \else
	    \MakeUppercase{\@appeapp\ } 
    \fi
    \MakeUppercase{#1}\par\nobreak
    \vskip 1em
  }}

\newcommand*{\l@appendix}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip \cftbeforechapskip
    {\leftskip \cftchapindent\relax
     \rightskip \@tocrmarg
     \parfillskip -\rightskip
     \parindent \cftchapindent\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima \cftchapnumwidth\relax
     \sbox\@tempboxa{\@appeapp\space}%
     \advance\@tempdima\wd\@tempboxa
     \let\@cftbsnum \cftchappresnum
     \let\@cftasnum \cftchapaftersnum
     \let\@cftasnumb \cftchapaftersnumb
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     %{\cftchapfont \MakeUppercase{\@appeapp\ #1}}\nobreak
     %{\cftchapfont {\MakeUppercase\@appeapp\ #1}}\nobreak
     {\cftchapfont {#1}}\nobreak
     \cftchapfillnum{#2}}
  \fi}

%%%% Sections and subsections
\newif\ifdiss@section@indent@extra
\diss@section@indent@extrafalse
\def\diss@section@indent#1{%
  \@tempdima 1cm\relax
	\ifdiss@section@indent@extra
	  \ifthenelse{\equal{#1}{subsection}}{\@tempdima 1.3cm}{}%
	  \ifthenelse{\equal{#1}{subsubsection}}{\@tempdima 1.6cm}{}%
	  \immediate\write\@mainaux{\string\global\string\diss@section@indent@extratrue}%
	\fi}
\def\@test@section@indent#1{%
  \ifdiss@section@indent@extra\else
  \ifdim#1<4pt\relax
	  \@warning{At least one (sub)section heading indentation is too small.
		Rerun to fix the indentation}%
		\global\diss@section@indent@extratrue
	  \immediate\write\@mainaux{\string\global\string\diss@section@indent@extratrue}%
	\fi\fi}
\def\@seccntformat#1{%
  \protect\diss@section@indent{#1}%
	\setbox\@tempboxa\hbox{\csname the#1\endcsname}%
	\advance\@tempdima -\wd\@tempboxa
	\protect\@test@section@indent{\@tempdima}%
  \csname the#1\endcsname\hskip\@tempdima}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-28pt}%
                                   {28pt}%
                                   {\normalfont\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-14pt}%
                                     {14pt}%
                                     {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-14pt}%
                                     {14pt}%
                                     {\normalfont\normalsize\bfseries}}

%%%% Acronyms
\def\diss@acronyms{Acronyms}
\newcommand{\setacronyms}[1]{\gdef\diss@acronyms{#1}}

\newenvironment{acronyms}{\chapter*{\diss@acronyms}%
                          \begin{itemize}%
                          \setlength{\itemsep}{0ex}
                          \renewcommand{\makelabel}[1]{\makebox[4cm][l]{\bf ##1}}
                          }%
                         {\thispagestyle{empty}%
                          \end{itemize}}
\newcommand{\acronym}[2]{\item[#1]#2}

%%%% Common special chapters
\newcommand{\preface}{\chapter*{\prefacename}}

\newcommand{\acknowledgements}{\chapter*{\acknowledgementsname}}

\newcommand{\termlist}{\chapter*{\termlistname}}

\newcommand{\finnishsummary}{
\chapter*{\finnishsummaryheading}
\immediate\write\@mainaux{\string\gdef\string\diss@inclsummary{\string\finnishsummaryabstract}}%
}

\newenvironment{yhteenveto}{%
  \selectlanguage{finnish}%
  \finnishsummary%
}{%
  \selectdefaultlanguage%
}

%%%% List of articles
\newenvironment{thelistofarticles}[1]
  {\def\@biblabel##1{\ifdiss@bold@art@ref\bfseries \fi##1\hfill}%
\list{\@biblabel{\@Alph\c@enumiv}}%
 {\settowidth\labelwidth{\@biblabel{#1}}%
  \leftmargin\labelwidth
  \advance\leftmargin\labelsep
  \@openbib@code
  \usecounter{enumiv}%
  \let\p@enumiv\@empty
  \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
  {\endlist}

\newlistof{articles}{loar}{\listarticlename}
\renewcommand{\@cftmakeloartitle}{\chapter*{\listarticlename}%
\ifdiss@contrib@in@loar\ifdiss@contrib@before\jydiss@contrib@body\fi\fi}

\newcommand{\includedarticles}{
\ifjydiss@toc@space
  \addtocontents{toc}{\vskip\cftbeforechapskip}
  \global\jydiss@toc@spacefalse
\fi%
%\addtocontents{loar}{\protect\begin{thelistofarticles}{XVIII}}
\immediate\write\@auxout{\string\@writefile{loar}{\string\begin{thelistofarticles}{XVIII}}}
\newpage
\refstepcounter{schapter}
\addcontentsline{toc}{schapter}{\HyMakeUppercase{\includedarticlesname}}
\pagestyle{empty}
}

\def\diss@art@title{}
\def\diss@art@author{}
\def\diss@art@publish{}
\def\diss@art@publishmore{}
\def\diss@art@year{}
\def\diss@art@copyright{}
\def\diss@art@pages{0}
\def\diss@art@label{}
\newif\ifdiss@art@visible
\diss@art@visibletrue
\newcommand{\arttitle}[1]{\gdef\diss@art@title{#1}}
\newcommand{\artauthor}[1]{\gdef\diss@art@author{#1}}
\newcommand{\artpublish}[1]{\gdef\diss@art@publish{#1}}
\newcommand{\artpublishmore}[1]{\gdef\diss@art@publishmore{#1}}
\newcommand{\artyear}[1]{\gdef\diss@art@year{#1}}
\newcommand{\artcopyright}[1]{\gdef\diss@art@copyright{#1}}
%\newcommand{\artlabel}{\textbf{P\Roman{articles}}}
\newcommand{\artlabel}{P\Roman{articles}}
\newcommand{\artpages}[1]{\gdef\diss@art@pages{#1}}
\newcommand{\arthide}{\diss@art@visiblefalse}
\newcommand{\artmakebib}{%
\diss@art@author. \diss@art@title.
\if\diss@art@publish\relax\else {\itshape\diss@art@publish}\fi
\if\diss@art@publishmore\relax\else, \diss@art@publishmore\fi
\if\diss@art@year\relax\else , \diss@art@year\fi.}

% Because of NatBib. We don't want NatBib to be used for the ``included
% articles'' bibliography
%\def\diss@@lbibitem[#1]#2{\item[\@biblabel{#1}\hfill]\if@filesw
%      {\let\protect\noexpand
%       \write\@auxout{\string\bibcite{#2}{{}{}{{#1}}{{}}}}}\fi\ignorespaces}
%\def\diss@bibitem{\@ifnextchar[\diss@@lbibitem\@bibitem}

\newcommand{\artmaketitle}{%
\cleardoublepage
\ifthenelse{\value{articles}=1}{%
\vspace*{6cm}\vspace*{-\topskip}{\Large\vspace*{-3\baselineskip}}%
\centering{\Large\bfseries ORIGINAL PAPERS\par\vspace{2\baselineskip}}\nointerlineskip%
\TotPages@putlabel
}{%
\vspace*{6cm}\vspace*{-\topskip}\nointerlineskip%
}
{\centering
{\Large\bfseries \artlabel}\par\vspace{2\baselineskip}
{\large\bfseries \MakeUppercase{\diss@art@title}}\par\vspace{4\baselineskip}
by\par\vspace{2\baselineskip}
\diss@art@author
\if\diss@art@year\relax%
\else {\space\diss@art@year}
\fi
\par\vspace{1\baselineskip}
\diss@art@publish\if\diss@art@publishmore\relax\else, \diss@art@publishmore\fi

\if\diss@art@copyright\relax
\else
\par\vspace{3\baselineskip}
Reproduced with kind permission of \diss@art@copyright.\par
\fi
%\refstepcounter{section}
%\addcontentsline{toc}{section}{\HyMakeUppercase{\diss@art@title}}
\ifdiss@hyperref
  \pdfbookmark[1]{\diss@art@title}{article.\artlabel}
\fi
\cleardoublepage
}}

\def\diss@artcite#1{\global\@namedef{diss@artcite@#1}{}%
\immediate\write\@mainaux{\string\diss@artcite{#1}}}

\newenvironment{article}[1]
{\stepcounter{articles}
\gdef\diss@art@label{#1}
\diss@artcite{#1}
\gdef\diss@art@title{Set a title with \textbackslash arttitle}
\gdef\diss@art@author{Set an author with \textbackslash artauthor}
\let\diss@art@publish=\relax
\let\diss@art@publishmore=\relax
\let\diss@art@year=\relax
\let\diss@art@copyright=\relax
\diss@art@visibletrue
\gdef\diss@art@pages{0}
}
{\ifdiss@art@visible
\clearpage
\artmaketitle
\fi
%\addtocontents{loar}{
%\protect\bibitem[\artlabel]{\diss@art@label} \artmakebib
%}
\begingroup
\let\protect\@unexpandable@protect
%\immediate\write\@auxout{\string\@writefile{loar}{\string\diss@bibitem[\artlabel]{\diss@art@label} \artmakebib}}
%\immediate\write\@auxout{\string\@writefile{loar}{\string\bibitem[\artlabel]{\diss@art@label} \artmakebib}}
\ifdiss@natbib
\immediate\write\@auxout{\string\@writefile{loar}{\string\bibitem[\artlabel()]{\diss@art@label} \artmakebib}}
\else
\immediate\write\@auxout{\string\@writefile{loar}{\string\bibitem[\artlabel]{\diss@art@label} \artmakebib}}
\fi
\endgroup
%\addtocounter{page}{\diss@art@pages}
%\addtocounter{TotPages}{\diss@art@pages}
}

% ``Author's contribution'' environment, shamelessly copied from
% ltugproc.cls's abstract environment

\newtoks\jydiss@contrib@toks  \jydiss@contrib@toks{}
\let\if@jydiss@contrib\iffalse
\def\contribution{\def\@jydiss@contrib@{contribution}%
  \ifx\@currenvir\@jydiss@contrib@
  \else
    \TBError{\string\contrib\space is illegal:%
      \MessageBreak
      use \string\begin{\@jydiss@contrib@} instead}%
      {\@jydiss@contrib@\space may only be used as an environment}
  \fi
  \global\let\if@jydiss@contrib\iftrue
  {\ifnum0=`}\fi
  \@jydiss@contrib@getbody}
\let\endjydiss@contrib\relax
\long\def\@jydiss@contrib@getbody#1\end{%
  \global\jydiss@contrib@toks\expandafter{\the\jydiss@contrib@toks#1}%
  \@jydiss@contrib@findend}
\def\@jydiss@contrib@findend#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@jydiss@contrib@
    \expandafter\@jydiss@contrib@end
  \else
    \def\@tempb{document}%
    \ifx\@tempa\@tempb
      \TBError{\string\begin{\@jydiss@contrib@}
          ended by \string\end{\@tempb}}%
        {You've forgotten \string\end{\@jydiss@contrib@}}
    \else
       \global\jydiss@contrib@toks\expandafter{\the\jydiss@contrib@toks\end{#1}}
       \expandafter\expandafter\expandafter\@jydiss@contrib@getbody
    \fi
  \fi}
\def\@jydiss@contrib@end{\ifnum0=`{\fi}%
  \expandafter\end\expandafter{\@jydiss@contrib@}
  \immediate\write\@mainaux{%
    \string\jydiss@set@contrib@body\string{\string\noindent\the\jydiss@contrib@toks\string}%
  }%
}

\def\jydiss@contrib@body{You need to run \LaTeX{} a second time.}
\newcommand\jydiss@set@contrib@body[1]{\long\gdef\jydiss@contrib@body{#1}}

% Changing the citation label in the body of the document depending on whether
% the citation is an included article or not
\newif\ifdiss@artcite\diss@artcitefalse
%\let\@cite@rig=\@cite
%\def\@cite#1#2{\ifdiss@artcite\textbf{#1}\else\@cite@rig{#1}{#2}\fi\diss@artcitefalse}
%
%\let\@citex@rig=\@citex
%\def\@citex[#1]#2{\@ifundefined{diss@artcite@#2}{\diss@artcitefalse\@citex@rig[#1]{#2}}{\diss@artcitetrue\@citex@rig[#1]{#2}}}

%%%% Floats and numbering

\@removefromreset{figure}{chapter}
\@removefromreset{table}{chapter}
\@removefromreset{equation}{chapter}
\renewcommand{\thefigure}{\@arabic\c@figure}
\renewcommand{\thetable}{\@arabic\c@table}
\renewcommand{\theequation}{\@arabic\c@equation}

\setlength{\cftfignumwidth}{6em}
%\renewcommand{\cftfigdotsep}{6}
\renewcommand{\cftfigpresnum}{\MakeUppercase{\figurename}\space}
\renewcommand{\cftfigindent}{0em}
\ifdiss@fi
\setlength{\cfttabnumwidth}{8em}
\else
\setlength{\cfttabnumwidth}{6em}
\fi
%\renewcommand{\cfttabdotsep}{6}
\renewcommand{\cfttabpresnum}{\MakeUppercase{\tablename}\space}
\renewcommand{\cfttabindent}{0em}

\setlength{\textfloatsep}{1em plus 1em}
\setlength{\floatsep}{2em plus 1em}

%%%% Lists

% LaTeX naturally indents a paragraph coming after a list if there is an empty
% line between the list and the paragraph. This paragraph must never be
% indented, the following code ensures it.

\def\@doendpe{%
  \@endpetrue
  \def\par{%
    \if@endpe{\@@par}\else\@restorepar
    \everypar{}\par\@endpefalse\fi}%
  \everypar{{\setbox\z@\lastbox}%
  \everypar{}\@endpefalse}}%

\def\jydissbiburl#1{$\langle$URL:\url{#1}$\rangle$}

% quotations
\renewenvironment{quotation}
                 {\list{}{\listparindent 1cm%
                          \itemindent    \z@%
                          \leftmargin    1cm%
                          \rightmargin   \z@%
                          \parsep        \z@ \@plus\p@}%
                  \fontsize{10.5}{11}\selectfont%
                  \item\relax}
                 {\endlist}
\renewenvironment{quote}
                 {\list{}{\leftmargin    1cm%
                          \rightmargin   \z@}%
                  \fontsize{10.5}{11}\selectfont%
                  \item\relax}
                 {\endlist}

% standard lists
\renewenvironment{itemize}
                 {\list{--}{\setlength {\listparindent}{1cm}%
                            \setlength {\itemindent}   {\z@}%
                            \setlength {\leftmargin}   {1cm}%
                            \setlength {\rightmargin}  {\z@}%
                            \setlength {\parsep}       {\p@}%
                            \setlength {\itemsep}      {\z@}}}
                 {\endlist}
\renewenvironment{description}
                 {\list{}{\setlength {\listparindent}{1cm}%
                          \setlength {\itemindent}   {\z@}%
                          \setlength {\leftmargin}   {1cm}%
                          \setlength {\rightmargin}  {\z@}%
                          \setlength {\parsep}       {\p@}%
                          \setlength {\itemsep}      {\z@}%
                         \let\makelabel\descriptionlabel}}
                 {\endlist}
\renewcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont #1:}
\renewenvironment{enumerate}
                 {\ifnum \@enumdepth >\thr@@\@toodeep\else
                  \advance\@enumdepth\@ne
                  \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
                  \expandafter
                  \list \csname label\@enumctr\endcsname
                       {\setlength {\listparindent}{1cm}%
                        \setlength {\itemindent}   {\z@}%
                        \setlength {\leftmargin}   {1cm}%
                        \setlength {\rightmargin}  {\z@}%
                        \setlength {\parsep}       {\p@}%
                        \setlength {\itemsep}      {\z@}}%
                       \usecounter\@enumctr
                  \fi}
                 {\endlist}

\endinput

% from sveta 
%%%% Notation
%\def\diss@notations{Notation}
%\newcommand{\setnotations}[1]{\gdef\diss@notations{#1}}
%
%\newenvironment{notations}{\chapter*{\diss@notations}%
%                          \begin{itemize}%
%                          \setlength{\itemsep}{0ex}
%                          \renewcommand{\makelabel}[1]{\makebox[3cm][l]{ ##1}}
%                          }%
%                         {\thispagestyle{empty}%
%                          \end{itemize}}
%\newcommand{\notation}[2]{\item[#1]#2}


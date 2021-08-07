% Written by Antti-Juhani Kaijanaho in October 2008
% You may treat this file as if it were in the public domain.

% You can access the most recent version at
%  https://yousource.it.jyu.fi/latex-thesis-classes/jydiss/blobs/master/jydiss.bst




% VARIABLE NAMING CONVENTION:
% As a matter of consistency, real global variables should not contain
% periods; use the format FUNCTION.VARIABLE to create variables
% "local" to that function. Note that these variables are not truly
% local, thus they should not be touched outside FUNCTION and FUNCTION
% should treat them as "static local" variables (in C terminology)
%
% All truly global variables should be declared here; later
% declarations are intended as "local" declarations.
strings { longestlabel }
integers { longestlabellen entrylevel }

entry
  { 
    accessed
    address
    author
    booktitle
    chapter
    edition
    editor
    doi
    howpublished
    institution
    journal
    key
    language
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
  }
  {
  }
  { 
    label
    firstauthor
    allauthors
    inx
  }

% for compatibility -- we don't actually use these
macro{jan}{"jan"}
macro{feb}{"feb"}
macro{mar}{"mar"}
macro{apr}{"apr"}
macro{may}{"may"}
macro{jun}{"jun"}
macro{jul}{"jul"}
macro{aug}{"aug"}
macro{sep}{"sep"}
macro{oct}{"oct"}
macro{nov}{"nov"}
macro{dec}{"dec"}

function{lang.ed} { "\makeatletter\jydiss@bib@ed\makeatother{}" }
function{lang.eds} { "\makeatletter\jydiss@bib@eds\makeatother{}" }
function{lang.vol} { "\makeatletter\jydiss@bib@vol\makeatother{}" }
function{lang.In} { "\makeatletter\jydiss@bib@In\makeatother{}" }
function{lang.pp} { "\jydissbibpp{}" }
function{lang.accessed.s} { "\makeatletter\jydiss@bib@accessed" }
function{lang.accessed.e} { "\makeatother{}" }
function{lang.mastersthesis} 
{
  "\makeatletter\jydiss@bib@mastersthesis\makeatother{}" 
}
function{lang.phdthesis} 
{
  "\makeatletter\jydiss@bib@phdthesis\makeatother{}" 
}
function{lang.edition}
{
  "\makeatletter\jydiss@bib@edition{" swap$ * "}\makeatother{}" *
}

integers { add.comma.tmp }

function{and}
{
  #0 = { pop$ #0 } 'skip$ if$
}

function{or.anon}
{
  duplicate$ empty$ { pop$ "Anon." } 'skip$ if$
}

function{the.year}
{
  year empty$ { "s.~a." } { year } if$
}

function{author.or.editor}
{
  author empty$ { editor } { author } if$ or.anon
}

function{label.base}
{
   author.or.editor num.names$ #2 >
   {
     firstauthor " et al." *
   }
   {
     allauthors
   }
   if$
}

function{publisher.or.organization}
{
  publisher empty$ { organization } { publisher } if$
}

function{book.title}
{
  booktitle empty$ { title } { booktitle } if$
}

strings  { write.names.name write.names.this.name }
integers { write.names.i 
           write.names.n
           write.names.reverse }

% first parameter is true if the name should start with the surname
% second parameter is the field to be formatted
% the result is written out
function{write.names}
{
  'write.names.reverse :=
  'write.names.name :=
  write.names.name num.names$ 'write.names.n :=
  #1 'write.names.i :=
  {
    write.names.i #1 - write.names.n <
  }
  {
    write.names.name write.names.i
      write.names.reverse 
      { "{vv~}{ll}{, jj}{, f.}" }  
      {"{f.~}{vv~}{ll}{, jj}"} 
      if$
    format.name$
    'write.names.this.name :=

    write.names.i #1 =
    {
      write.names.this.name write$
    }
    {
      write.names.i write.names.n <
      {
        ", " write$
        write.names.this.name write$
      }
      {
        write.names.this.name "others" =
        {
          " et al." write$
        }
        {
          " \& " write$
          write.names.this.name write$
        }
        if$
      }
      if$
    }
    if$
    write.names.i #1 + 'write.names.i :=
  }
  while$
}

function{entry.start}
{
  entrylevel #0 =
    {
      "\bibitem[" label * "]{" * cite$ * "}" * write$ newline$
      language empty$ 
        'skip$
        { "\makeatletter\jydiss@bib@startlanguage{" language * 
          "}\makeatother" * write$ newline$ 
        }
      if$
    }
    'skip$
    if$
    entrylevel #1 + 'entrylevel :=
}

function{entry.end}
{
  entrylevel #1 - 'entrylevel :=
  entrylevel #0 > 
    'skip$ 
    {
      doi empty$ { "" } { "\ \url{doi:" doi * "}" * add.period$ } if$
      url empty$ { "" } {"\ \jydissbiburl{" url * "}" * add.period$ } if$ *
      accessed empty$ { "" } { "\ " lang.accessed.s * accessed * lang.accessed.e * add.period$ } if$ *
      note empty$ { "" } { "\ (" note * ")" * add.period$ } if$ *
      "%" * write$ newline$
      language empty$ 
        'skip$ 
        { "\makeatletter\jydiss@bib@endlanguage\makeatother"
          write$ newline$ }
      if$
    }
    if$
}

integers { presort.i presort.n }

function{presort}
{
  "" 'sort.key$ :=
  #1 'presort.i :=
  author.or.editor num.names$ 'presort.n :=
  sort.key$ 
  { presort.i #1 - presort.n < }
  {
    author.or.editor presort.i "{ll}{jj}{vv}{ff}" format.name$ *
    "|" *
    presort.i #1 + 'presort.i :=
  }
  while$
  "|" * 
  the.year *
  "|" *
  title *
  %
  'sort.key$ :=
}

strings  { compute.label.one.prev 
           compute.label.one.prevyear
           compute.label.one.tmp
           compute.label.one.previnx }
integers { compute.label.one.i compute.label.one.n }

function{compute.label.one}
{
  % compute firstauthor and allauthors
  author.or.editor num.names$ 'compute.label.one.n :=
  #1 'compute.label.one.i :=
  "" 'firstauthor :=
  "" 'allauthors :=
  { compute.label.one.i #1 - compute.label.one.n < }
  {
    author.or.editor compute.label.one.i "{vv~}{ll}" format.name$
    'compute.label.one.tmp :=
    compute.label.one.i #1 =
      {
        compute.label.one.tmp 'firstauthor :=
      }
      {
        compute.label.one.i compute.label.one.n <
          {
            allauthors ", " * 'allauthors :=
          }
          {
            compute.label.one.tmp "others" =
              {
                allauthors " et " * 'allauthors :=
                "al." 'compute.label.one.tmp :=
              }
              {
                allauthors " and " * 'allauthors :=
              }
              if$
          }
        if$
      }
    if$
    allauthors compute.label.one.tmp * 'allauthors :=
    compute.label.one.i #1 + 'compute.label.one.i :=
  }
  while$
  % compute inx
  compute.label.one.prev label.base =
  compute.label.one.prevyear year =
  and
  {
    compute.label.one.previnx chr.to.int$ #1 + int.to.chr$ 'inx :=
  }
  {
    "a" 'inx :=
  }
  if$  
  inx 'compute.label.one.previnx :=
  label.base 'compute.label.one.prev :=
  year 'compute.label.one.prevyear :=
}

strings { compute.label.two.previnx }

function{compute.label.two}
{
  inx "a" =
  {
    compute.label.two.previnx "b" =
    'skip$
    {
      "" 'inx :=
    }
    if$
  }
  'skip$
  if$
  inx 'compute.label.two.previnx :=
}

function{compute.label.three}
{
  author.or.editor num.names$ #2 >
    {
      firstauthor 
      " et al.(" *
      the.year *
      inx *
      ")" *
      allauthors *
      'label :=
    }
    {
      allauthors
      "(" *
      the.year *
      inx *
      ")" *
      'label :=
    }
  if$
  label text.length$ longestlabellen >
  {
    label 'longestlabel :=
    label text.length$ 'longestlabellen :=
  }
  'skip$
  if$
}

function{begin.bib}
{
  preamble$ write$
  "\begin{thebibliography}{" write$ 
  longestlabel write$
  "}" write$
  newline$
}
function{end.bib}
{
  "\end{thebibliography}" write$ newline$
}

function{bookish.tail}
{
  book.title
  volume empty$ 'skip$ { ", " * lang.vol * " " * volume * } if$
  edition empty$
  'skip$
  {
    " (" *
    edition lang.edition *
    ")" *
  }
  if$
  address empty$ 'skip$ { add.period$ " " * address * ": " * } if$
  publisher.or.organization empty$
  {
    address empty$
    'skip$
    {
      "Address but no publisher in " cite$ * "; this will look ugly!" * warning$
    }
    if$
  }
  {
    address empty$
    { add.period$ " " * }
    'skip$
    if$
    publisher.or.organization *
  }
  if$
  series empty$
  { 
    number empty$ 'skip$ { "Superfluous number in " cite$ * warning$ } if$
  }
  {
    add.period$
    " " *
    series *
    number empty$ 'skip$ { " " * number * } if$
  }
  if$
  pages empty$
  'skip$
  {
    ", " *
    pages *
  } if$
  add.period$ "%" * write$ newline$
}

function{article}
{
  entry.start
  author #1 write.names
  " " the.year * inx * ". " * write$ 
  title "t" change.case$ add.period$ " " * write$
  journal
  volume empty$
  { 
    number empty$
    {
      "Missing volume and number in " cite$ * warning$
    }
    {
      " " number * *
    }
    if$
  }
  {
    " " *
    number empty$
    {
      volume *
    }
    {
      volume * " (" * number * ")" *
    }
    if$
  }
  if$
  pages empty$ { "" } { ", " pages * } if$ *
  add.period$ "%" * write$ newline$
  entry.end
}

function{book}
{
  entry.start
  author.or.editor #1 write.names 
  editor empty$
  'skip$
  {
    " ("
    editor num.names$ #1 > { lang.eds } { lang.ed } if$ *
    ")" * write$
  }
  if$
  " " the.year * inx * add.period$ " " * write$ 
  bookish.tail
  entry.end
}

function{proceeding}
{
  book
}

function{proceedings}
{
  book
}

function{inproceedings}
{
  entry.start
  author or.anon #1 write.names 
  " " the.year * inx * ". " * write$ 
  title "t" change.case$ add.period$ " " * write$ 
  lang.In " " * write$
  crossref empty$
  {
    editor empty$
    'skip$
    {
      editor #0 write.names
      " ("
      editor num.names$ #1 > { lang.eds } { lang.ed } if$ *
      ") " * write$
    }
    if$
    bookish.tail
  }
  {
    "\citet"
    pages empty$
    'skip$
    {
      "[" * lang.pp * "~" * pages * "]" *
    }
    if$
    "{" * crossref * "}" *
    add.period$ write$
  }
  if$
  entry.end
}

function{conference}
{
  inproceedings
}

function{incollection}
{
  inproceedings
}

function{techreport}
{
  entry.start
  author.or.editor #1 write.names
  " " the.year * inx * add.period$ " " * write$ 
  title
  institution empty$ 'skip$ { add.period$ " " * institution * } if$
  type empty$ 'skip$ { add.period$ " " * type * } if$
  pages empty$ 'skip$ { ", " * pages * } if$
  add.period$ "%" * write$ newline$  
  entry.end
}

function{mastersthesis}
{
  entry.start
  author or.anon #1 write.names
  " " the.year * inx * add.period$ " " * write$ 
  title
  school empty$ 'skip$ { add.period$ " " * school * } if$
  add.period$ " " * type empty$ { lang.mastersthesis } { type } if$ *
  pages empty$ 'skip$ { ", " * pages * } if$
  add.period$ "%" * write$ newline$  
  entry.end
}

function{phdthesis}
{
  entry.start
  author or.anon #1 write.names
  " " the.year * inx * add.period$ " " * write$ 
  title
  school empty$ 'skip$ { add.period$ " " * school * } if$
  add.period$ " " * type empty$ { lang.phdthesis } { type } if$ *
  pages empty$ 'skip$ { ", " * pages * } if$
  add.period$ "%" * write$ newline$  
  entry.end
}

function{manual}
{
  book
}

function{misc}
{
  entry.start
  author or.anon #1 write.names
  " " the.year * inx * add.period$ " " * write$
  title empty$ 'skip$ { title add.period$ " " * write$ } if$
  howpublished empty$ 'skip$ { howpublished add.period$ " " * write$ } if$
  entry.end
}

function{unpublished}
{
  misc
}

function{default.type}
{
  misc 
}

read
iterate{presort}
sort
iterate{compute.label.one}
reverse{compute.label.two}
iterate{compute.label.three}
execute{begin.bib}
iterate{call.type$}
execute{end.bib}

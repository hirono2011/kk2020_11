% Options for packages loaded elsewhere
\PassOptionsToPackage{unicode}{hyperref}
\PassOptionsToPackage{hyphens}{url}
%
\documentclass[
]{ltjarticle}
\usepackage{listings}
\lstset{
language=sh,
basicstyle=\ttfamily\scriptsize,
commentstyle=\textit,
classoffset=1,
keywordstyle=\bfseries,
frame=tRBl,
framesep=5pt,
showstringspaces=false,
%numbers=left,
%stepnumber=1,
%numberstyle=\tiny,
tabsize=2,
breaklines = true,
}

\begin{document}

\section{Go 言語による Hello World}

\begin{lstlisting}
>|sh|
#!/bin/bash

if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>2|
  echo "実行するにはTwilogcsvのファイル名を１つ引数で指定。" 1>2
  exit 1
fi

cd ~/twilog
prev_file=$1
user=${prev_file%%[0-9]*\.csv}
pp=`sed -nE '1s/^([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}).+/\1/p' $prev_file`; echo $pp
next_file=`basename ~/Downloads/${prev_file%%[0-9]*\.csv}*.csv.gz`
mv ~/Downloads/$next_file ~/twilog/tmp.csv.gz
new_file=${next_file%%.gz}

next_file=tmp.csv
gunzip ${next_file}.gz

ruby -pne '$_.gsub!(/\n/, " ")' $next_file | ruby -pne '$_.gsub!(/" "/, "\"\n\"")'|sed '$s/ $/\n/' > a  mv a $next_file
sed -i -E "s/\"([0-9]+)\",\"([0-9]{2})([0-9]{2})([0-9]{2}) ([0-9]{2})([0-9]{2})([0-9]{2})\",\"(.+)\"$/20\2-\3-\4 \5:\6:\7 \"\8\" https:\/\/twitter.com\/${user}\/status/\/\1/" $next_file
echo "new $next_file"
echo "prev $prev_file"
sed -i  '1i XXX' $prev_file  sed -n "1,$((`sed -n "/${pp}/=" ${next_file}` - 1))p" $next_file | sed -i '1r /dev/stdin' $prev_file  sed -i '/^XXX$/d' $prev_file
mv tmp.csv $new_file

if [ $prev_file != $new_file ]; then
  rm $prev_file
fi

sed -n "1,$((`sed -n "/${pp}/=" ${new_file}` - 1))p" $new_file | wc -l 
 echo "${new_file}を更新しました。"


||<
\end{lstlisting}

\lstinputlisting[caption=make-pdf.sh,label=xxxx]{make-pdf.sh}
\end{document}
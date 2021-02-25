#!/bin/bash

org_file=$1
cp $org_file tmp.md
work_file='tmp.md'

sed -i -E '/^>\|.+\|$/,/\|\|<$/s/.+/コード削除/' tmp.md
sed -i 's/\\n/￥＼n/g' tmp.md
sed -i -E 's/^(- .+)\[(https?:\/\/.+)\]\(https?:\/\/.+\)$/\1\2/g' tmp.md
sed -i -e 's%\(https\?://[^ ]\+\)[ \|"]% <\1>%g' tmp.md

md-to-tex-pandoc.rb tmp.md

day=`ruby -e 'require "wareki";print Date.today.strftime("%Jf")'`
#day="\\\newline ${day/\"//}"
sed -i -E "s/^\"令和.+\"/$day/" preamble.txt
sed -i -E 's/"(令和.+)"\1/' preamble.txt
sed -i -E "/\\maketitle/r preamble.txt" tmp.tex


lualatex tmp.tex
lualatex tmp.tex
mv tmp.pdf ${org_file/.md/.pdf}
`evince ${org_file/.md/.pdf}`


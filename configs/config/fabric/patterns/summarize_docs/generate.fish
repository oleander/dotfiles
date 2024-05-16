#!/usr/bin/env fish

set model gpt-4o
set temp 0.7

set url "$argv[1]"
set fabric ~/.local/bin/fabric
set md_file output.md
set html_file input.html

function on_exit --on-event fish_exit
    # rm -f $md_file $html_file
end

echo "==> Downloading $url ..."
curl -o "$html_file" "$url" --silent
echo "==> Converting $html_file to $md_file ..."
pandoc -f markdown -t html5 "$html_file" -o "$md_file" --quiet
echo "==> Summarizing $md_file ..."
cat "$md_file" | "$fabric" -p summarize_docs -m $model --copy --temp $temp
echo "==> Done!"

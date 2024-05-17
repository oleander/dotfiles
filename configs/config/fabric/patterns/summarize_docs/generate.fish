#!/usr/bin/env fish

set model gpt-4o
set temp 0.7

set url "$argv[1]"
set fabric ~/.local/bin/fabric
set md_file /tmp/output.md
set html_file /tmp/input.html
set rs_file /tmp/output.rs

if test -z "$url"
    echo "Usage: generate.fish <url>"
    exit 1
end

function on_exit --on-event fish_exit
    # rm -f $html_file
end

echo "==> Downloading $url ..."
curl -o "$html_file" "$url" --silent

echo "==> Pre-processing $html_file by removing links ..."
pandoc \
    -f html \
    -t html \
    --strip-comments \
    -o "$html_file" \
    "$html_file"

echo "==> Converting $html_file to $md_file ..."
pandoc --wrap=preserve \
    --lua-filter=remove-links.lua \
-o "$md_file" \
    -f html \
    -t markdown_strict-raw_html \
    --embed-resources=false \
    --strip-comments \
    "$html_file"

# include current byte size
echo "==> Pre-processing $rs_file ..."
pandoc --wrap=preserve \
    -f markdown_strict-raw_html \
    -t markdown_strict-raw_html \
    -o "$md_file" \
    "$md_file"

# echo "==> Summarizing $md_file ..."
# cat "$md_file" | "$fabric" -p summarize_docs -m $model --temp $temp >"$rs_file"

set html_size (cat "$html_file" | wc -c)
set md_size (cat "$md_file" | wc -c)
set rs_size (cat "$rs_file" | wc -c)
set html_ratio (math "$md_size / $html_size")
set rs_ratio (math "$rs_size / $md_size")

echo "==> Write to $html_file ($html_size bytes)"
echo "==> Write to $md_file ($md_size bytes, $html_ratio ratio)"
echo "==> Write to $rs_file ($rs_size bytes, $rs_ratio ratio)"

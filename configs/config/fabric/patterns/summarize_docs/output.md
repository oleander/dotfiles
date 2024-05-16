&lt;!DOCTYPE html&gt;
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="rustdoc">
<meta name="description" content="Website crawling library that rapidly crawls all pages to gather links via isolated contexts.">
<title>
spider - Rust
</title>
<script>if(window.location.protocol!=="file:")document.head.insertAdjacentHTML("beforeend","SourceSerif4-Regular-46f98efaafac5295.ttf.woff2,FiraSans-Regular-018c141bf0843ffd.woff2,FiraSans-Medium-8f9a781e4970d388.woff2,SourceCodePro-Regular-562dcc5011b6de7d.ttf.woff2,SourceCodePro-Semibold-d899c5a5c4aeb14a.ttf.woff2".split(",").map(f=>`<link rel="preload" as="font" type="font/woff2" crossorigin href="/-/rustdoc.static/${f}">`).join(""))</script>
<p><link rel="stylesheet" href="/-/rustdoc.static/normalize-76eba96aa4d2e634.css"><link rel="stylesheet" href="/-/static/vendored.css?0-6-0-7c63657e-2024-05-03" media="all" /></p>
<link rel="stylesheet" href="/-/rustdoc.static/rustdoc-dd39b87e5fcfba68.css">
<meta name="rustdoc-vars" data-root-path="../" data-static-root-path="/-/rustdoc.static/" data-current-crate="spider" data-themes="" data-resource-suffix="-20240513-1.80.0-nightly-ab14f944a" data-rustdoc-version="1.80.0-nightly (ab14f944a 2024-05-13)" data-channel="nightly" data-search-js="search-d52510db62a78183.js" data-settings-js="settings-4313503d2e1961c2.js" >
<script src="/-/rustdoc.static/storage-118b08c4c78b968e.js"></script>
<script defer src="../crates-20240513-1.80.0-nightly-ab14f944a.js"></script>
<script defer src="/-/rustdoc.static/main-20a3ad099b048cf2.js"></script>
<noscript>
<link rel="stylesheet" href="/-/rustdoc.static/noscript-df360f571f6edeae.css">
</noscript>
<p><link rel="alternate icon" type="image/png" href="/-/rustdoc.static/favicon-32x32-422f7d1d52889060.png"><link rel="icon" type="image/svg+xml" href="/-/rustdoc.static/favicon-2c020d218678b618.svg">
<link rel="stylesheet" href="/-/static/rustdoc-2021-12-05.css?0-6-0-7c63657e-2024-05-03" media="all" /></p>
<pre><code>    &lt;link rel=&quot;search&quot; href=&quot;/-/static/opensearch.xml&quot; type=&quot;application/opensearchdescription+xml&quot; title=&quot;Docs.rs&quot; /&gt;

    &lt;script type=&quot;text/javascript&quot;&gt;(function() {
function applyTheme(theme) {
    if (theme) {
        document.documentElement.dataset.docsRsTheme = theme;
    }
}

window.addEventListener(&quot;storage&quot;, ev =&gt; {
    if (ev.key === &quot;rustdoc-theme&quot;) {
        applyTheme(ev.newValue);
    }
});

// see ./storage-change-detection.html for details
window.addEventListener(&quot;message&quot;, ev =&gt; {
    if (ev.data &amp;&amp; ev.data.storage &amp;&amp; ev.data.storage.key === &quot;rustdoc-theme&quot;) {
        applyTheme(ev.data.storage.value);
    }
});

applyTheme(window.localStorage.getItem(&quot;rustdoc-theme&quot;));</code></pre>
})(); </script>
</head>
<body class="rustdoc-page">
<div class="nav-container">
<pre><code>&lt;div class=&quot;container&quot;&gt;
    &lt;div class=&quot;pure-menu pure-menu-horizontal&quot; role=&quot;navigation&quot; aria-label=&quot;Main navigation&quot;&gt;
        &lt;form action=&quot;/releases/search&quot;
              method=&quot;GET&quot;
              id=&quot;nav-search-form&quot;
              class=&quot;landing-search-form-nav  &quot;&gt;


            &lt;a href=&quot;/&quot; class=&quot;pure-menu-heading pure-menu-link docsrs-logo&quot; aria-label=&quot;Docs.rs&quot;&gt;
                &lt;span title=&quot;Docs.rs&quot;&gt;&lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 576 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M290.8 48.6l78.4 29.7L288 109.5 206.8 78.3l78.4-29.7c1.8-.7 3.8-.7 5.7 0zM136 92.5V204.7c-1.3 .4-2.6 .8-3.9 1.3l-96 36.4C14.4 250.6 0 271.5 0 294.7V413.9c0 22.2 13.1 42.3 33.5 51.3l96 42.2c14.4 6.3 30.7 6.3 45.1 0L288 457.5l113.5 49.9c14.4 6.3 30.7 6.3 45.1 0l96-42.2c20.3-8.9 33.5-29.1 33.5-51.3V294.7c0-23.3-14.4-44.1-36.1-52.4l-96-36.4c-1.3-.5-2.6-.9-3.9-1.3V92.5c0-23.3-14.4-44.1-36.1-52.4l-96-36.4c-12.8-4.8-26.9-4.8-39.7 0l-96 36.4C150.4 48.4 136 69.3 136 92.5zM392 210.6l-82.4 31.2V152.6L392 121v89.6zM154.8 250.9l78.4 29.7L152 311.7 70.8 280.6l78.4-29.7c1.8-.7 3.8-.7 5.7 0zm18.8 204.4V354.8L256 323.2v95.9l-82.4 36.2zM421.2 250.9c1.8-.7 3.8-.7 5.7 0l78.4 29.7L424 311.7l-81.2-31.1 78.4-29.7zM523.2 421.2l-77.6 34.1V354.8L528 323.2v90.7c0 3.2-1.9 6-4.8 7.3z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;&lt;/span&gt;
                &lt;span class=&quot;title&quot;&gt;Docs.rs&lt;/span&gt;
            &lt;/a&gt;</code></pre>
<ul class="pure-menu-list">
<script id="crate-metadata" type="application/json">
        
        {
            "name": "spider",
            "version": "1.94.5"
        }
    </script>
<li class="pure-menu-item pure-menu-has-children">
<p><a href="#" class="pure-menu-link crate-name" title="The fastest web crawler written in Rust.">
<span class="fa-svg fa-svg-fw"
aria-hidden="true"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --><path d="M234.5 5.7c13.9-5 29.1-5 43.1 0l192 68.6C495 83.4 512 107.5 512 134.6V377.4c0 27-17 51.2-42.5 60.3l-192 68.6c-13.9 5-29.1 5-43.1 0l-192-68.6C17 428.6 0 404.5 0 377.4V134.6c0-27 17-51.2 42.5-60.3l192-68.6zM256 66L82.3 128 256 190l173.7-62L256 66zm32 368.6l160-57.1v-188L288 246.6v188z"/></svg></span>
<span class="title">spider-1.94.5</span> </a></p>
<div class="pure-menu-children package-details-menu">
<pre><code>            &lt;ul class=&quot;pure-menu-list menu-item-divided&quot;&gt;
                &lt;li class=&quot;pure-menu-heading&quot; id=&quot;crate-title&quot;&gt;
                    spider 1.94.5
                    &lt;span id=&quot;clipboard&quot; class=&quot;fa-svg fa-svg-fw&quot; title=&quot;Copy crate name and version information&quot;&gt;&lt;svg width=&quot;24&quot; height=&quot;25&quot; viewBox=&quot;0 0 24 25&quot; fill=&quot;currentColor&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot; aria-label=&quot;Copy to clipboard&quot;&gt;&lt;path d=&quot;M18 20h2v3c0 1-1 2-2 2H2c-.998 0-2-1-2-2V5c0-.911.755-1.667 1.667-1.667h5A3.323 3.323 0 0110 0a3.323 3.323 0 013.333 3.333h5C19.245 3.333 20 4.09 20 5v8.333h-2V9H2v14h16v-3zM3 7h14c0-.911-.793-1.667-1.75-1.667H13.5c-.957 0-1.75-.755-1.75-1.666C11.75 2.755 10.957 2 10 2s-1.75.755-1.75 1.667c0 .911-.793 1.666-1.75 1.666H4.75C3.793 5.333 3 6.09 3 7z&quot;/&gt;&lt;path d=&quot;M4 19h6v2H4zM12 11H4v2h8zM4 17h4v-2H4zM15 15v-3l-4.5 4.5L15 21v-3l8.027-.032L23 15z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;
                &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                    &lt;a href=&quot;/spider/1.94.5/spider/index.html&quot; class=&quot;pure-menu-link description&quot; id=&quot;permalink&quot; title=&quot;Get a link to this specific version&quot;&gt;
                        &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 640 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M579.8 267.7c56.5-56.5 56.5-148 0-204.5c-50-50-128.8-56.5-186.3-15.4l-1.6 1.1c-14.4 10.3-17.7 30.3-7.4 44.6s30.3 17.7 44.6 7.4l1.6-1.1c32.1-22.9 76-19.3 103.8 8.6c31.5 31.5 31.5 82.5 0 114L422.3 334.8c-31.5 31.5-82.5 31.5-114 0c-27.9-27.9-31.5-71.8-8.6-103.8l1.1-1.6c10.3-14.4 6.9-34.4-7.4-44.6s-34.4-6.9-44.6 7.4l-1.1 1.6C206.5 251.2 213 330 263 380c56.5 56.5 148 56.5 204.5 0L579.8 267.7zM60.2 244.3c-56.5 56.5-56.5 148 0 204.5c50 50 128.8 56.5 186.3 15.4l1.6-1.1c14.4-10.3 17.7-30.3 7.4-44.6s-30.3-17.7-44.6-7.4l-1.6 1.1c-32.1 22.9-76 19.3-103.8-8.6C74 372 74 321 105.5 289.5L217.7 177.2c31.5-31.5 82.5-31.5 114 0c27.9 27.9 31.5 71.8 8.6 103.9l-1.1 1.6c-10.3 14.4-6.9 34.4 7.4 44.6s34.4 6.9 44.6-7.4l1.1-1.6C433.5 260.8 427 182 377 132c-56.5-56.5-148-56.5-204.5 0L60.2 244.3z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Permalink
                    &lt;/a&gt;
                &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                    &lt;a href=&quot;/crate/spider/latest&quot; class=&quot;pure-menu-link description&quot; title=&quot;See spider in docs.rs&quot;&gt;
                        &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 512 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M234.5 5.7c13.9-5 29.1-5 43.1 0l192 68.6C495 83.4 512 107.5 512 134.6V377.4c0 27-17 51.2-42.5 60.3l-192 68.6c-13.9 5-29.1 5-43.1 0l-192-68.6C17 428.6 0 404.5 0 377.4V134.6c0-27 17-51.2 42.5-60.3l192-68.6zM256 66L82.3 128 256 190l173.7-62L256 66zm32 368.6l160-57.1v-188L288 246.6v188z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Docs.rs crate page
                    &lt;/a&gt;
                &lt;/li&gt;

                &lt;li class=&quot;pure-menu-item&quot;&gt;
                    &lt;a href=&quot;/crate/spider/latest&quot; class=&quot;pure-menu-link&quot;&gt;
                        &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 640 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M117.9 62.4c-16.8-5.6-25.8-23.7-20.2-40.5s23.7-25.8 40.5-20.2l113 37.7C265 15.8 290.7 0 320 0c44.2 0 80 35.8 80 80c0 3-.2 5.9-.5 8.8l122.6 40.9c16.8 5.6 25.8 23.7 20.2 40.5s-23.7 25.8-40.5 20.2L366.4 145.2c-4.5 3.2-9.3 5.9-14.4 8.2V480c0 17.7-14.3 32-32 32H128c-17.7 0-32-14.3-32-32s14.3-32 32-32H288V153.3c-21-9.2-37.2-27-44.2-49l-125.9-42zm396.3 211c-.4-.8-1.3-1.3-2.2-1.3s-1.7 .5-2.2 1.3L435.1 416H588.9L514.2 273.3zM512 224c18.8 0 36 10.4 44.7 27l77.8 148.5c3.1 5.8 6.1 14 5.5 23.8c-.7 12.1-4.8 35.2-24.8 55.1C594.9 498.6 562.2 512 512 512s-82.9-13.4-103.2-33.5c-20-20-24.2-43-24.8-55.1c-.6-9.8 2.5-18 5.5-23.8L467.3 251c8.7-16.6 25.9-27 44.7-27zM128 144c-.9 0-1.7 .5-2.2 1.3L51.1 288H204.9L130.2 145.3c-.4-.8-1.3-1.3-2.2-1.3zm44.7-21l77.8 148.5c3.1 5.8 6.1 14 5.5 23.8c-.7 12.1-4.8 35.2-24.8 55.1C210.9 370.6 178.2 384 128 384s-82.9-13.4-103.2-33.5c-20-20-24.2-43-24.8-55.1c-.6-9.8 2.5-18 5.5-23.8L83.3 123C92 106.4 109.2 96 128 96s36 10.4 44.7 27z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; MIT
                    &lt;/a&gt;
                &lt;/li&gt;
            &lt;/ul&gt;

            &lt;div class=&quot;pure-g menu-item-divided&quot;&gt;
                &lt;div class=&quot;pure-u-1-2 right-border&quot;&gt;
                    &lt;ul class=&quot;pure-menu-list&quot;&gt;
                        &lt;li class=&quot;pure-menu-heading&quot;&gt;Links&lt;/li&gt;

                        &lt;li class=&quot;pure-menu-item&quot;&gt;
                                &lt;a href=&quot;https:&amp;#x2F;&amp;#x2F;docs.rs&amp;#x2F;spider&quot; title=&quot;Canonical documentation&quot; class=&quot;pure-menu-link&quot;&gt;
                                    &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 384 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M365.3 93.38l-74.63-74.64C278.6 6.742 262.3 0 245.4 0L64-.0001c-35.35 0-64 28.65-64 64l.0065 384c0 35.34 28.65 64 64 64H320c35.2 0 64-28.8 64-64V138.6C384 121.7 377.3 105.4 365.3 93.38zM336 448c0 8.836-7.164 16-16 16H64.02c-8.838 0-16-7.164-16-16L48 64.13c0-8.836 7.164-16 16-16h160L224 128c0 17.67 14.33 32 32 32h79.1V448zM96 280C96 293.3 106.8 304 120 304h144C277.3 304 288 293.3 288 280S277.3 256 264 256h-144C106.8 256 96 266.8 96 280zM264 352h-144C106.8 352 96 362.8 96 376s10.75 24 24 24h144c13.25 0 24-10.75 24-24S277.3 352 264 352z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Documentation
                                &lt;/a&gt;
                            &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                &lt;a href=&quot;https:&amp;#x2F;&amp;#x2F;github.com&amp;#x2F;spider-rs&amp;#x2F;spider&quot; class=&quot;pure-menu-link&quot;&gt;
                                    &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 448 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M80 104c13.3 0 24-10.7 24-24s-10.7-24-24-24S56 66.7 56 80s10.7 24 24 24zm80-24c0 32.8-19.7 61-48 73.3v87.8c18.8-10.9 40.7-17.1 64-17.1h96c35.3 0 64-28.7 64-64v-6.7C307.7 141 288 112.8 288 80c0-44.2 35.8-80 80-80s80 35.8 80 80c0 32.8-19.7 61-48 73.3V160c0 70.7-57.3 128-128 128H176c-35.3 0-64 28.7-64 64v6.7c28.3 12.3 48 40.5 48 73.3c0 44.2-35.8 80-80 80s-80-35.8-80-80c0-32.8 19.7-61 48-73.3V352 153.3C19.7 141 0 112.8 0 80C0 35.8 35.8 0 80 0s80 35.8 80 80zm232 0c0-13.3-10.7-24-24-24s-24 10.7-24 24s10.7 24 24 24s24-10.7 24-24zM80 456c13.3 0 24-10.7 24-24s-10.7-24-24-24s-24 10.7-24 24s10.7 24 24 24z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Repository
                                &lt;/a&gt;
                            &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                            &lt;a href=&quot;https://crates.io/crates/spider&quot; class=&quot;pure-menu-link&quot; title=&quot;See spider in crates.io&quot;&gt;
                                &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 512 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M234.5 5.7c13.9-5 29.1-5 43.1 0l192 68.6C495 83.4 512 107.5 512 134.6V377.4c0 27-17 51.2-42.5 60.3l-192 68.6c-13.9 5-29.1 5-43.1 0l-192-68.6C17 428.6 0 404.5 0 377.4V134.6c0-27 17-51.2 42.5-60.3l192-68.6zM256 66L82.3 128 256 190l173.7-62L256 66zm32 368.6l160-57.1v-188L288 246.6v188z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Crates.io
                            &lt;/a&gt;
                        &lt;/li&gt;


                        &lt;li class=&quot;pure-menu-item&quot;&gt;
                            &lt;a href=&quot;/crate/spider/latest/source/&quot; title=&quot;Browse source of spider-1.94.5&quot; class=&quot;pure-menu-link&quot;&gt;
                                &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 576 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M88.7 223.8L0 375.8V96C0 60.7 28.7 32 64 32H181.5c17 0 33.3 6.7 45.3 18.7l26.5 26.5c12 12 28.3 18.7 45.3 18.7H416c35.3 0 64 28.7 64 64v32H144c-22.8 0-43.8 12.1-55.3 31.8zm27.6 16.1C122.1 230 132.6 224 144 224H544c11.5 0 22 6.1 27.7 16.1s5.7 22.2-.1 32.1l-112 192C453.9 474 443.4 480 432 480H32c-11.5 0-22-6.1-27.7-16.1s-5.7-22.2 .1-32.1l112-192z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; Source
                            &lt;/a&gt;
                        &lt;/li&gt;
                    &lt;/ul&gt;
                &lt;/div&gt;


                &lt;div class=&quot;pure-u-1-2&quot;&gt;
                    &lt;ul class=&quot;pure-menu-list&quot;&gt;
                        &lt;li class=&quot;pure-menu-heading&quot;&gt;Owners&lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                &lt;a href=&quot;https://crates.io/users/madeindjs&quot; class=&quot;pure-menu-link&quot;&gt;
                                    &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 448 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0S96 57.3 96 128s57.3 128 128 128zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; madeindjs
                                &lt;/a&gt;
                            &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                &lt;a href=&quot;https://crates.io/users/j-mendez&quot; class=&quot;pure-menu-link&quot;&gt;
                                    &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 448 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0S96 57.3 96 128s57.3 128 128 128zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt; j-mendez
                                &lt;/a&gt;
                            &lt;/li&gt;&lt;/ul&gt;
                &lt;/div&gt;
            &lt;/div&gt;

            &lt;div class=&quot;pure-g menu-item-divided&quot;&gt;
                &lt;div class=&quot;pure-u-1-2 right-border&quot;&gt;
                    &lt;ul class=&quot;pure-menu-list&quot;&gt;
                        &lt;li class=&quot;pure-menu-heading&quot;&gt;Dependencies&lt;/li&gt;


                        &lt;li class=&quot;pure-menu-item&quot;&gt;
                            &lt;div class=&quot;pure-menu pure-menu-scrollable sub-menu&quot; tabindex=&quot;-1&quot;&gt;
                                &lt;ul class=&quot;pure-menu-list&quot;&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/ahash/^0.8.11&quot; class=&quot;pure-menu-link&quot;&gt;
                                                ahash ^0.8.11
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/async-openai/^0.20.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                async-openai ^0.20.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/async-trait/^0.1.75&quot; class=&quot;pure-menu-link&quot;&gt;
                                                async-trait ^0.1.75
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/async_job/^0.1.4&quot; class=&quot;pure-menu-link&quot;&gt;
                                                async_job ^0.1.4
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/bytes/^1.5.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                bytes ^1.5.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/case_insensitive_string/^0.2.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                case_insensitive_string ^0.2.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/chromiumoxide/^0.5.7&quot; class=&quot;pure-menu-link&quot;&gt;
                                                chromiumoxide ^0.5.7
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/chrono/^0.4.31&quot; class=&quot;pure-menu-link&quot;&gt;
                                                chrono ^0.4.31
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/compact_str/^0.7.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                compact_str ^0.7.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/const_format/^0.2.32&quot; class=&quot;pure-menu-link&quot;&gt;
                                                const_format ^0.2.32
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/cron/^0.12.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                cron ^0.12.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/cssparser/^0.31.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                cssparser ^0.31.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/ego-tree/^0.6.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                ego-tree ^0.6.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/encoding_rs/^0.8.33&quot; class=&quot;pure-menu-link&quot;&gt;
                                                encoding_rs ^0.8.33
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/fast_html5ever/^0.26.6&quot; class=&quot;pure-menu-link&quot;&gt;
                                                fast_html5ever ^0.26.6
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/fastrand/^2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                fastrand ^2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/flexbuffers/^2.0.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                flexbuffers ^2.0.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/hashbrown/^0.14.3&quot; class=&quot;pure-menu-link&quot;&gt;
                                                hashbrown ^0.14.3
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/http/^1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                http ^1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/http-cache/^0.19.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                http-cache ^0.19.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/http-cache-reqwest/^0.14.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                http-cache-reqwest ^0.14.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/http-cache-semantics/^2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                http-cache-semantics ^2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/itertools/^0.12.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                itertools ^0.12.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/jsdom/^0.0.11-alpha.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                jsdom ^0.0.11-alpha.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/lazy_static/^1.4.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                lazy_static ^1.4.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/log/^0.4&quot; class=&quot;pure-menu-link&quot;&gt;
                                                log ^0.4
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/lol_html/^1.2.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                lol_html ^1.2.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/moka/^0.12.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                moka ^0.12.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/napi/^2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                napi ^2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/num_cpus/^1.16.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                num_cpus ^1.16.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/percent-encoding/^2.3.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                percent-encoding ^2.3.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/quick-xml/^0.31.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                quick-xml ^0.31.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/regex/^1.10.4&quot; class=&quot;pure-menu-link&quot;&gt;
                                                regex ^1.10.4
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/reqwest/^0.12&quot; class=&quot;pure-menu-link&quot;&gt;
                                                reqwest ^0.12
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/reqwest-middleware/^0.3.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                reqwest-middleware ^0.3.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/selectors/^0.25.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                selectors ^0.25.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/serde/^1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                serde ^1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/serde_json/^1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                serde_json ^1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/sitemap/^0.4.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                sitemap ^0.4.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/smallvec/^1.11.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                smallvec ^1.11.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/string_concat/^0.0.1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                string_concat ^0.0.1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/strum/^0.26.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                strum ^0.26.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/tendril/^0.4.3&quot; class=&quot;pure-menu-link&quot;&gt;
                                                tendril ^0.4.3
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/tiktoken-rs/^0.5.8&quot; class=&quot;pure-menu-link&quot;&gt;
                                                tiktoken-rs ^0.5.8
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/tokio/^1&quot; class=&quot;pure-menu-link&quot;&gt;
                                                tokio ^1
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/tokio-stream/^0.1.14&quot; class=&quot;pure-menu-link&quot;&gt;
                                                tokio-stream ^0.1.14
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/ua_generator/^0.4.2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                ua_generator ^0.4.2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/url/^2&quot; class=&quot;pure-menu-link&quot;&gt;
                                                url ^2
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
                                            &lt;a href=&quot;/tikv-jemallocator/^0.5.0&quot; class=&quot;pure-menu-link&quot;&gt;
                                                tikv-jemallocator ^0.5.0
                                                &lt;i class=&quot;dependencies normal&quot;&gt;normal&lt;/i&gt;&lt;i&gt; optional &lt;/i&gt;&lt;/a&gt;
                                        &lt;/li&gt;&lt;/ul&gt;
                            &lt;/div&gt;
                        &lt;/li&gt;
                    &lt;/ul&gt;
                &lt;/div&gt;

                &lt;div class=&quot;pure-u-1-2&quot;&gt;
                    &lt;ul class=&quot;pure-menu-list&quot;&gt;
                        &lt;li class=&quot;pure-menu-heading&quot;&gt;Versions&lt;/li&gt;

                        &lt;li class=&quot;pure-menu-item&quot;&gt;
                            &lt;div class=&quot;pure-menu pure-menu-scrollable sub-menu&quot; id=&quot;releases-list&quot; tabindex=&quot;-1&quot; data-url=&quot;&amp;#x2F;crate&amp;#x2F;spider&amp;#x2F;latest&amp;#x2F;menus&amp;#x2F;releases&amp;#x2F;x86_64-unknown-linux-gnu&amp;#x2F;spider&amp;#x2F;index.html&quot; &gt;
                                &lt;span class=&quot;rotate&quot;&gt;&lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 512 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M304 48c0-26.5-21.5-48-48-48s-48 21.5-48 48s21.5 48 48 48s48-21.5 48-48zm0 416c0-26.5-21.5-48-48-48s-48 21.5-48 48s21.5 48 48 48s48-21.5 48-48zM48 304c26.5 0 48-21.5 48-48s-21.5-48-48-48s-48 21.5-48 48s21.5 48 48 48zm464-48c0-26.5-21.5-48-48-48s-48 21.5-48 48s21.5 48 48 48s48-21.5 48-48zM142.9 437c18.7-18.7 18.7-49.1 0-67.9s-49.1-18.7-67.9 0s-18.7 49.1 0 67.9s49.1 18.7 67.9 0zm0-294.2c18.7-18.7 18.7-49.1 0-67.9S93.7 56.2 75 75s-18.7 49.1 0 67.9s49.1 18.7 67.9 0zM369.1 437c18.7 18.7 49.1 18.7 67.9 0s18.7-49.1 0-67.9s-49.1-18.7-67.9 0s-18.7 49.1 0 67.9z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;&lt;/span&gt;
                            &lt;/div&gt;
                        &lt;/li&gt;
                    &lt;/ul&gt;
                &lt;/div&gt;
            &lt;/div&gt;
                &lt;div class=&quot;pure-g&quot;&gt;
                    &lt;div class=&quot;pure-u-1&quot;&gt;
                        &lt;ul class=&quot;pure-menu-list&quot;&gt;
                            &lt;li&gt;
                                &lt;a href=&quot;/crate/spider/latest&quot; class=&quot;pure-menu-link&quot;&gt;
                                    &lt;b&gt;100%&lt;/b&gt;
                                    of the crate is documented
                                &lt;/a&gt;
                            &lt;/li&gt;
                        &lt;/ul&gt;
                    &lt;/div&gt;
                &lt;/div&gt;&lt;/div&gt;
    &lt;/li&gt;&lt;li class=&quot;pure-menu-item pure-menu-has-children&quot;&gt;
    &lt;a href=&quot;#&quot; class=&quot;pure-menu-link&quot; aria-label=&quot;Platform&quot;&gt;
        &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 640 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M308.5 135.3c7.1-6.3 9.9-16.2 6.2-25c-2.3-5.3-4.8-10.5-7.6-15.5L304 89.4c-3-5-6.3-9.9-9.8-14.6c-5.7-7.6-15.7-10.1-24.7-7.1l-28.2 9.3c-10.7-8.8-23-16-36.2-20.9L199 27.1c-1.9-9.3-9.1-16.7-18.5-17.8C173.7 8.4 166.9 8 160 8s-13.7 .4-20.4 1.2c-9.4 1.1-16.6 8.6-18.5 17.8L115 56.1c-13.3 5-25.5 12.1-36.2 20.9L50.5 67.8c-9-3-19-.5-24.7 7.1c-3.5 4.7-6.8 9.6-9.9 14.6l-3 5.3c-2.8 5-5.3 10.2-7.6 15.6c-3.7 8.7-.9 18.6 6.2 25l22.2 19.8C32.6 161.9 32 168.9 32 176s.6 14.1 1.7 20.9L11.5 216.7c-7.1 6.3-9.9 16.2-6.2 25c2.3 5.3 4.8 10.5 7.6 15.6l3 5.2c3 5.1 6.3 9.9 9.9 14.6c5.7 7.6 15.7 10.1 24.7 7.1l28.2-9.3c10.7 8.8 23 16 36.2 20.9l6.1 29.1c1.9 9.3 9.1 16.7 18.5 17.8c6.7 .8 13.5 1.2 20.4 1.2s13.7-.4 20.4-1.2c9.4-1.1 16.6-8.6 18.5-17.8l6.1-29.1c13.3-5 25.5-12.1 36.2-20.9l28.2 9.3c9 3 19 .5 24.7-7.1c3.5-4.7 6.8-9.5 9.8-14.6l3.1-5.4c2.8-5 5.3-10.2 7.6-15.5c3.7-8.7 .9-18.6-6.2-25l-22.2-19.8c1.1-6.8 1.7-13.8 1.7-20.9s-.6-14.1-1.7-20.9l22.2-19.8zM208 176c0 26.5-21.5 48-48 48s-48-21.5-48-48s21.5-48 48-48s48 21.5 48 48zM504.7 500.5c6.3 7.1 16.2 9.9 25 6.2c5.3-2.3 10.5-4.8 15.5-7.6l5.4-3.1c5-3 9.9-6.3 14.6-9.8c7.6-5.7 10.1-15.7 7.1-24.7l-9.3-28.2c8.8-10.7 16-23 20.9-36.2l29.1-6.1c9.3-1.9 16.7-9.1 17.8-18.5c.8-6.7 1.2-13.5 1.2-20.4s-.4-13.7-1.2-20.4c-1.1-9.4-8.6-16.6-17.8-18.5L583.9 307c-5-13.3-12.1-25.5-20.9-36.2l9.3-28.2c3-9 .5-19-7.1-24.7c-4.7-3.5-9.6-6.8-14.6-9.9l-5.3-3c-5-2.8-10.2-5.3-15.6-7.6c-8.7-3.7-18.6-.9-25 6.2l-19.8 22.2c-6.8-1.1-13.8-1.7-20.9-1.7s-14.1 .6-20.9 1.7l-19.8-22.2c-6.3-7.1-16.2-9.9-25-6.2c-5.3 2.3-10.5 4.8-15.6 7.6l-5.2 3c-5.1 3-9.9 6.3-14.6 9.9c-7.6 5.7-10.1 15.7-7.1 24.7l9.3 28.2c-8.8 10.7-16 23-20.9 36.2L315.1 313c-9.3 1.9-16.7 9.1-17.8 18.5c-.8 6.7-1.2 13.5-1.2 20.4s.4 13.7 1.2 20.4c1.1 9.4 8.6 16.6 17.8 18.5l29.1 6.1c5 13.3 12.1 25.5 20.9 36.2l-9.3 28.2c-3 9-.5 19 7.1 24.7c4.7 3.5 9.5 6.8 14.6 9.8l5.4 3.1c5 2.8 10.2 5.3 15.5 7.6c8.7 3.7 18.6 .9 25-6.2l19.8-22.2c6.8 1.1 13.8 1.7 20.9 1.7s14.1-.6 20.9-1.7l19.8 22.2zM464 400c-26.5 0-48-21.5-48-48s21.5-48 48-48s48 21.5 48 48s-21.5 48-48 48z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;
        &lt;span class=&quot;title&quot;&gt;Platform&lt;/span&gt;
    &lt;/a&gt;


    &lt;ul class=&quot;pure-menu-children&quot; id=&quot;platforms&quot; data-url=&quot;&amp;#x2F;crate&amp;#x2F;spider&amp;#x2F;latest&amp;#x2F;menus&amp;#x2F;platforms&amp;#x2F;x86_64-unknown-linux-gnu&amp;#x2F;spider&amp;#x2F;index.html&quot; &gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a href=&quot;/crate/spider/latest/target-redirect/i686-pc-windows-msvc/spider/index.html&quot; class=&quot;pure-menu-link&quot; data-fragment=&quot;retain&quot; rel=&quot;nofollow&quot;&gt;i686-pc-windows-msvc&lt;/a&gt;
&lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a href=&quot;/crate/spider/latest/target-redirect/x86_64-apple-darwin/spider/index.html&quot; class=&quot;pure-menu-link&quot; data-fragment=&quot;retain&quot; rel=&quot;nofollow&quot;&gt;x86_64-apple-darwin&lt;/a&gt;
&lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a href=&quot;/crate/spider/latest/target-redirect/x86_64-pc-windows-msvc/spider/index.html&quot; class=&quot;pure-menu-link&quot; data-fragment=&quot;retain&quot; rel=&quot;nofollow&quot;&gt;x86_64-pc-windows-msvc&lt;/a&gt;
&lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a href=&quot;/crate/spider/latest/target-redirect/x86_64-unknown-linux-gnu/spider/index.html&quot; class=&quot;pure-menu-link current&quot; data-fragment=&quot;retain&quot; rel=&quot;nofollow&quot;&gt;x86_64-unknown-linux-gnu&lt;/a&gt;
&lt;/li&gt;&lt;/ul&gt;
&lt;/li&gt;&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a href=&quot;/crate/spider/latest/features&quot; title=&quot;Browse available feature flags of spider-1.94.5&quot; class=&quot;pure-menu-link&quot;&gt;
        &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 512 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M64 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32C0 14.3 14.3 0 32 0S64 14.3 64 32zm40.8 302.8c-3 .9-6 1.7-8.8 2.6V13.5C121.5 6.4 153 0 184 0c36.5 0 68.3 9.1 95.6 16.9l1.3 .4C309.4 25.4 333.3 32 360 32c26.8 0 52.9-6.8 73-14.1c9.9-3.6 17.9-7.2 23.4-9.8c2.7-1.3 4.8-2.4 6.2-3.1c.7-.4 1.1-.6 1.4-.8l.2-.1c9.9-5.6 22.1-5.6 31.9 .2S512 20.6 512 32V288c0 12.1-6.8 23.2-17.7 28.6L480 288c14.3 28.6 14.3 28.6 14.3 28.6l0 0 0 0-.1 0-.2 .1-.7 .4c-.6 .3-1.5 .7-2.5 1.2c-2.2 1-5.2 2.4-9 4c-7.7 3.3-18.5 7.6-31.5 11.9C424.5 342.9 388.8 352 352 352c-37 0-65.2-9.4-89-17.3l-1-.3c-24-8-43.7-14.4-70-14.4c-27.5 0-60.1 7-87.2 14.8z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;
        &lt;span class=&quot;title&quot;&gt;Feature flags&lt;/span&gt;
    &lt;/a&gt;
&lt;/li&gt;</code></pre>
</ul>
<div class="spacer">

</div>
<pre><code>            &lt;ul class=&quot;pure-menu-list&quot;&gt;
                &lt;li class=&quot;pure-menu-item pure-menu-has-children&quot;&gt;
                    &lt;a href=&quot;#&quot; class=&quot;pure-menu-link&quot; aria-label=&quot;Rust&quot;&gt;Rust&lt;/a&gt;
                    &lt;ul class=&quot;pure-menu-children&quot;&gt;
                        
&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;&amp;#x2F;about&quot; &gt;
        About docs.rs
    &lt;/a&gt;
&lt;/li&gt;


&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;foundation.rust-lang.org&amp;#x2F;policies&amp;#x2F;privacy-policy&amp;#x2F;#docs.rs&quot; target=&quot;_blank&quot;&gt;
        Privacy policy
    &lt;/a&gt;
&lt;/li&gt;


&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;www.rust-lang.org&amp;#x2F;&quot; target=&quot;_blank&quot;&gt;
        Rust website
    &lt;/a&gt;
&lt;/li&gt;


&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;doc.rust-lang.org&amp;#x2F;book&amp;#x2F;&quot; target=&quot;_blank&quot;&gt;
        The Book
    &lt;/a&gt;
&lt;/li&gt;



&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;doc.rust-lang.org&amp;#x2F;std&amp;#x2F;&quot; target=&quot;_blank&quot;&gt;
        Standard Library API Reference
    &lt;/a&gt;
&lt;/li&gt;



&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;doc.rust-lang.org&amp;#x2F;rust-by-example&amp;#x2F;&quot; target=&quot;_blank&quot;&gt;
        Rust by Example
    &lt;/a&gt;
&lt;/li&gt;



&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;doc.rust-lang.org&amp;#x2F;cargo&amp;#x2F;guide&amp;#x2F;&quot; target=&quot;_blank&quot;&gt;
        The Cargo Guide
    &lt;/a&gt;
&lt;/li&gt;



&lt;li class=&quot;pure-menu-item&quot;&gt;
    &lt;a class=&quot;pure-menu-link&quot; href=&quot;https:&amp;#x2F;&amp;#x2F;doc.rust-lang.org&amp;#x2F;nightly&amp;#x2F;clippy&quot; target=&quot;_blank&quot;&gt;
        Clippy Documentation
    &lt;/a&gt;
&lt;/li&gt;

                    &lt;/ul&gt;
                &lt;/li&gt;
            &lt;/ul&gt;
            
            &lt;div id=&quot;search-input-nav&quot;&gt;
                &lt;label for=&quot;nav-search&quot;&gt;
                    &lt;span class=&quot;fa-svg fa-svg-fw&quot; aria-hidden=&quot;true&quot;&gt;&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 512 512&quot;&gt;&lt;!--! Font Awesome Free 6.2.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2022 Fonticons, Inc. --&gt;&lt;path d=&quot;M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352c79.5 0 144-64.5 144-144s-64.5-144-144-144S64 128.5 64 208s64.5 144 144 144z&quot;/&gt;&lt;/svg&gt;&lt;/span&gt;
                &lt;/label&gt;



                &lt;input id=&quot;nav-search&quot; name=&quot;query&quot; type=&quot;text&quot; aria-label=&quot;Find crate by search query&quot; tabindex=&quot;-1&quot;
                    placeholder=&quot;Find crate&quot;&gt;
            &lt;/div&gt;
        &lt;/form&gt;
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
<div id="rustdoc_body_wrapper"
class="rustdoc mod crate container-rustdoc" tabindex="-1">
<script async src="/-/static/menu.js?0-6-0-7c63657e-2024-05-03"></script>
<script async src="/-/static/index.js?0-6-0-7c63657e-2024-05-03"></script>
<iframe src="/-/storage-change-detection.html" width="0" height="0" style="display: none">
</iframe>
<!--[if lte IE 11]><div class="warning">This old browser is unsupported and will most likely display funky things.</div><![endif]-->
<nav class="mobile-topbar">
<button class="sidebar-menu-toggle" title="show sidebar">
</button>
</nav>
<nav class="sidebar">
<div class="sidebar-crate">
<h2>
<a href="../spider/index.html">spider</a><span
class="version">1.94.5</span>
</h2>
</div>
<div class="sidebar-elems">
<ul class="block">
<li>
<a id="all-types" href="all.html">All Items</a>
</li>
</ul>
<section>
<ul class="block">
<li>
<a href="#reexports">Re-exports</a>
</li>
<li>
<a href="#modules">Modules</a>
</li>
<li>
<a href="#structs">Structs</a>
</li>
<li>
<a href="#types">Type Aliases</a>
</li>
</ul>
</section>
</div>
</nav>
<div class="sidebar-resizer">

</div>
<main>
<div class="width-limiter">
<rustdoc-search></rustdoc-search>
<section id="main-content" class="content">
<div class="main-heading">
<h1>
Crate
<a class="mod" href="#">spider</a><button id="copy-path" title="Copy item path to clipboard">Copy
item path</button>
</h1>
<span
class="out-of-band"><a class="src" href="../src/spider/lib.rs.html#1-211">source</a>
·
<button id="toggle-all-docs" title="collapse all docs">[<span>−</span>]</button></span>
</div>
<details class="toggle top-doc" open>
<summary class="hideme">
<span>Expand description</span>
</summary>
<div class="docblock">
<p>
Website crawling library that rapidly crawls all pages to gather links
via isolated contexts.
</p>
<p>
Spider is multi-threaded crawler that can be configured to scrape web
pages. It has the ability to gather millions of pages within seconds.
</p>
<h2 id="how-to-use-spider">
<a class="doc-anchor" href="#how-to-use-spider">§</a>How to use Spider
</h2>
<p>
There are a couple of ways to use Spider:
</p>
<ul>
<li>
<strong>Crawl</strong> starts crawling a web page and perform most work
in isolation.
<ul>
<li>
<a href="website/struct.Website.html#method.crawl"><code>crawl</code></a>
is used to crawl concurrently.
</li>
</ul>
</li>
<li>
<strong>Scrape</strong> Scrape the page and hold onto the HTML raw
string to parse.
<ul>
<li>
<a href="website/struct.Website.html#method.scrape"><code>scrape</code></a>
is used to gather the HTML.
</li>
</ul>
</li>
</ul>
<h2 id="examples">
<a class="doc-anchor" href="#examples">§</a>Examples
</h2>
<p>
A simple crawl to index a website:
</p>
<div class="example-wrap">
<pre class="rust rust-example-rendered"><code><span class="kw">use </span>spider::tokio;
<span class="kw">use </span>spider::website::Website;

<span class="attr">#[tokio::main]
</span><span class="kw">async fn </span>main() {
    <span class="kw">let </span><span class="kw-2">mut </span>website: Website = Website::new(<span class="string">"https://spider.cloud"</span>);

    website.crawl().<span class="kw">await</span>;

    <span class="kw">let </span>links = website.get_links();

    <span class="kw">for </span>link <span class="kw">in </span>links {
        <span class="macro">println!</span>(<span class="string">"- {:?}"</span>, link.as_ref());
    }
}</code></pre>
</div>
<p>
Subscribe to crawl events:
</p>
<div class="example-wrap">
<pre class="rust rust-example-rendered"><code><span class="kw">use </span>spider::tokio;
<span class="kw">use </span>spider::website::Website;
<span class="kw">use </span>tokio::io::AsyncWriteExt;

<span class="attr">#[tokio::main]
</span><span class="kw">async fn </span>main() {
    <span class="kw">let </span><span class="kw-2">mut </span>website: Website = Website::new(<span class="string">"https://spider.cloud"</span>);
    <span class="kw">let </span><span class="kw-2">mut </span>rx2 = website.subscribe(<span class="number">16</span>).unwrap();

    tokio::spawn(<span class="kw">async move </span>{
        <span class="kw">let </span><span class="kw-2">mut </span>stdout = tokio::io::stdout();

        <span class="kw">while let </span><span class="prelude-val">Ok</span>(res) = rx2.recv().<span class="kw">await </span>{
            <span class="kw">let _ </span>= stdout
                .write_all(<span class="macro">format!</span>(<span class="string">"- {}\n"</span>, res.get_url()).as_bytes())
                .<span class="kw">await</span>;
        }
    });

    website.crawl().<span class="kw">await</span>;
}</code></pre>
</div>
<h3 id="feature-flags">
<a class="doc-anchor" href="#feature-flags">§</a>Feature flags
</h3>
<ul>
<li>
<code>ua_generator</code>: Enables auto generating a random real
User-Agent.
</li>
<li>
<code>regex</code>: Enables blacklisting paths with regx
</li>
<li>
<code>jemalloc</code>: Enables the
<a href="https://github.com/jemalloc/jemalloc">jemalloc</a> memory
backend.
</li>
<li>
<code>decentralized</code>: Enables decentralized processing of IO,
requires the
<a href="https://docs.rs/crate/spider_worker/latest">spider_worker</a>
startup before crawls.
</li>
<li>
<code>sync</code>: Subscribe to changes for Page data processing async.
</li>
<li>
<code>budget</code>: Allows setting a crawl budget per path with depth.
</li>
<li>
<code>control</code>: Enables the ability to pause, start, and shutdown
crawls on demand.
</li>
<li>
<code>full_resources</code>: Enables gathering all content that relates
to the domain like css,jss, and etc.
</li>
<li>
<code>serde</code>: Enables serde serialization support.
</li>
<li>
<code>socks</code>: Enables socks5 proxy support.
</li>
<li>
<code>glob</code>: Enables
<a href="https://everything.curl.dev/cmdline/globbing">url glob</a>
support.
</li>
<li>
<code>fs</code>: Enables storing resources to disk for parsing (may
greatly increases performance at the cost of temp storage). Enabled by
default.
</li>
<li>
<code>sitemap</code>: Include sitemap pages in results.
</li>
<li>
<code>js</code>: Enables javascript parsing links created with the alpha
<a href="https://github.com/a11ywatch/jsdom">jsdom</a> crate.
</li>
<li>
<code>time</code>: Enables duration tracking per page.
</li>
<li>
<code>cache</code>: Enables HTTP caching request to disk.
</li>
<li>
<code>cache_mem</code>: Enables HTTP caching request to persist in
memory.
</li>
<li>
<code>cache_chrome_hybrid</code>: Enables hybrid chrome request caching
between HTTP.
</li>
<li>
<code>cache_openai</code>: Enables caching the OpenAI request. This can
drastically save costs when developing AI workflows.
</li>
<li>
<code>chrome</code>: Enables chrome headless rendering, use the env var
<code>CHROME_URL</code> to connect remotely.
</li>
<li>
<code>chrome_headed</code>: Enables chrome rendering headful rendering.
</li>
<li>
<code>chrome_cpu</code>: Disable gpu usage for chrome browser.
</li>
<li>
<code>chrome_stealth</code>: Enables stealth mode to make it harder to
be detected as a bot.
</li>
<li>
<code>chrome_store_page</code>: Store the page object to perform other
actions like taking screenshots conditionally.
</li>
<li>
<code>chrome_screenshot</code>: Enables storing a screenshot of each
page on crawl. Defaults the screenshots to the ./storage/ directory. Use
the env variable <code>SCREENSHOT_DIRECTORY</code> to adjust the
directory.
</li>
<li>
<code>chrome_intercept</code>: Allows intercepting network request to
speed up processing.
</li>
<li>
<code>chrome_headless_new</code>: Use headless=new to launch the chrome
instance.
</li>
<li>
<code>cookies</code>: Enables cookies storing and setting to use for
request.
</li>
<li>
<code>real_browser</code>: Enables the ability to bypass protected
pages.
</li>
<li>
<code>cron</code>: Enables the ability to start cron jobs for the
website.
</li>
<li>
<code>openai</code>: Enables OpenAI to generate dynamic browser
executable scripts. Make sure to use the env var
<code>OPENAI_API_KEY</code>.
</li>
<li>
<code>smart</code>: Enables smart mode. This runs request as HTTP until
JavaScript rendering is needed. This avoids sending multiple network
request by re-using the content.
</li>
<li>
<code>encoding</code>: Enables handling the content with different
encodings like Shift_JIS.
</li>
<li>
<code>spoof</code>: Spoof HTTP headers for the request.
</li>
<li>
<code>headers</code>: Enables the extraction of header information on
each retrieved page. Adds a <code>headers</code> field to the page
struct.
</li>
<li>
<code>decentralized_headers</code>: Enables the extraction of suppressed
header information of the decentralized processing of IO. This is needed
if <code>headers</code> is set in both
<a href="https://docs.rs/spider/latest/spider/">spider</a> and
<a href="https://docs.rs/crate/spider_worker/latest">spider_worker</a>.
</li>
</ul>
<p>
Additional learning resources include:
</p>
<ul>
<li>
<a href="https://github.com/spider-rs/spider/tree/main/examples">Spider
Repository Examples</a>
</li>
</ul>
</div>
</details>
<h2 id="reexports" class="section-header">
Re-exports<a href="#reexports" class="anchor">§</a>
</h2>
<ul class="item-table">
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/bytes/1.6.0/x86_64-unknown-linux-gnu/bytes/index.html" title="mod bytes">bytes</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/case_insensitive_string/0.2.3/x86_64-unknown-linux-gnu/case_insensitive_string/index.html" title="mod case_insensitive_string">case_insensitive_string</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/compact_str/0.7.1/x86_64-unknown-linux-gnu/compact_str/index.html" title="mod compact_str">compact_str</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/fast_html5ever/0.26.6/x86_64-unknown-linux-gnu/fast_html5ever/index.html" title="mod fast_html5ever">fast_html5ever</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/hashbrown/0.14.5/x86_64-unknown-linux-gnu/hashbrown/index.html" title="mod hashbrown">hashbrown</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/lazy_static/1.4.0/x86_64-unknown-linux-gnu/lazy_static/index.html" title="mod lazy_static">lazy_static</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/percent-encoding/2.3.1/x86_64-unknown-linux-gnu/percent_encoding/index.html" title="mod percent_encoding">percent_encoding</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/quick-xml/0.31.0/x86_64-unknown-linux-gnu/quick_xml/index.html" title="mod quick_xml">quick_xml</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/reqwest/0.12.4/x86_64-unknown-linux-gnu/reqwest/index.html" title="mod reqwest">reqwest</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/smallvec/1.13.2/x86_64-unknown-linux-gnu/smallvec/index.html" title="mod smallvec">smallvec</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/string_concat/0.0.1/x86_64-unknown-linux-gnu/string_concat/index.html" title="mod string_concat">string_concat</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/strum/0.26.2/x86_64-unknown-linux-gnu/strum/index.html" title="mod strum">strum</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/tokio/1.37.0/x86_64-unknown-linux-gnu/tokio/index.html" title="mod tokio">tokio</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/tokio-stream/0.1.15/x86_64-unknown-linux-gnu/tokio_stream/index.html" title="mod tokio_stream">tokio_stream</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/ua_generator/0.4.2/x86_64-unknown-linux-gnu/ua_generator/index.html" title="mod ua_generator">ua_generator</a>;</code>
</div>
</li>
<li>
<div class="item-name">
<code>pub extern crate
<a class="mod" href="https://docs.rs/url/2.5.0/x86_64-unknown-linux-gnu/url/index.html" title="mod url">url</a>;</code>
</div>
</li>
</ul>
<h2 id="modules" class="section-header">
Modules<a href="#modules" class="anchor">§</a>
</h2>
<ul class="item-table">
<li>
<div class="item-name">
<a class="mod" href="black_list/index.html" title="mod spider::black_list">black_list</a>
</div>
<div class="desc docblock-short">
Black list checking url exist.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="configuration/index.html" title="mod spider::configuration">configuration</a>
</div>
<div class="desc docblock-short">
Configuration structure for <code>Website</code>.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="features/index.html" title="mod spider::features">features</a>
</div>
<div class="desc docblock-short">
Optional features to use.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="packages/index.html" title="mod spider::packages">packages</a>
</div>
<div class="desc docblock-short">
Internal packages customized.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="page/index.html" title="mod spider::page">page</a>
</div>
<div class="desc docblock-short">
A page scraped.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="utils/index.html" title="mod spider::utils">utils</a>
</div>
<div class="desc docblock-short">
Application utils.
</div>
</li>
<li>
<div class="item-name">
<a class="mod" href="website/index.html" title="mod spider::website">website</a>
</div>
<div class="desc docblock-short">
A website to crawl.
</div>
</li>
</ul>
<h2 id="structs" class="section-header">
Structs<a href="#structs" class="anchor">§</a>
</h2>
<ul class="item-table">
<li>
<div class="item-name">
<a class="struct" href="struct.CaseInsensitiveString.html" title="struct spider::CaseInsensitiveString">CaseInsensitiveString</a>
</div>
<div class="desc docblock-short">
case-insensitive string handling
</div>
</li>
</ul>
<h2 id="types" class="section-header">
Type Aliases<a href="#types" class="anchor">§</a>
</h2>
<ul class="item-table">
<li>
<div class="item-name">
<a class="type" href="type.Client.html" title="type spider::Client">Client</a>
</div>
<div class="desc docblock-short">
The asynchronous Client to make requests with.
</div>
</li>
<li>
<div class="item-name">
<a class="type" href="type.ClientBuilder.html" title="type spider::ClientBuilder">ClientBuilder</a>
</div>
<div class="desc docblock-short">
The asynchronous Client Builder.
</div>
</li>
</ul>
</section>
</div>
</main>
</div>
</body>
</html>
</div>

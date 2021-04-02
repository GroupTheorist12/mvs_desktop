// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// No Node.js APIs are available in this process because
// `nodeIntegration` is turned off. Use `preload.js` to
// selectively enab

var CurrentNewsIndex = 1;

function includeJs(jsFilePath) {
    var js = document.createElement("script");

    js.type = "text/javascript";
    js.src = jsFilePath;

    document.body.appendChild(js);
}

includeJs('js/charms.js');
includeJs('js/mwindow.js');
includeJs('js/submitjclwindow.js');
includeJs('js/spoolwindow.js');
includeJs('js/herculesconsolewindow.js');
includeJs('js/desktop.js');


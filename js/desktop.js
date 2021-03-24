
var CurrentNewsIndex = 1;

class DesktopM {
    constructor() {
        this.options =
        {
            windowArea: ".window-area",
            windowAreaClass: "",
            taskBar: ".task-bar > .tasks",
            taskBarClass: ""
        };

        this.wins =  {};

    }

    setup(options) {
        this.options = $.extend({}, this.options, options);
        return this;
    }

    addToTaskBar(wnd) {
        var icon = wnd.getIcon();
        var wID = wnd.win.attr("id");
        var item = $("<span>").addClass("task-bar-item started").html(icon);

        item.data("wID", wID);

        item.appendTo($(this.options.taskBar));

    }

    removeFromTaskBar(wnd) {
        var wID = wnd.attr("id");
        var items = $(".task-bar-item");
        var that = this;
        $.each(items, function () {
            var item = $(this);
            if (item.data("wID") === wID) {
                delete that.wins[wID];
                item.remove();
            }
        })

    }

    createWindow(o) {
        o.onDragStart = function () {
            win = $(this);
            $(".window").css("z-index", 1);

            if (!win.hasClass("modal")) {
                win.css("z-index", 3);
            }
        };
        o.onDragStop = function () {
            win = $(this);
            if (!win.hasClass("modal"))
                win.css("z-index", 2);
        };
        o.onWindowDestroy = function (win) {
            Desktop.removeFromTaskBar($(win));
        };

        var w = $("<div>").appendTo($(this.options.windowArea));
        var wnd = w.window(o).data("window");

        var win = wnd.win;
        var shift = Metro.utils.objectLength(this.wins) * 16;

        if (wnd.options.place === "auto" && wnd.options.top === "auto" && wnd.options.left === "auto") {
            win.css({
                top: shift,
                left: shift
            });
        }
        this.wins[win.attr("id")] = wnd;
        this.addToTaskBar(wnd);

        return wnd;

    }
}

var Desktop = new DesktopM();
Desktop.setup();


function createWindowModal() {
    Desktop.createWindow({
        resizeable: false,
        draggable: true,
        width: 300,
        icon: "<span class='mif-cogs'></span>",
        title: "Modal window",
        content: "<div class='p-2'>This is desktop demo created with Metro 4 Components Library</div>",
        overlay: true,
        //overlayColor: "transparent",
        modal: true,
        place: "center",
        onShow: function (win) {
            win = $(win);
            win.addClass("ani-swoopInTop");
            setTimeout(function () {
                $(win).removeClass("ani-swoopInTop");
            }, 1000);
        },
        onClose: function (win) {
            win = $(win);
            win.addClass("ani-swoopOutTop");
        }
    });
}


function createWindowYoutube() {
    Desktop.createWindow({
        resizeable: true,
        draggable: true,
        width: 800,
        height: 800,
        icon: "<span class='mif-document-file-pdf'></span>",
        title: "Job PDF Output",
        content: "<iframe src='txt_stuff.html' width='100%' height='1200px' id='frmCurrentPdf'/>",//"https://youtu.be/Qz6XNSB0F3E",
        clsContent: "bg-dark"
    });

    setTimeout(function () {
        //w.setContent("New window content");
        //$("#frmCurrentPdf").src = 'http://192.168.1.137:8038/current.pdf';
        var index = $.random(1700, 3270);
        document.getElementById('frmCurrentPdf').src = 'http://192.168.1.137:8038/current.pdf?id=' + index;
    }, 3000);

}

function createWindowConsole() {
    Desktop.createWindow({
        resizeable: true,
        draggable: true,
        width: 600,
        height: 600,
        icon: "<span class='mif-display'></span>",
        title: "Hercules Console",
        content: "<iframe src='txt_stuff.html' width='100%' height='1200px' id='frmConsole'/>",//"https://youtu.be/Qz6XNSB0F3E",
        clsContent: "bg-white"
    });

    setTimeout(function () {
        //w.setContent("New window content");
        //$("#frmCurrentPdf").src = 'http://192.168.1.137:8038/current.pdf';
        var index = $.random(1700, 3270);
        document.getElementById('frmConsole').src = 'http://192.168.1.137:8038/cgi-bin/tasks/syslog?id=' + index;
    }, 3000);

}

function createWindowSubmitCobol() {
    var index = $.random(0, 3);
    var customButtons = [
        {
            html: "<span class='mif-upload' title='Submit Jcl'></span>",
            cls: "secondary",
            onclick: "SubmitJcl()"
        },
        {
            html: "<span class='mif-file-upload' title='Load Jcl'></span>",
            cls: "secondary",
            onclick: "LoadJcl()"
        }
    ];
    Desktop.createWindow({
        resizeable: true,
        draggable: true,
        customButtons: customButtons,
        width: 360,
        icon: "<span class='mif-upload'></span>",
        title: 'Submit Jcl',
        content: "<div class='p-2'>" +
            "<textarea id='txt-jcl' cols='80' rows='20' style='font-size:10pt;'></textarea>" +
            "</div>"
    });
}

function openCharm() {
    var charm = $("#charm").data("charms");
    charm.toggle();
}

$(".window-area").on("click", function () {
    Metro.charms.close("#charm");
});

$(".charm-tile").on("click", function () {
    $(this).toggleClass("active");
});

window.api.receive("fromMain", (data) => {
    //console.log(`Received ${data} from main process`);
    const txtJCL = document.querySelector('#txt-jcl');

    txtJCL.value = data;
});

function SetCharmMessage(message) {
    if (CurrentNewsIndex > 4) {
        CurrentNewsIndex = 1;
    }
    var charmI = document.querySelector('#divNewsContent' + CurrentNewsIndex);
    var divCharm = document.querySelector('#divCharm' + CurrentNewsIndex);
    var charmD = document.querySelector('#divNewsSecond' + CurrentNewsIndex);
    divCharm.style.display = 'block';

    charmI.innerHTML = message;
    charmD.innerHTML = new Date();
    CurrentNewsIndex++;

}
function CreateNotify(message) {
    var notify = Metro.notify;

    SetCharmMessage(message);

    notify.create(message, "Alert", {
        cls: "default"
    });
}

$("#spnClearNotifies").on("click", function () {
    ClearNotifies();
});

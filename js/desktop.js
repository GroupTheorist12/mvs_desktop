class DesktopM {
    constructor() {
        this.options =
        {
            windowArea: ".window-area",
            windowAreaClass: "",
            taskBar: ".task-bar > .tasks",
            taskBarClass: ""
        };

        this.memberConfig = null;
        this.wins =  {};

    }

    get Config()    {
        return this.memberConfig;
    }

    set Config(v) {
        this.memberConfig = v;
    }

    setup(options) {
        this.options = $.extend({}, this.options, options);
        window.api.send("toMainConfig", "");
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

window.api.receive("fromMainConfig", (config) => {
    Desktop.Config = config;
});


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

$("#spnClearNotifies").on("click", function () {
    ClearNotifies();
});

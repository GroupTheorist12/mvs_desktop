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
        this.memberPds = null;
        this.wins =  {};

    }

    get Config()    {
        return this.memberConfig;
    }

    set Config(v) {
        this.memberConfig = v;
    }

    get Pds()    {
        return this.memberPds;
    }

    set Pds(v) {
        this.memberPds = v;
    }

    setup(options) {
        this.options = $.extend({}, this.options, options);
        window.api.send("toMainConfig", "");
        window.api.send("toMainCatalogs", "");

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


window.api.receive("fromMainCatalogs", (pds) => {
    Desktop.Pds = pds;
});

$(".window-area").on("click", function () {
    Metro.charms.close("#charm");
});

$(".charm-tile").on("click", function () {
    $(this).toggleClass("active");
});

$("#spnClearNotifies").on("click", function () {
    ClearNotifies();
});

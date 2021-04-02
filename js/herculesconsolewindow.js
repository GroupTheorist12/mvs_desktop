class HerculesConsoleWindow extends MWindow {
    constructor() {
        super();

        this.width = 600;
        this.height = 600;
        this.icon = "<span class='mif-display'></span>";
        this.title = "Hercules Console";
        this.content = "<iframe src='txt_stuff.html' width='100%' height='1200px' id='frmConsole'/>";

    }

    showWindow() {
        super.showWindow();
        setTimeout(function () {
            var index = $.random(1700, 3270);
            document.getElementById('frmConsole').src = Desktop.Config.mvshttp+ '/cgi-bin/tasks/syslog?id=' + index;
        }, 3000);
    
    }

}

var HercWin = new HerculesConsoleWindow();
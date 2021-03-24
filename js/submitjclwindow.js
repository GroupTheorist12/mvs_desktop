class SubmitJclWindow extends MWindow
{
    constructor() {
        super();
        this.customButtons = [
            {
                html: "<span class='mif-upload' title='Submit Jcl'></span>",
                cls: "secondary",
                onclick: "SubmitJclWindow.SubmitJcl()"
            },
            {
                html: "<span class='mif-file-upload' title='Load Jcl'></span>",
                cls: "secondary",
                onclick: "SubmitJclWindow.LoadJcl()"
            }
        ];

        this.content = "<div class='p-2'>" +
        "<textarea id='txt-jcl' cols='80' rows='20' style='font-size:10pt;'></textarea>" +
        "</div>";

        this.title =  'Submit Jcl';
        this.width = 420;
        this.height = 440;

    }

    static LoadJcl() {
        window.api.send("toMain", "dummy");
    }

    static SubmitJcl() {
        const txtJCL = document.querySelector('#txt-jcl');
    
        var msg = "Job " + txtJCL.value.substring(2, 8) + " was submitted.";
        CreateNotify(msg);
        window.api.send("runJcl", txtJCL.value);
    
        setTimeout(function () {
            var index = $.random(1700, 3270);
            document.getElementById('frmCurrentPdf').src = 'http://192.168.1.137:8038/current.pdf?id=' + index;
            index = $.random(3271, 6218);
            document.getElementById('frmConsole').src = 'http://192.168.1.137:8038/cgi-bin/tasks/syslog?id=' + index;
        }, 3000);
    
    }
    
}


var JclWin = new SubmitJclWindow();


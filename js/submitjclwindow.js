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

        this.icon = "<span class='mif-upload'></span>";
        this.content = "<div class='p-2'>" +
        "<textarea id='txt-jcl' cols='80' rows='20' style='font-size:10pt;'></textarea>" +
        "</div>";

        this.title =  'Submit Jcl';
        this.width = 540;
        this.height = 420;

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
            document.getElementById('frmCurrentPdf').src = Desktop.Config.mvshttp + '/current.pdf?id=' + index;
            index = $.random(3271, 6218);
            document.getElementById('frmConsole').src = Desktop.Config.mvshttp + '/cgi-bin/tasks/syslog?id=' + index;
            //window.api.send("toMainPDF", "");
        }, 3000);
    
    }
    
}


var JclWin = new SubmitJclWindow();

window.api.receive("fromMain", (data) => {
    const txtJCL = document.querySelector('#txt-jcl');

    txtJCL.value = data;
});



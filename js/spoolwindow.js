class SpoolWindow extends MWindow {
    constructor() {
        super();

        this.customButtons = [
            {
                html: "<span class='mif-next' title='Next PDF'></span>",
                cls: "secondary",
                onclick: "SpoolWindow.GePdfHistoryUp()"
            },
            {
                html: "<span class='mif-previous' title='Prev PDF'></span>",
                cls: "secondary",
                onclick: "SpoolWindow.GePdfHistoryDown()"
            },
            {
                html: "<span class='mif-history' title='PDF History'></span>",
                cls: "secondary",
                onclick: "SpoolWindow.GePdfHistory()"
            }
        ];

        this.width = 800;
        this.height = 800;
        this.icon = "<span class='mif-document-file-pdf'></span>";
        this.title = "Job PDF Output";
        this.content = "<iframe src='txt_stuff.html' width='100%' height='1200px' id='frmCurrentPdf'/>";
        this.clsContent = "bg-dark";

    }


    static memberPDFIndex = 0;
    static memberPdfList = [];

    static set PdfList(v) {
        this.memberPdfList = v;
    }

    static get PdfList() {
        return this.memberPdfList;
    }

    static set PDFIndex(v) {
        this.memberPDFIndex = v;
    }

    static get PDFIndex() {
        return this.memberPDFIndex;
    }

    static GePdfHistory() {
        this.PDFIndex = 0;
        window.api.send("toMainPDF", this.PDFIndex);
    }

    static GePdfHistoryUp() {
        this.PDFIndex +=1; 
        if(this.PDFIndex > this.PdfList.length - 2)    
        {
            this.PDFIndex = this.PdfList.length - 2
        }

        var fil = "";
        fil = SpoolWindow.PdfList[SpoolWindow.PDFIndex];
        document.getElementById('frmCurrentPdf').src = Desktop.Config.mvshttp + '/pdf/' + fil;
    
    }

    static GePdfHistoryDown() {
        this.PDFIndex -=1;

        if(this.PDFIndex < 0)
        {
            this.PDFIndex = 0;
        }

        var fil = "";
        fil = SpoolWindow.PdfList[SpoolWindow.PDFIndex];
        document.getElementById('frmCurrentPdf').src = Desktop.Config.mvshttp + '/pdf/' + fil;
    }


    showWindow() {
        super.showWindow();
        setTimeout(function () {
            var index = $.random(1700, 3270);
            document.getElementById('frmCurrentPdf').src = Desktop.Config.mvshttp + '/current.pdf?id=' + index;
        }, 3000);

    }
}


var SpoolWin = new SpoolWindow();

window.api.receive("fromMainPDF", (lines) => {
    SpoolWindow.PdfList = lines;
    SpoolWindow.PDFIndex = 0;

    var fil = "";
    // print all lines
    fil = SpoolWindow.PdfList[SpoolWindow.PDFIndex];
    document.getElementById('frmCurrentPdf').src = Desktop.Config.mvshttp + '/pdf/' + fil;
});

class FileManagerWindow extends MWindow {
    constructor() {
        super();

        this.width = 600;
        this.height = 600;
        this.icon = "<span class='mif-cog'></span>";
        this.title = "Configuration Settings";
        this.content = `
        <div class='p-2'>
        </div>        
        `;
        this.clsContent = "bg-white";

    }

    showWindow() {
        var cnt = `
        <div class='p-2'>
        <ul data-role="listview">
            <li data-caption="HERC01 Folders">
                <ul id="ulList">
                {{REPLACE_ME_WITH_LI}}
                </ul>
            </li>
        </ul>
    </div>
        `;

        var li = "<li data-icon=\"<span class='mif-folder fg-brown'>\" data-caption='{{REPLACE_ME_WITH_PDS}}'></li>";
        var str = "";
        Desktop.Pds.forEach((val) => {
            str += li.replace("{{REPLACE_ME_WITH_PDS}}", val);
        });

        this.content = cnt.replace("{{REPLACE_ME_WITH_LI}}", str);
        super.showWindow();
    }

    static UpdateFileManager()
    {
    
    }

}

var FileManagerWin = new FileManagerWindow();

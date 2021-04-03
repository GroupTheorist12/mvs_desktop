class ConfigWindow extends MWindow {
    constructor() {
        super();

        this.width = 800;
        this.height = 800;
        this.icon = "<span class='mif-cog'></span>";
        this.title = "Configuration Settings";
        this.content = `
        <div class='p-2'>
        <form>
            <div class="row mb-2">
                <label class="cell-sm-2">MVS IP Address</label>
                <div class="cell-sm-10">
                    <input type="text" class="metro-input" value="127.0.0.1" id="txtMVSIP"/>
                </div>
            </div>
            <div class="row mb-2">
                <label class="cell-sm-2">MVS Http Address</label>
                <div class="cell-sm-10">
                    <input type="text" class="metro-input" value="http://127.0.0.1:8038" id="txtMVSHttp"/>
                </div>
            </div>
            <div class="row mb-2">
                <label class="cell-sm-2">Reader Port</label>
                <div class="cell-sm-10">
                    <input type="number" class="metro-input" value="3505" id="txtRdrPort">
                </div>
            </div>
            <div class="row">
                <div class="cell">
                    <button type="submit" class="button primary">Submit</button>
                </div>
            </div>
        </form>
        </div>        
        `;
        this.clsContent = "bg-white";

    }

    showWindow() {
        super.showWindow();
        var txtMVSIP = document.querySelector('#txtMVSIP');
        txtMVSIP.value = Desktop.Config.mvsIP;

        var txtMVSHttp = document.querySelector('#txtMVSHttp');
        txtMVSHttp.value = Desktop.Config.mvshttp;
        var txtRdrPort = document.querySelector('#txtRdrPort');
        txtRdrPort.value =  Desktop.Config.rdrport;
    }

}

var ConfigWin = new ConfigWindow();
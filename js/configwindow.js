class ConfigWindow extends MWindow {
    constructor() {
        super();

        this.width = 600;
        this.height = 600;
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
                    <button type="button" class="button primary" id="btnConfigSubmit" onclick="ConfigWindow.UpdateConfig()">Submit</button>
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

    static UpdateConfig()
    {
        var txtMVSIP = document.querySelector('#txtMVSIP');
        Desktop.Config.mvsIP = txtMVSIP.value;
    
        var txtMVSHttp = document.querySelector('#txtMVSHttp');
        Desktop.Config.mvshttp = txtMVSHttp.value;
        var txtRdrPort = document.querySelector('#txtRdrPort');
        Desktop.Config.rdrport = txtRdrPort.value;
    
        var msg = "Config changes saved.";
        CreateNotify(msg);
    
        window.api.send("toMainUpdateConfig", Desktop.Config);
    
    }

}

var ConfigWin = new ConfigWindow();

/*
$("#btnConfigSubmit").on("click", function () {
    var txtMVSIP = document.querySelector('#txtMVSIP');
    Desktop.Config.mvsIP = txtMVSIP.value;

    var txtMVSHttp = document.querySelector('#txtMVSHttp');
    Desktop.Config.mvshttp = txtMVSHttp.value;
    var txtRdrPort = document.querySelector('#txtRdrPort');
    Desktop.Config.rdrport = txtRdrPort.value;

    var msg = "Config changes saved.";
    CreateNotify(msg);

    window.api.send("toMainUpdateConfig", Desktop.Config);

});
*/
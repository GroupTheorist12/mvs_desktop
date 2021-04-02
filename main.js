// Modules to control application life and create native browser window
const {
  app,
  BrowserWindow,
  ipcMain,
  dialog
} = require("electron");
const path = require("path");
const fs = require("fs");
var Client = require('ftp');
var net = require('net');
const http = require('http');

let mainWindow;


function createWindow() {
  // Create the browser window.
  mainWindow = new BrowserWindow({
    //width: 800,
    //height: 600,
    show: false,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  })

  // and load the index.html of the app.
  mainWindow.loadFile('index.html')
  mainWindow.maximize()
  mainWindow.show()

  // Open the DevTools.
  // mainWindow.webContents.openDevTools()
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.whenReady().then(() => {
  createWindow()

  app.on('activate', function () {
    // On macOS it's common to re-create a window in the app when the
    // dock icon is clicked and there are no other windows open.
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
    //BrowserWindow.maximize()

  })
})

// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.

ipcMain.on("toMain", (event, args) => {
  // Send result back to renderer process
  //win.webContents.send("fromMain", args);
  //getFileFromUser();

  dialog.showOpenDialog(mainWindow)
    .then(result => {
      if (result.canceled) return;
      var files = result.filePaths;
      //  process
      //var fil = path.basename(files[0]);
      const content = fs.readFileSync(files[0]).toString();
      mainWindow.webContents.send("fromMain", content);
      //submitJob(files[0]);
    });

});

ipcMain.on("runJcl", (event, args) => {

  fs.writeFileSync(path.join(__dirname, "tmp.jcl"), args);
  /*
  submitJob('tmp.jcl');
  */

  var client = new net.Socket();
  client.connect(Desktop.Config.rdrport, Desktop.Config.mvsIP, function () {
    //console.log('Connected');
    const content = fs.readFileSync('tmp.jcl').toString();
    client.write(content, 'ascii');
    client.destroy();
  });

});

ipcMain.on("toMainPDF", (event, args) => {
  GetPdfs(args);
});

ipcMain.on("toMainConfig", (event, args) => {

  let rawdata = fs.readFileSync('config.json');
  let configData = JSON.parse(rawdata);

  mainWindow.webContents.send("fromMainConfig", configData);
});

function GetPdfs(args) {


  let request = http.get('http://192.168.1.137:8038/pdf/pdfs.txt', (res) => {
    if (res.statusCode !== 200) {
      console.error(`Did not get an OK from the server. Code: ${res.statusCode}`);
      res.resume();
      return;
    }

    let data = '';
    res.on('data', (chunk) => {
      data += chunk;
    });

    res.on('close', () => {
      //console.log('Retrieved all data');
      //console.log(data);
      //fs.writeFileSync(path.join(__dirname, "pdfs.txt"), data);

      var lines = data.split(/\r?\n/);
      var arr = [];

      lines.forEach((line) => {
        //console.log(line);
        arr[arr.length] = line;
      });

      mainWindow.webContents.send("fromMainPDF", arr);

    });


  });
}
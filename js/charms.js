function openCharm() {
    var charm = $("#charm").data("charms");
    charm.toggle();
}

function ClearNotifies () {
    for(var i = 0; i < 4; i++)
    {
        var currentCharn = document.querySelector('#divCharm' + (i + 1));
        currentCharn.style.display = 'none';
    }

    CurrentNewsIndex = 1;
}

function CreateNotify(message) {
    var notify = Metro.notify;

    SetCharmMessage(message);

    notify.create(message, "Alert", {
        cls: "default"
    });
}

function SetCharmMessage(message) {
    if (CurrentNewsIndex > 4) {
        CurrentNewsIndex = 1;
    }
    var charmI = document.querySelector('#divNewsContent' + CurrentNewsIndex);
    var divCharm = document.querySelector('#divCharm' + CurrentNewsIndex);
    var charmD = document.querySelector('#divNewsSecond' + CurrentNewsIndex);
    divCharm.style.display = 'block';

    charmI.innerHTML = message;
    charmD.innerHTML = new Date();
    CurrentNewsIndex++;

}

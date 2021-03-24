function ClearNotifies () {
    for(var i = 0; i < 4; i++)
    {
        var currentCharn = document.querySelector('#divCharm' + (i + 1));
        currentCharn.style.display = 'none';
    }

    CurrentNewsIndex = 1;
}

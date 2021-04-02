class MWindow {

    constructor() {
        this.winny = null;
        this.memberTitle = 'Window';
        this.memberCustomButtons = {};
        this.memberIcon = "<span class='mif-cog'></span>";
        this.memberWidth = 300;
        this.memberHeight = 300;
        this.memberWindowObject = null;
        this.memberContent = "<div class='p-2'></div>"
        this.memberClsContent = "bg-white";
    }


    get clsContent() {
        return this.memberClsContent;
    }

    set clsContent(val) {
        this.memberClsContent = val;
    }

    get title() {
        return this.memberTitle;
    }

    set title(val) {
        this.memberTitle = val;
    }

    set customButtons(val) {
        this.memberCustomButtons = val;
    }

    get icon() {

        return this.memberIcon;
    }

    set icon(val) {
        this.memberIcon = val;
    }

    get width() {

        return this.memberWidth;
    }

    set width(val) {
        this.memberWidth = val;
    }

    get height() {

        return this.memberHeight;
    }

    set height(val) {
        this.memberHeight = val;
    }

    get content() {

        return this.memberContent;
    }

    set content(val) {
        this.memberContent = val;
    }

    showWindow() {
        /*
        this.memberWindowObject = Metro.window.create(
            {
                width: this.memberWidth, //420
                height: this.memberHeight, //440
                customButtons: this.memberCustomButtons,
                icon: this.memberIcon,
                title: this.memberTitle,
                content: this.memberContent

            });

        */

            this.memberWindowObject = Desktop.createWindow(
            {
                width: this.memberWidth, //420
                height: this.memberHeight, //440
                customButtons: this.memberCustomButtons,
                icon: this.memberIcon,
                title: this.memberTitle,
                content: this.memberContent

            });


    }
}


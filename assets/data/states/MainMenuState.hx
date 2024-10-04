function postCreate() {
    forceCenterX = false; // disable the code that centers the menu buttons.
    for (i=>button in menuItems.members) {
        button.x += Math.sin(i) * 300;
    }
}
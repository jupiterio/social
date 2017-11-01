package entities;

import mint.Window;

typedef ContentWindowOptions = WindowOptions;

class ContentWindow extends Window {

    override public function new(options : ContentWindowOptions) {
        options.y = 10;
        options.x += 10;
        options.w = Luxe.screen.w - options.x - 10; // the content window is always going to be to the right of the bubble menu,
        // so, the game width minus the x and a 20px margin (10px, top and bottom)
        options.h = Luxe.screen.h - 20; // game height minus 20px margin (10px, top and bottom)
        
        // Self-explanatory
        options.resizable = false;
        options.moveable = false;
        options.key_input = true;
        options.mouse_input = true;
        options.collapsible = false;
        options.closable = false;
        
        super(options);
        
        
    }

}

package entities;

import mint.Control;
import mint.Image;

import luxe.tween.Actuate;

typedef BubbleOptions = {
    > ImageOptions,
    
    ?path: String,
    
    icon: String, // icon for the bubble
    onclicked: MouseSignal, // do i have to explain this
    zooming: Float // how much the bubble grows when it's hovered
};

class Bubble extends Image {
    
    public static var BUBBLE_SIZE = 48;
    public static var ICON_SIZE = BUBBLE_SIZE*1/2;
    
    var onclicked : MouseSignal; // see above :-)
    var zooming : Float;
    var iconPath : String;
    var icon : Image;
    
    override public function new(options : BubbleOptions) {
        // default properties
        options.path = "assets/ui/bubble.png";
        options.w = options.h = BUBBLE_SIZE;
        options.options = { color: new luxe.Color(1,1,1,0.85) };
        
        super(options);
        
        // why do you have to specify whether you want mouse input or not
        mouse_input = true;
        // putting 'em options on the object's properties
        onclicked = options.onclicked;
        zooming = options.zooming;
        iconPath = options.icon;
        
        var originalx = x; // so, the x and y are not relative to the parent
        var originaly = y; // (in this case, and the only case, the bubble menu)
        
        // the icon
        icon = new Image({
            parent: this,
            path: iconPath,
            w: ICON_SIZE, h: ICON_SIZE,
            x: (BUBBLE_SIZE - ICON_SIZE)/2, y: (BUBBLE_SIZE - ICON_SIZE)/2 // center it
        });
        
        // the dang luxe.Visual is not exposed to the user, what?
        var visual = (cast (renderer, mint.render.luxe.Image)).visual;
        var pressed = false; // pressed?
        
        onmousedown.listen(function(_,_) { // mouse down
            visual.color.tween(0.2,{a:1}); // make it opaque
            pressed = true;
        });
        
        onmouseup.listen(function(a,b) { // mouse up
            if (pressed) { // only if it was mouse down'd before, we don't want any annoying mouse things
                visual.color.tween(0.2,{a:0.85}); // make it transparent again
                onclicked(a,b);
                pressed = false; // no longer pressed 'aight
            }
        });
        
        onmouseenter.listen(function(_,_) { // mouse enter
            // thanks Luxe for providing a generic tweening function :)
            Actuate.tween(this, 0.1, {
                w: BUBBLE_SIZE + zooming, // make it bigger!
                h: BUBBLE_SIZE + zooming, // BIGGER I SAID
                x: originalx - zooming/2, // this makes it so it looks like it grows from the center
                y: originaly - zooming/2
            }, true);
            
            Actuate.tween(icon, 0.1, { // tween the icon
                w: ICON_SIZE + zooming,
                h: ICON_SIZE + zooming,
            }, true);
        });
        
        onmouseleave.listen(function(_,_) { // mouse leave
            if (pressed) { // Only if it was pressed! We don't want to tween when it isn't necessary
                visual.color.tween(0.2,{a:0.85});
                pressed = false;
            }
            // The mouse ain't gonna leave this image if it hasn't entered (and been tweened bigger) before,
            // so tween that thing back!
            Actuate.tween(this, 0.1, {
                w: BUBBLE_SIZE,
                h: BUBBLE_SIZE,
                x: originalx,
                y: originaly
            }, true);
            
            Actuate.tween(icon, 0.1, { // tween the icon
                w: ICON_SIZE,
                h: ICON_SIZE,
            }, true);
        });
    }
    
}

package entities;

import mint.Control;
import mint.Image;

import luxe.tween.Actuate;

typedef BubbleOptions = {
    > ImageOptions,
    
    ?path: String,
    
    ?icon: phoenix.Texture, // TODO: implement icons for the bubbles and remove the ?
    onclicked: MouseSignal, // do i have to explain this
    zooming: Float // how much the bubble grows when it's hovered
};

class Bubble extends Image {
    
    public static var BUBBLE_SIZE = 48;
    
    var onclicked : MouseSignal;
    var zooming : Float; // see above :-)
    
    override public function new(options : BubbleOptions) {
        // default properties
        options.path = "assets/ui/bubble.png";
        options.w = options.h = 48;
        options.options = { color: new luxe.Color(1,1,1,0.85) };
        
        super(options);
        
        // why do you have to specify whether you want mouse input or not
        mouse_input = true;
        // putting 'em options on the object's properties
        onclicked = options.onclicked;
        zooming = options.zooming;
        
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
        
        var originalx = x; // so, the x and y are not actually relative to the parent
        var originaly = y; // (in this case, and the only case, the bubble menu)
        
        onmouseenter.listen(function(_,_) { // mouse enter
            // thanks Luxe for providing a generic tweening function :)
            Actuate.tween(this, 0.1, {
                w: BUBBLE_SIZE + zooming, // make it bigger!
                h: BUBBLE_SIZE + zooming, // BIGGER I SAID
                x: originalx - zooming/2, // this makes it so it looks like it grows from the center
                y: originaly - zooming/2
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
        });
    }
    
}

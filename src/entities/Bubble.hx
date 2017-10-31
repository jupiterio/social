package entities;

import mint.Control;
import mint.Image;

typedef BubbleOptions = {
    > ImageOptions,
    
    ?path: String,
    
    ?icon: phoenix.Texture,
    onclicked: MouseSignal,
};

class Bubble extends Image {
    
    var onclicked : MouseSignal;
    
    override public function new(options : BubbleOptions) {
        options.path = "assets/ui/bubble.png";
        options.w = options.h = 48;
        options.options = { color: new luxe.Color(1,1,1,0.85) };
        
        super(options);
        
        mouse_input = true;
        onclicked = options.onclicked;
        
        var visual = (cast (renderer, mint.render.luxe.Image)).visual;
        var pressed = false;
        
        onmousedown.listen(function(_,_) {
            visual.color.tween(0.2,{a:1});
            pressed = true;
        });
        
        onmouseup.listen(function(a,b) {
            if (pressed) {
                visual.color.tween(0.2,{a:0.85});
                onclicked(a,b);
                pressed = false;
            }
        });
        
        var originalx = x;
        var originaly = y;
        
        onmouseenter.listen(function(_,_) {
            luxe.tween.Actuate.tween(this, 0.1, {w: 58, h:58, x: originalx - 5, y: originaly - 5}, true);
        });
        
        onmouseleave.listen(function(_,_) {
            if (pressed) {
                visual.color.tween(0.2,{a:0.85});
                pressed = false;
            }
            luxe.tween.Actuate.tween(this, 0.1, {w: 48, h:48, x: originalx, y: originaly}, true);
        });
    }
    
}

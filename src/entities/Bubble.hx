package entities;

import luxe.Input;

import luxe.Vector;
import luxe.Color;

import luxe.Sprite;

typedef BubbleOptions = {
    icon: phoenix.Texture,
    clicked: MouseEvent -> Void
};

class Bubble extends Sprite {
    
    var onclicked : MouseEvent -> Void;
    var pressed : Bool;
    
    override function init() {
        texture = Luxe.resources.texture("assets/ui/bubble.png");
        size = new Vector(48, 48);
        color = new Color(1, 1, 1, 0.75);
    }
    
    public function startup(options:BubbleOptions) {
        onclicked = options.clicked;
    }
    
    override function update(dt:Float) {
        
    }
    
    override function onmousemove(event:MouseEvent) {
        var difference = Vector.Subtract(pos, event.pos);
        var distance = Math.sqrt(difference.x*difference.x + difference.y*difference.y);
        
        size.x = size.y = 48 + Math.max(10 - distance/4, 0);
    }
    
    override function onmousedown(event:MouseEvent) {
        var difference = Vector.Subtract(pos, event.pos);
        var distance = Math.sqrt(difference.x*difference.x + difference.y*difference.y);
        
        if (distance < 20) {
            pressed = true;
            color.tween(0.2, {a: 1});
        }
    }
    
    override function onmouseup(event:MouseEvent) {
        if (pressed) {
            onclicked(event);
            color.tween(0.2, {a: 0.75});
            pressed = false;
        }
    }
    
}

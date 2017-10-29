package entities;

import luxe.Entity;
import luxe.Input;

import entities.Bubble;

typedef BubbleMenuOptions = {
    name: String,
    icon: phoenix.Texture,
    clicked: MouseEvent -> Void
};

class BubbleMenu extends Entity {
    
    public var bubbles : Array<Bubble>;
    
    override function init() { }
    
    public function startup(bubblesOp : Array<BubbleMenuOptions>) {
        bubbles = [];
        for (bubbleOp in bubblesOp) {
            var bubble = new Bubble({
                name: bubbleOp.name,
                pos: new luxe.Vector(pos.x, pos.y + (60 * bubbles.length))
            });
            
            bubble.startup(bubbleOp);
            
            bubbles.push(bubble);
        }
    }

    override function update(dt:Float) {
        
    }

}

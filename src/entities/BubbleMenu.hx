package entities;

import entities.Bubble;
import mint.Panel;

typedef BubbleMenuOptions = PanelOptions
typedef BubbleOptionsM = {
    > BubbleOptions,
    ?parent: mint.Control
}

class BubbleMenu extends Panel {
    
    public var bubbles : Array<Bubble>;
    
    override public function new(options : BubbleMenuOptions, bubblesOp : Array<BubbleOptionsM>) {
        options.w = 58;
        super(options);
        
        bubbles = [];
        for (bubbleOp in bubblesOp) {
            bubbleOp.parent = this;
            bubbleOp.x = 5;
            bubbleOp.y = 5 + 60 * bubbles.length;
            
            var bubble = new Bubble(bubbleOp);
            
            bubbles.push(bubble);
        }
    }

}

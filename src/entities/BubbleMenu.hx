package entities;

import entities.Bubble;
import mint.Panel;

typedef BubbleMenuOptions = {
    > PanelOptions,
    zooming: Float // see Bubble.hx
}

typedef BubbleOptionsM = {
    > BubbleOptions,
    ?parent: mint.Control, // makes it modifiable so I can set the menu as each bubble's parent
    ?zooming: Float // You don't have to put the zooming here if it's already on the menu's options
}

class BubbleMenu extends Panel {
    
    public var bubbles : Array<Bubble>;
    
    override public function new(options : BubbleMenuOptions, bubblesOp : Array<BubbleOptionsM>) {
        options.w = Bubble.BUBBLE_SIZE + options.zooming;
        super(options);
        
        bubbles = [];
        for (bubbleOp in bubblesOp) { // make the bubbles!
            
            bubbleOp.parent = this; // adopt them!
            
            if(bubbleOp.zooming==null) bubbleOp.zooming = options.zooming; // grow them!
            bubbleOp.x = options.zooming/2; // (leave margin for the growing)
            bubbleOp.y = options.zooming/2 + (Bubble.BUBBLE_SIZE + options.zooming) * bubbles.length; // (leave margin for the growing AND give each bubble a different y)
            // kick them out your house!
            // profit!
            
            var bubble = new Bubble(bubbleOp);
            
            bubbles.push(bubble); // push it to the bubbles array so I can access each of them later
        }
    }

}

package ui;

import openfl.display.Sprite;
import openfl.events.Event;

class Boton extends Sprite {

	public function new(color:Int, callback:Event->Void){
		super();
		this.graphics.beginFill(color);
		this.graphics.drawRect(0,0,50,50);
		this.graphics.endFill();
		this.addEventListener(openfl.events.MouseEvent.CLICK,callback);
	}

}
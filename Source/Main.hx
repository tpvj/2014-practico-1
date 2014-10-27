package;


import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.KeyboardEvent;
import openfl.Assets;
import ui.Boton;


class Main extends Sprite {
	
	var cuadrito:Sprite;
	var aceleracion:Float;

	var obstaculo:Sprite;
	var teclas:Array<Bool>; 

	var boton:Boton;
	var pausa:Bool;
	var velocidad:Float;

	var die:openfl.media.Sound;

	/// http://bit.ly/tvj2014

	public function new () {
		super ();
		pausa=false;
		velocidad=0.1;
		aceleracion=0;
		cuadrito=new Sprite();
		obstaculo=new Sprite();
		teclas=new Array<Bool>();

		/*cuadrito.graphics.clear();
		cuadrito.graphics.beginFill(0xFF0000);
		cuadrito.graphics.drawRect(-75,-75,150,150);
		cuadrito.graphics.endFill();
		*/
		var avion:Bitmap = new Bitmap (Assets.getBitmapData ("assets/images/avion.png"));
		cuadrito.addChild(avion);
		var meteorito:Bitmap = new Bitmap (Assets.getBitmapData ("assets/images/asteroide.png"));
		obstaculo.addChild(meteorito);

		avion.scaleX=0.3;
		avion.scaleY=0.3;

		avion.x=avion.width/-2;
		avion.y=avion.height/-2;


		this.addChild(cuadrito);
		this.addChild(obstaculo);

		cuadrito.x=stage.stageWidth/2;
		cuadrito.y=stage.stageHeight/2;

		obstaculo.scaleX=obstaculo.scaleY=0.2;
		obstaculo.x=700;
		obstaculo.y=250;

		this.addEventListener(openfl.events.Event.ENTER_FRAME,loop);
		stage.addEventListener(openfl.events.KeyboardEvent.KEY_UP,onKeyUp);
		stage.addEventListener(openfl.events.KeyboardEvent.KEY_DOWN,onKeyDown);

		boton=new Boton(0x00FF00,onPauseClick);
		this.addChild(boton);
		boton.y=10;
		boton.x=stage.stageWidth-10-50;

		var velBtn=new Boton(0xFF0000,function(_){velocidad+=0.4;});
		this.addChild(velBtn);

		#if (cpp || neko)
		die=Assets.getSound ('assets/sounds/die.ogg');
		#else
		die=Assets.getSound ('assets/sounds/die.mp3');
		#end
	}

	public function onPauseClick(_){
		pausa=!pausa;
	}

	public function loop(_){
		if(pausa) return;

		obstaculo.x-=2*velocidad;
		if(detectarColision(cuadrito,obstaculo)){
			if(cuadrito.alpha==1) die.play();
			cuadrito.alpha=0.4;
		}

		if(teclas['S'.charCodeAt(0)] == true){
			cuadrito.y+=5*velocidad;
		}

		if(teclas['W'.charCodeAt(0)] == true){
			cuadrito.y-=5*velocidad;
		}
	}

    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    private function detectarColision(obj1:Sprite,obj2:Sprite):Bool{
		if(obj1.x+obj1.width>obj2.x && obj1.x<obj2.x+obj2.width){
		   	if(obj1.y+obj1.height>obj2.y && obj1.y<obj2.y+obj2.height){
		   		return true;
		   	}
		}
		return false;
    }

	// Cuando se Suelta una Tecla
    private function onKeyUp(event:KeyboardEvent){
    	teclas[event.keyCode]=false;
    }

	// Cuando se Presiona una Tecla
    private function onKeyDown(event:KeyboardEvent){
		teclas[event.keyCode]=true;
    }	

}
package;

import flixel.FlxSprite;

class Tj_Stage extends FlxSprite
{
	var idleFr:Array<Int>;
	var flaFr:Array<Int>;

    override public function new()
    {
        super();

		this.loadGraphic("assets/images/playstate/tj stage.png", true, 640, 480);

		idleFr = [0];
		flaFr = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];

		this.animation.add('nothin', idleFr, 1, false);
		this.animation.add('b o o', flaFr, 24, false);
        
		this.antialiasing = false;
    }
}
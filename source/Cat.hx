package;

import flixel.FlxG;
import flixel.FlxSprite;

class Cat extends FlxSprite
{
	var idleFr:Array<Int>;
	var finFr:Array<Int>;
	var scareFr:Array<Int>;

	var counter:Float = 0.06;

	public var type:String;

	public var catAngle:Float;

	public var scared:Bool = false;

	public var rolled:Bool = false;

	override public function new(x:Float, y:Float, type:String)
	{
		super();

		this.type = type;
		this.x = x;
		this.y = y;
		this.drag.x = 1400;
		this.loadGraphic("assets/images/playstate/kit_she.png", true);

		switch (this.type)
		{
			case 'lilly':
				idleFr = [0];
				finFr = [1];
				scareFr = [0];
			case 'logo':
				idleFr = [2];
				finFr = [3];
				scareFr = [2];
			case 'luna':
				idleFr = [4];
				finFr = [5];
				scareFr = [4];
			case 'artsi':
				idleFr = [6];
				finFr = [7];
				scareFr = [6];
			case 'tj':
				idleFr = [8];
				finFr = [9];
				scareFr = [10];
			case 'strayONE':
				idleFr = [11];
				finFr = [12];
				scareFr = [11];
			case 'strayTWO':
				idleFr = [13];
				finFr = [14];
				scareFr = [13];
			default:
				return;
		}

		this.animation.add('catgud', idleFr, 1, false);
		this.animation.add('cat rolled', finFr, 1, false);
		this.animation.add('cat scared', scareFr, 1, false);

		this.antialiasing = false;
	}

	function movement()
	{
		var rRight = FlxG.keys.anyPressed([RIGHT, D]);
		var rLeft = FlxG.keys.anyPressed([LEFT, A]);

		if (rRight && PlayState.paused == false)
		{
			this.velocity.x = 160;
			this.angularVelocity = 40;
		}
		else if (rLeft && PlayState.paused == false)
		{
			this.velocity.x = -160;
			this.angularVelocity = -40;
		}
		else
			this.angularVelocity = 0;

		if (!rolled || !scared)
			this.animation.play('catgud');
		else
		{
			this.animation.play('cat rolled');
			this.velocity.x = 0;
		}
		if (scared)
		{
			this.animation.play('cat scared');
			this.velocity.x = 0;
		}
	}

	override public function update(elapsed:Float)
	{
		catAngle = this.angularVelocity;
		movement();
		super.update(elapsed);
	}
}

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.CallStack;

class LevelOne extends FlxState
{
	var kitties:Cat;

	var timer:FlxTimer;

	var curKit:String;
	var curBlanket:String;
	var curRoll:String;

	var tutorial:FlxTypeText;

	var blanket:FlxSprite;
	var bg:FlxSprite;
	var rollPoint:FlxSprite;

	var counter:Float = 0.08;

	var pText:FlxText;

	var tutFinish:Bool = false;
	var flag:Bool = true;

	var catcom:Array<FlxSprite>;

	public static var roll:FlxSprite;

	override public function create()
	{
		pText = new FlxText(476, 330, 0, "", 16, true);
		pText.font = 'assets/data/fonts/statusplz-regular.ttf';
		pText.antialiasing = false;

		rollPoint = new FlxSprite(480, 380);
		rollPoint.makeGraphic(16, 16, FlxColor.TRANSPARENT);
		super.create();
		bg = new FlxSprite(0, 0, 'assets/images/playstate/new stage.png');

		#if html5
		FlxG.sound.playMusic('assets/music/Bg.mp3', 1, true);
		#end
		#if !html5
		FlxG.sound.playMusic('assets/music/Bg.ogg', 1, true);
		#end

		add(bg);
		add(rollPoint);
		add(pText);
		spawnCats();
	}

	function onClick()
	{
		pText.angle = pText.angle - 2;
	}

	function spawnCats()
	{
		switch (FlxG.random.int(0, 3))
		{
			case 0:
				curKit = 'lilly';
				curRoll = 'assets/images/playstate/lillyroll.png';
				curBlanket = 'assets/images/playstate/lillyblank.png';
			case 1:
				curKit = 'logo';
				curRoll = 'assets/images/playstate/logoroll.png';
				curBlanket = 'assets/images/playstate/logoblank.png';
			case 2:
				curKit = 'luna';
				curRoll = 'assets/images/playstate/lunaroll.png';
				curBlanket = 'assets/images/playstate/lunablank.png';
			case 3:
				curKit = 'artsi';
				curRoll = 'assets/images/playstate/artsiroll.png';
				curBlanket = 'assets/images/playstate/artsiblank.png';
			case _:
				trace("default :(");
		}

		kitties = new Cat(108, 363, curKit);
		if (kitties != null && !kitties.exists && !kitties.alive)
			kitties.revive();

		kitties.setGraphicSize(80);
		kitties.setPosition(108, 338);

		kitties.centerOrigin();
		kitties.updateHitbox();
		kitties.centerOffsets();

		kitties.rolled = false;

		roll = new FlxSprite(0, 0);
		roll.loadGraphic(curRoll);
		roll.centerOrigin();
		roll.centerOffsets();

		blanket = new FlxSprite(90, 398);
		blanket.loadGraphic(curBlanket);

		add(blanket);
		add(roll);
		add(kitties);
	}

	function rollLogic(elapsed:Float)
	{
		counter -= elapsed;
		roll.setPosition(kitties.x - 44, kitties.y - 38);

		if (!(kitties.angularVelocity == 0))
			if (counter <= 0)
			{
				if (kitties.angularVelocity < 0)
				{
					roll.angularVelocity = kitties.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.08;

					roll.height--;
					roll.width--;
				}
				else
				{
					roll.angularVelocity = kitties.angularVelocity;
					roll.angularDrag = 1400;
					counter = 0.08;
					roll.height++;
					roll.width++;
				}
				roll.setGraphicSize(Std.int(roll.width), Std.int(roll.height));
			}
	}

	function doARoll()
	{
		if (kitties.overlaps(rollPoint) && flag && PlayState.canPause)
		{
			PlayState.canPause = false;
			flag = false;
			PlayState.points += 25;
			kitties.rolled = true;
			FlxTween.tween(kitties, {angle: kitties.angle + 20, y: 800}, 0.7, {
				ease: FlxEase.bounceOut,
				onComplete: function(_):Void
				{
					kitties.kill();
					blanket.kill();
					roll.kill();
					spawnCats();
					PlayState.canPause = true;
					flag = true;
				}
			});
		}
	}

	override public function update(elapsed:Float)
	{
		/*
			if (FlxG.keys.anyJustPressed([ENTER]) && paused == false)
			{
				var dialogue = new Dialogue(FlxColor.BLACK, "hey :)");
				openSubState(dialogue);
			}
		 */

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE && PlayState.canPause == true)
		{
			PlayState.paused = true;
			FlxG.sound.pause();
			openSubState(new PauseMenuSubState());
		}

		pText.text = '' + PlayState.points;
		rollLogic(elapsed);
		doARoll();
		super.update(elapsed);
	}
}

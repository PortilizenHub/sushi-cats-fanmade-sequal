package levels;

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

class LevelTwo extends FlxState
{
	var kitties:Cat;

	var timer:FlxTimer;

	var curKit:String;
	var curBlanket:String;
	var curRoll:String;

	var tutorial:FlxTypeText;

	var blanket:FlxSprite;
	var rollPoint:FlxSprite;

	var counter:Float = 0.08;

	var pText:FlxText;
	var mechanic:FlxText;

	var tutFinish:Bool = false;
	var flag:Bool = true;

	var catcom:Array<FlxSprite>;

	var bg:Tj_Stage;

	public static var roll:FlxSprite;

	override public function create()
	{
		super.create();
		
		PlayState.points = 0;

		mechanic = new FlxText(20, 350, 0, 'Watch out for thunder!', 24);
		add(mechanic);
		
		pText = new FlxText(476, 230, 0, "", 16, true);
		pText.font = 'assets/data/fonts/statusplz-regular.ttf';
		// looks like its ingraved in the wall
		pText.alpha = 0.6;
		pText.angle = 10;
		pText.antialiasing = false;
		rollPoint = new FlxSprite(480, 380);
		rollPoint.makeGraphic(16, 16, FlxColor.TRANSPARENT);

		bg = new Tj_Stage();
		bg.animation.play('nothin', true);

		FlxG.sound.destroy();
		QoL.playMusic('assets/music/TJ');

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
		curKit = 'tj';
		curRoll = 'assets/images/playstate/artsiroll.png';
		curBlanket = 'assets/images/playstate/artsiblank.png';

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
		var random:Int = FlxG.random.int(0, 2);
		if (ModsSubState.mechanicsMod == true)
			random = 0;
		
		FlxG.watch.addQuick('randomValue', random);

		if (kitties.overlaps(rollPoint) && flag && PlayState.canPause && random != 1)
		{
			trace('begon');
			flag = false;
			PlayState.points += 25;
			kitties.rolled = true;
			FlxTween.tween(kitties, {angle: kitties.angle - 20, y: 800}, 0.7, {
				ease: FlxEase.bounceOut,
				onComplete: function(_):Void
				{
					kitties.kill();
					blanket.kill();
					roll.kill();
					spawnCats();
					flag = true;
				}
			});
		}
		else if (kitties.overlaps(rollPoint) && flag && PlayState.canPause && random == 1)
		{
			trace('SCARED CAT');
			kitties.rolled = false;
			kitties.scared = true;
			bg.animation.play('b o o', true);
			FlxTween.tween(kitties, {angle: kitties.angle - 20, x: -300}, 0.7, {
				ease: FlxEase.linear,
				onComplete: function(_):Void
				{
					var curX = kitties.x;
					var curY = kitties.y;
					bg.animation.play('nothin', true);
					kitties.rolled = false;
					kitties.scared = false;
					kitties.y += 40;
					roll.kill();
					FlxTween.tween(kitties, {angle: kitties.angle + 60, x: 108}, 2, {
						ease: FlxEase.bounceIn,
						onComplete: function(_):Void
						{
							blanket.kill();
							kitties.kill();
							roll.kill();
							spawnCats();
							flag = true;
						}
					});
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
		PlayState.canPause = flag;

		mechanic.alpha -= 0.1;

		super.update(elapsed);
	}
}

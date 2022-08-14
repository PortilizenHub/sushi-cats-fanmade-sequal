package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxSliceSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.math.FlxRect;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.text.TextFormat;

class MenuState extends FlxState
{
	var locked:Bool = false;

	var titleText:FlxText;
	var datxt:FlxText;

	var bd:FlxBackdrop;

	var buttonG:FlxSliceSprite;

	var playButton:FlxUIButton;
	var modsButton:FlxUIButton;
	var optionsButton:FlxUIButton;

	var easterEgg:FlxSprite;
	var fatal:FlxSprite;

	var arr:Array<String>;

	var ttlObj:Array<Dynamic>;

	override public function create()
	{
		super.create();

		// FlxG.sound.destroy();
		// QoL.playMusic('assets/music/coffee');

		if (FlxG.camera.color == FlxColor.BLACK)
			FlxG.camera.fade(FlxColor.TRANSPARENT, true);

		if (FlxG.random.int(1, 120) == 1)
		{
			easterEgg = new FlxSprite(154, 30, 'assets/images/fnf real.png');
			add(easterEgg);
		}

		// buttonG = new FlxSliceSprite('assets/images/ui/button.png', FlxRect.get(16, 16, 128 - 32, 128 - 32), 48, 128);
		bd = new FlxBackdrop('assets/images/playstate/bdrop.png', 1, 1);
		bd.velocity.set(40, 40);
		FlxG.camera.bgColor = FlxColor.fromString("#d2cbf2");

		titleText = new FlxText(154, 90, 0, "Sushi Cats 2!", 48, true);
		titleText.font = 'assets/data/fonts/lowbatt.ttf';

		fatal = new FlxSprite(154, 90,
			'assets/images/fatal.png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png..png.png.png.png.png');
		fatal.alpha = 0;
		add(fatal);

		if (ModsSubState.originalMod == false)
		{
			modsButton = new FlxUIButton(206, 290, "Mods!", onModsClick);
			playButton = new FlxUIButton(206, 260, "Play!", onPlayClick);
			optionsButton = new FlxUIButton(306, 260, "Options!", onOptionsClick);
		}
		else if (ModsSubState.originalMod == true)
		{
			modsButton = new FlxUIButton(256, 290, "Mods!", onModsClick);
			playButton = new FlxUIButton(256, 260, "Play!", onOGPlayClick);
		}

		datxt = new FlxText(148, 320, 0, "Made with love to the Haxe Community\noriginal by Renchu (@BSOD).\nsequel by Portilizen", 14);
		datxt.alignment = CENTER;
		datxt.color = FlxColor.fromString("383259");
		datxt.autoSize = false;

		ttlObj = [bd, titleText, modsButton, playButton, optionsButton, datxt];

		for (o in ttlObj)
			add(o);

	}

	function onPlayClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, 1);
		for (o in ttlObj)
		{
			FlxTween.tween(o, {alpha: 0}, 1, {
				onComplete: (_) ->
				{
					FlxG.camera.bgColor = FlxColor.BLACK;
					FlxG.switchState(new LevelSelect());
				}
			});
		}
	}

	function onOGPlayClick()
	{
		if (locked == false)
		{
			FlxG.camera.bgColor = FlxColor.BLACK;
			LevelSelect.level = 1;
			FlxG.switchState(new Dialogue());
		}
		else if (locked == true)
		{
			FlxG.camera.fade(FlxColor.BLACK, 1);
			for (o in ttlObj)
			{
				FlxTween.tween(o, {alpha: 0}, 1, {
					onComplete: (_) ->
					{
						FlxG.camera.bgColor = FlxColor.BLACK;
						FlxG.switchState(new LevelSelect());
					}
				});
			}
		}

	}

	function onOptionsClick()
	{
		if (locked == false)
			openSubState(new OptionsSubState());
	}

	function onModsClick()
	{
		if (locked == false)
			openSubState(new ModsSubState());
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.G)
		{
			bd.alpha = 0;
			fatal.alpha = 10;
			locked = true;
			for (o in ttlObj)
				o.alpha = 0;
			playButton.alpha = 10;
		}

		super.update(elapsed);
	}
}

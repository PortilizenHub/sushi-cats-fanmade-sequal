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
	var titleText:FlxText;
	var datxt:FlxText;
	var vertxt:FlxText;

	var bd:FlxBackdrop;

	var buttonG:FlxSliceSprite;

	var playButton:FlxUIButton;
	var modsButton:FlxUIButton;
	var optionsButton:FlxUIButton;

	var easterEgg:FlxSprite;

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

		vertxt = new FlxText(2, 460, 0, PlayState.version, 14);
		vertxt.color = FlxColor.fromString("383259");

		ttlObj = [bd, vertxt, titleText, modsButton, playButton, optionsButton, datxt];

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
			FlxG.camera.bgColor = FlxColor.BLACK;
			LevelSelect.level = 1;
			FlxG.switchState(new Dialogue());

	}

	function onOptionsClick()
	{
		openSubState(new OptionsSubState());
	}

	function onModsClick()
	{
		openSubState(new ModsSubState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

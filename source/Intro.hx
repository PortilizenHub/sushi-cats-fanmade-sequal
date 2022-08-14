package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;

// no more polymod
// import polymod.Polymod;
class Intro extends FlxState
{
	// hard coded because im stupid lmao
	var introText:Array<Array<String>> = [['Cool Text', 'Text Cool'], ['Woah', 'An Intro'], ['', '']];

	var text:FlxText;

	var timer:Int;

	var itchSpr:FlxSprite;

	override function create()
	{
		trace('intro stuff start here');

		#if TESTING
		openSubState(new OptionsSubState());
		// FlxG.switchState(new NewPauseMenu());
		#end

		itchSpr = new FlxSprite(60, 0, 'assets/images/intro/devil.io.png');
		// itchSpr.color = 0xffff0000;
		add(itchSpr);

		QoL.checkPolymod();

		text = new FlxText(220, 490 - 20, 0, "itch-io", 64);
		text.font = 'assets/data/fonts/lowbatt.ttf';
		// text.centerOffsets(false);
		text.y -= 380;
		text.color = FlxColor.WHITE;
		add(text);

		/*

			text = new FlxText(0, 0, 0, '', 32);
			text.font = 'assets/data/fonts/lowbatt.ttf';
			text.centerOffsets(true);
			add(text);
			getIntroText();

		 */

		super.create();
	}

	override function update(elapsed:Float)
	{
		timer++;

		switch (timer)
		{
			case 100:
				FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}

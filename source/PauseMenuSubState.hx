package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseMenuSubState extends FlxSubState
{
	var textItems:Array<String> = ['Resume', 'Exit to menu', 'Exit to Level Select'];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

	// pov: you realize that you made a variable you dont need
	public static var PauseLevel:FlxState;

	public function new()
	{
		super();

		//random from 1 to never gonna give you up views when i saw it
		var rand:Int = FlxG.random.int(1, 1266111147);
		
		if (rand == 1)
		{
			textItems.remove('Resume');
			textItems.remove('Exit to menu');
			textItems.remove('Exit to Level Select');
			textItems.push('Never gonna');
			textItems.push('Give you');
			textItems.push('Up');
		}

		if (rand != 1)
			trace(rand);

		trace('paused');

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		add(bg);

		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpTexts);

		for (i in 0...textItems.length)
		{
			var text:FlxText = new FlxText(20, 80 + (i * 50), 0, textItems[i], 32);
			text.ID = i;
			grpTexts.add(text);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP)
			curSelected--;

		if (FlxG.keys.justPressed.DOWN)
			curSelected++;

		if (curSelected < 0)
			curSelected = textItems.length - 1;

		if (curSelected >= textItems.length)
			curSelected = 0;

		grpTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (textItems[curSelected])
			{
				case 'Open Options Menu':
					// openSubState(new OptionsSubState());

				case 'Exit to menu':
					FlxG.camera.fade(FlxColor.BLACK, 1);
					trace('unpaused but we go to da menu');
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					FlxG.switchState(new MenuState());
					PlayState.paused = false;

				case 'Exit to Level Select':
					FlxG.camera.fade(FlxColor.BLACK, 1);
					trace('unpaused but we go to da levels');
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					FlxG.switchState(new LevelSelect());
					PlayState.paused = false;

				default:
					FlxG.sound.resume();
					PlayState.paused = false;
					trace('unpaused');
					FlxG.state.closeSubState();
			}
		}
	}
}

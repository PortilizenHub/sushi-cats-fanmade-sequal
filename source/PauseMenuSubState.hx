package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PauseMenuSubState extends FlxSubState
{
	var textItems:Array<String> = ['Resume', 'Exit to menu'];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		trace('paused');

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		add(bg);

		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpTexts);

        var textStats:FlxText = new FlxText(430, 20, 0, 'Points: ' + PlayState.points, 32);
        textStats.x = 640 - PlayState.points;
        // add(textStats);

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
				case 'Resume':
					FlxG.sound.resume();
					PlayState.paused = false;
					trace('unpaused');
					FlxG.state.closeSubState();

				case 'Exit to menu':
					FlxG.camera.fade(FlxColor.BLACK, 1);
					trace('unpaused but we go to da menu');
					FlxG.state.closeSubState();
                    FlxG.camera.color = FlxColor.WHITE;
					FlxG.switchState(new MenuState());
					PlayState.paused = false;
			}
		}
	}
}

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;

class LevelSelect extends FlxSubState
{
	var textItems:Array<String> = ['Level 1', 'Exit to menu'];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

	public static var level:Int = 0;

	public function new()
	{
		super();

		if (FlxG.camera.color == FlxColor.BLACK)
			FlxG.camera.fade(FlxColor.TRANSPARENT, true);

		var bd:FlxBackdrop = new FlxBackdrop('assets/images/playstate/bdrop.png', 1, 1);
		bd.velocity.set(40, 40);
		FlxG.camera.bgColor = FlxColor.fromString("#d2cbf2");
		add(bd);

		var titleText:FlxText = new FlxText(154, 20, 0, "Level Select!", 48, true);
		titleText.font = 'assets/data/fonts/lowbatt.ttf';
		add(titleText);

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
				case 'Level 1':
					level = 1;
					FlxG.camera.fade(FlxColor.BLACK, 1);
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					FlxG.switchState(new Dialogue());

				case 'Exit to menu':
					FlxG.camera.fade(FlxColor.BLACK, 1);
					trace('go to da menu');
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					FlxG.switchState(new MenuState());
					PlayState.paused = false;
			}
		}
	}
}

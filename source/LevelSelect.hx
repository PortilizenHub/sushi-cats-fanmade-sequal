package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelSelect extends FlxSubState
{
	var textItems:Array<String> = ['Level 1', 'Level 2', 'Level 3', 'Level 4', 'Exit to Main Menu'];

	// ment to  show level mechanics
	var levelMech:Array<String> = ['none', 'Thunder', 'none'];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

	var bd:FlxBackdrop;

	public static var level:Int = 0;

	public function new()
	{
		super();

		textItems.remove('Level 4');

		if (FlxG.camera.color == FlxColor.BLACK)
			FlxG.camera.fade(FlxColor.TRANSPARENT, true);

		bd = new FlxBackdrop('assets/images/playstate/bdrop.png', 1, 1);
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
			var text:FlxText = new FlxText(20, 80 + (i * 40), 0, textItems[i], 32);
			text.ID = i;
			text.font = 'assets/data/fonts/lowbatt.ttf';
			grpTexts.add(text);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP)
		{
			QoL.playSound('assets/sounds/move_selec');
			curSelected--;
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			QoL.playSound('assets/sounds/move_selec');
			curSelected++;
		}

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
					if (OptionsSubState.publicDialogueVAR == true)
						FlxG.switchState(new Dialogue());
					else if (OptionsSubState.publicDialogueVAR == false)
						FlxG.switchState(new levels.LevelOne());

				case 'Level 2':
					level = 2;
					FlxG.camera.fade(FlxColor.BLACK, 1);
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					if (OptionsSubState.publicDialogueVAR == true)
						FlxG.switchState(new Dialogue());
					else if (OptionsSubState.publicDialogueVAR == false)
						FlxG.switchState(new levels.LevelTwo());

				case 'Level 3':
					level = 3;
					FlxG.camera.fade(FlxColor.BLACK, 1);
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					if (OptionsSubState.publicDialogueVAR == true)
						FlxG.switchState(new Dialogue());
					else if (OptionsSubState.publicDialogueVAR == false)
						FlxG.switchState(new levels.LevelThree());

				case 'Level 4':
					level = 4;
					FlxG.camera.fade(FlxColor.BLACK, 1);
					FlxG.state.closeSubState();
					FlxG.camera.color = FlxColor.BLACK;
					if (OptionsSubState.publicDialogueVAR == true)
						FlxG.switchState(new Dialogue());
					else if (OptionsSubState.publicDialogueVAR == false)
						FlxG.switchState(new levels.LevelThree());

				case 'Exit to Main Menu':
					trace('go to da menu');
					FlxG.switchState(new MenuState());
			}
		}
	}
}

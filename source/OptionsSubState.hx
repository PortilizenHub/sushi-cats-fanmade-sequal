package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends FlxSubState
{
	var background:FlxSprite;

	// options variables
    public static var publicDialogueVAR:Bool = true;
	var dialogueVAR:Bool = true;

	// arrays with the content
	var options:Array<String> = ['Dialogue'];
	var optionsVALUE:Array<Bool> = [];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		trace('OOOOOOO');
		super();
	}

	override function create()
	{
		if (FlxG.camera.color == FlxColor.BLACK)
			FlxG.camera.fade(FlxColor.TRANSPARENT, true);
        
		// basic stuff
		background = new FlxSprite(0, 0);
		background.makeGraphic(640, 480, FlxColor.BLACK);
		background.alpha = 0.4;
		add(background);

		grpTexts = new FlxTypedGroup<FlxText>();
		add(grpTexts);

		for (i in 0...options.length)
		{
			var text:FlxText = new FlxText(20, 80 + (i * 50), 0, options[i] + ": " + optionsVALUE[i], 32);
			text.ID = i;
			grpTexts.add(text);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
        publicDialogueVAR = dialogueVAR;

		optionsVALUE = [dialogueVAR];

		if (FlxG.keys.justPressed.ESCAPE)
		{
            FlxG.switchState(new MenuState());
			closeSubState();
        }

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
			curSelected = options.length - 1;

		if (curSelected >= options.length)
			curSelected = 0;

		grpTexts.forEach(function(txt:FlxText)
		{
            txt.text = options[txt.ID] + ": " + optionsVALUE[txt.ID];
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (FlxG.keys.justReleased.ENTER)
		{
			trace('change a value');

			switch (curSelected)
			{
				case 0:
					if (dialogueVAR == true)
						dialogueVAR = false;
					else if (dialogueVAR == false)
						dialogueVAR = true;
			}

			FlxG.log.add(options[curSelected] + ": " + optionsVALUE[curSelected]);
		}

		super.update(elapsed);
	}
}

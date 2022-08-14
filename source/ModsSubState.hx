package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ModsSubState extends FlxSubState
{
	var background:FlxSprite;

	// mods variables
	public static var mechanicsMod:Bool = false;
	public static var originalMod:Bool = false;

	// arrays with the content
	var mods:Array<String> = ['MechanicsMod', 'OriginalMod'];
	var modsVALUE:Array<Bool> = [];

	var curSelected:Int = 0;

	var grpTexts:FlxTypedGroup<FlxText>;

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

		for (i in 0...mods.length)
		{
			var text:FlxText = new FlxText(20, 80 + (i * 50), 0, mods[i] + ": " + modsVALUE[i], 32);
			text.ID = i;
			grpTexts.add(text);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		modsVALUE = [mechanicsMod, originalMod];

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
			curSelected = mods.length - 1;

		if (curSelected >= mods.length)
			curSelected = 0;

		grpTexts.forEach(function(txt:FlxText)
		{
            txt.text = mods[txt.ID] + ": " + modsVALUE[txt.ID];
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
					if (mechanicsMod == false)
						mechanicsMod = true;
					else if (mechanicsMod == true)
						mechanicsMod = false;
                case 1:
					if (originalMod == false)
						originalMod = true;
					else if (originalMod == true)
						originalMod = false;
			}

			FlxG.log.add(mods[curSelected] + ": " + modsVALUE[curSelected]);
		}

		super.update(elapsed);
	}
}

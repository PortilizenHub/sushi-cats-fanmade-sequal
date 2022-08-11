package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class PauseMenuSubState extends FlxSubState
{
	public function new()
	{
		super();

		trace('paused');

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			PlayState.paused = false;
			trace('unpaused');
			FlxG.state.closeSubState();
		}
	}
}

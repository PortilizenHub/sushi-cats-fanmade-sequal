package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	public static var paused:Bool = false;
	public static var canPause:Bool = true;
	public static var points:Int = 0;
	public static var version:String = "v0.3.2";

	override public function create()
	{
		FlxG.switchState(new MenuState());
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

package;

import flixel.FlxState;

class PlayState extends FlxState
{
	public static var paused:Bool = false;
	public static var canPause:Bool = true;
	public static var points:Int = 0;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

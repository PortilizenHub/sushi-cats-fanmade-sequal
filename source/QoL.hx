package;

import flixel.FlxG;
import lime.utils.Assets;

using StringTools;

class QoL 
{
	public static function checkPolymod()
	{
		#if polymod
		trace('polymod enabled');
		#elseif !polymod
		trace('polymod disabled');
		#end
	}
	
	public static function playSound(path:String)
	{
		#if html5
		FlxG.sound.play(path + ".mp3", 1, false);
		#end
		#if !html5
		FlxG.sound.play(path + ".ogg", 1, false);
		#end
	}

	public static function playMusic(path:String)
	{
		#if html5
		FlxG.sound.playMusic(path + ".mp3", 1, true);
		#end
		#if !html5
		FlxG.sound.playMusic(path + ".ogg", 1, true);
		#end
	}

	public static function getTextFile(path:String, split:String):Array<String>
	{
		var list:Array<String> = Assets.getText(path).trim().split(split);

		for (i in 0...list.length)
		{
			list[i] = list[i].trim();
		}

		return list;
	}

}

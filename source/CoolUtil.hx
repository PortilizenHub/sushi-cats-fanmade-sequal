package;

import lime.utils.Assets;

using StringTools;

class CoolUtil
{

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
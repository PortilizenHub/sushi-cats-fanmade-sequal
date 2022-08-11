package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.utils.Assets;

class Dialogue extends FlxState
{
	var bg:FlxSprite;
	var diaBox:FlxSprite;

	var dialogue:FlxText;
	var dialogueBOT:FlxText;

	var text:Array<String>;
	var textCool:Array<Array<String>>;

	var curLineSEC:Int = 0;
	var curLine:Int = 1;

	override function create()
	{
		FlxG.camera.color = FlxColor.BLACK;
		FlxG.camera.fade(FlxColor.TRANSPARENT, true);

		text = CoolUtil.getTextFile('assets/data/introDia.txt', ', ');

		bg = new FlxSprite(0, 0, '');
		add(bg);

		diaBox = new FlxSprite(0, 0, 'assets/images/playstate/story/dialogueBox.png');
		diaBox.alpha = 0.5;
		add(diaBox);

		dialogueBOT = new FlxText(90, 410, 0, '', 24);
		dialogueBOT.color = 0x000000;
		// add(dialogueBOT);

		dialogue = new FlxText(20, 350, 0, '', 24);
		dialogue.color = 0x4E4E4E;
		add(dialogue);

		createStory();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			curLineSEC++;
			curLine++;
			createStory();
		}

		super.update(elapsed);
	}

	function createStory()
	{
		trace(curLine);
		trace(text[curLineSEC]);

		// text
		switch (curLine)
		{
			case 1:
				dialogue.text = 'Oh boy...';
			case 2:
				dialogue.text = 'Mrs. Sea is coming back soon!';
			case 3:
				dialogue.text = "Their cats aren't sleep yet!";
			case 4:
				dialogue.text = 'I hope see takes awhile';
			case 5:
				dialogue.text = 'Cause getting these cats asleep is gonna\ntake awhile!';
			default:
				dialogue.text = '';
		}

		// background
		switch (curLine)
		{
			case 1, 2:
				bg.loadGraphic('assets/images/playstate/story/text.png', false, 640, 480);
			default:
				bg.loadGraphic('assets/images/playstate/story/messyCats.png', false, 640, 480);
		}

		// events
		switch (curLine)
		{
			case 6:
				FlxG.switchState(new PlayState());
			default:
				// i ment to say events but i thought this was funny
				trace('no ebemts for this line');
		}

		dialogueBOT.text = dialogue.text;
	}
}

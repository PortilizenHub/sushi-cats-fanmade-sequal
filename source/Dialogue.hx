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

		text = QoL.getTextFile('assets/data/introDia.txt', ', ');

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

		makeNewStory();

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			curLineSEC++;
			curLine++;
			makeNewStory();
		}

		super.update(elapsed);
	}

	function createStory(dia:String, background:String)
	{
		dialogue.text = dia;
		bg.loadGraphic(background, false, 640, 480);
	}

	function makeNewStory()
	{
		if (LevelSelect.level == 1)
		{
			switch (curLine)
			{
				case 1:
					createStory('Oh boy...', 'assets/images/playstate/story/text.png');
				case 2:
					createStory('Mrs.Sea is coming back!', 'assets/images/playstate/story/text.png');
				case 3:
					createStory("And the cats aren't sleep!", 'assets/images/playstate/story/text.png');
				case 4:
					createStory('I hope she is fine with certain cats being\nsleep, cause she has way to many for me \nto even make go to bed!',
						'assets/images/playstate/story/messyCats.png');
				case 5:
					FlxG.switchState(new LevelOne());
			}
		}

		if (LevelSelect.level == 2)
		{
			switch (curLine)
			{
				case 1:
					createStory('Hello?', 'assets/images/playstate/story/empyTJ.png');
				case 2:
					QoL.playSound('assets/sounds/meow');
					createStory('AAAA', 'assets/images/playstate/story/BOO.png');
				case 3:
					createStory('Oh geez, you scared me you lil-cat,\nI guess its just us for the night', 'assets/images/playstate/story/BOO.png');
				case 4:
					createStory('Okay so, I heard you like being rolled up \nin your blanket roll, ', 'assets/images/playstate/story/BOO.png');
				case 5:
					FlxG.switchState(new LevelTwo());
			}
		}

	}
}

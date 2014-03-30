package com.rubberduckygames.flixelx.input
{
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;

	public class FlxInputs
	{
		//public static var pressedLeft:Boolean = false;
		//public static var pressedRight:Boolean = false;
		public static var pressedAction:Boolean = false;
		
		//public static var releasedLeft:Boolean = false;
		//public static var releasedRight:Boolean = false;
		public static var releasedAction:Boolean = false;
		
		//public static var holdingLeft:Boolean = false;
		//public static var holdingRight:Boolean = false;
		public static var holdingAction:Boolean = false;
		
		// C and X are next to each other on most keyboard
		//public static const BUTTON_X:String = "X";
		//public static const BUTTON_C:String = "C";
		// So are , and . (which are usually shared keys < and >)
		//public static const BUTTON_COMMA:String = "COMMA";
		//public static const BUTTON_PERIOD:String = "PERIOD";
		//public static const BUTTON_SPACE:String  = "SPACE";
		
		
		private static var waitTimer:FlxTimer = new FlxTimer();
		
		public static function update():void
		{
			if (!waitTimer.finished)
				return;
			
			//pressedLeft 	= FlxG.keys.justPressed(BUTTON_X) 	|| FlxG.keys.justPressed(BUTTON_COMMA);
			//pressedRight 	= FlxG.keys.justPressed(BUTTON_C) 	|| FlxG.keys.justPressed(BUTTON_PERIOD);
			//pressedAction 	= FlxG.keys.justPressed(BUTTON_SPACE);
			pressedAction 	= FlxG.mouse.justPressed();
			
			//releasedLeft 	= FlxG.keys.justReleased(BUTTON_X)	|| FlxG.keys.justReleased(BUTTON_COMMA);
			//releasedRight 	= FlxG.keys.justReleased(BUTTON_C) 	|| FlxG.keys.justReleased(BUTTON_PERIOD);
			//releasedAction 	= FlxG.keys.justReleased(BUTTON_SPACE);
			releasedAction 	= FlxG.mouse.justReleased();
			
			//holdingLeft 	= FlxG.keys[BUTTON_X] || FlxG.keys[BUTTON_COMMA];
			//holdingRight 	= FlxG.keys[BUTTON_C] || FlxG.keys[BUTTON_PERIOD];
			//holdingAction 	= FlxG.keys[BUTTON_SPACE];
			holdingAction 	= FlxG.mouse.pressed();
		}
		
		private static function waitTimerDone(Timer:FlxTimer):void
		{
			waitTimer.stop();
			trace("timer stopped");
		}
		
		public static function resetInputs(invalidInputSeconds:Number = 0.1):void
		{
			//releasedLeft 	= pressedLeft 	= holdingLeft 	= false;
			//releasedRight 	= pressedRight 	= holdingRight 	= false;
			releasedAction 	= pressedAction	= holdingAction	= false;
			
			waitTimer.start(invalidInputSeconds, 1, waitTimerDone);
		}
	}
}
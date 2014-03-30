package com.rubberduckygames.flixelx.graphics
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	
	public class FlxBlinkSprite extends FlxSprite
	{
		private var blinkTime:Number;
		
		public function FlxBlinkSprite(blinkTime:Number = 1, X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			this.blinkTime = blinkTime;
			blink(new FlxTimer());
		}
		
		private function blink(timer:FlxTimer):void
		{
			visible = !visible;
			
			if (visible)
				timer.start(blinkTime * 1.5, 1, blink);
			else
				timer.start(blinkTime * 0.5, 1, blink);
		}
	}
}
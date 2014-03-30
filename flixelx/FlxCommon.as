package com.rubberduckygames.flixelx
{
	import org.flixel.FlxG;

	public class FlxCommon
	{
		/** when progress is 1, final will be returned **/
		public static function getTransitionNumber(initial:Number, final:Number, progress:Number):Number
		{
			return initial * (1 - progress) + final * progress;
		}
		
		public static function randNumber(min:Number, max:Number):Number
		{
			return FlxG.random() * (max - min) + min;
		}
		
		public static function randInt(min:int, max:int):int
		{
			return FlxG.random() * (max - min + 1) + min;
		}
	}
}
package com.rubberduckygames.flixelx.graphics
{
	import org.flixel.FlxG;

	public class FlxScreenAnchors
	{
		public static function ScreenLeft():Number
		{
			return FlxG.camera.screen.x;
		}
		
		public static function ScreenRight():Number
		{
			return FlxG.camera.screen.x + FlxG.width;
		}
		
		public static function ScreenMidX():Number
		{
			return FlxG.camera.screen.x + FlxG.width / 2;
		}
		
		public static function ScreenTop():Number
		{
			return FlxG.camera.screen.y;
		}
		
		public static function ScreenBottom():Number
		{
			return FlxG.camera.screen.y + FlxG.height;
		}
		
		public static function ScreenMidY():Number
		{
			return FlxG.camera.screen.y + FlxG.height / 2;
		}
	}
}
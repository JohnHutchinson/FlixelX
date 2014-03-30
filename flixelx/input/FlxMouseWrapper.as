package com.rubberduckygames.flixelx.input
{
	import org.flixel.FlxG;

	public class FlxMouseWrapper
	{
		public static var forceShownOnMobile:Boolean = false;
		
		public static function show():void
		{
			if (((!FlxG.mobile) || forceShownOnMobile) && (!FlxG.mouse.visible))
				FlxG.mouse.show();
		}
		
		public static function hide():void
		{
			if (((!FlxG.mobile) || forceShownOnMobile) && (FlxG.mouse.visible))
				FlxG.mouse.hide();
		}
	}
}
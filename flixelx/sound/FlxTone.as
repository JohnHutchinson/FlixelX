package com.rubberduckygames.flixelx.sound
{
	import org.flixel.FlxSound;

	/** used with FlxTempo to make sure that unique sounds restart instead of being missed.
	 * (facilitates compatability with "callAll" function used in FlxTempo)  **/
	public class FlxTone extends FlxSound
	{
		public function FlxTone()
		{
			super();
		}
		
		/** overrides default value of ForceRestart to true **/
		override public function play(ForceRestart:Boolean=true):void
		{
			super.play(ForceRestart);
		}
	}
}
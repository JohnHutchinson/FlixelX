package com.rubberduckygames.flixelx.sound
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import org.flixel.*;

	/**
	 * ...
	 * @author lechuckGL
	 * But all the credit goes to kelvinluck
	 * http://www.kelvinluck.com/2009/03/second-steps-with-flash-10-audio-programming/
	 */
	public class FlxExtendedSound extends FlxSound
	{
		public static const BYTES_PER_CALLBACK:int = 2048; // Should be >= 2048 && < = 8192
		private var _playbackSpeed:Number = 1; 
		
		private var _dynamicSound:Sound;
		private var _phase:Number;
		private var _numSamples:int;
		
		/**
		 * Set playback speed. Default is 1...higher values mean higher tempo :D (positive values only!)
		 */
		public function set playbackSpeed(value:Number):void
		{
			if (value < 0) {
				throw new Error('Playback speed must be positive!');
			}
			_playbackSpeed = value;
		}		
		
		public function get playbackSpeed():Number
		{
			return (_playbackSpeed);
		}		
		
		
		
		public function FlxExtendedSound() 
		{
			super();			
		}
		
		
		
		override public function play(ForceRestart:Boolean=false):void 
		{
			//ALL THE JUICY STUFF HAPPENS HERE
			_dynamicSound = null;
			stop();
			_dynamicSound = new Sound();
			
			_dynamicSound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);			
			_numSamples = int(_sound.length * 44.1);
			
			
			if(_position == 0)
			{
				_phase = 0;
				_channel = _dynamicSound.play(0, 9999, _transform);
			}
			else {
				//_phase = _position * 1000;
				_channel = _dynamicSound.play(_position,0,_transform);
			}
			super.play(ForceRestart);
			_channel.addEventListener(Event.SOUND_COMPLETE, onSoundFinished);
			
			
			
		}
		
		override public function stop():void 
		{
			if (_dynamicSound) {
				_dynamicSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				if(_channel != null)
				{
					_channel.stop();
					_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundFinished);
				}
				_dynamicSound = null;
				_channel = null;
			}
			super.stop();
		}
		
		private function onSoundFinished(event:Event):void
		{
			stop();
			if (_looped)
			{				
				play();			 
			}
		}
		
		private function onSampleData( event:SampleDataEvent ):void
		{
			var l:Number;
			var r:Number;
			var p:int;
			
			
			var loadedSamples:ByteArray = new ByteArray();
			var startPosition:int = int(_phase);
			_sound.extract(loadedSamples, BYTES_PER_CALLBACK * _playbackSpeed, startPosition);
			loadedSamples.position = 0;
			
			while (loadedSamples.bytesAvailable > 0) {
				
				p = int(_phase - startPosition) * 8;
				
				if (p < loadedSamples.length - 8 && event.data.length <= BYTES_PER_CALLBACK * 8) {
					
					loadedSamples.position = p;
					
					l = loadedSamples.readFloat(); 
					r = loadedSamples.readFloat(); 
					
					event.data.writeFloat(l); 
					event.data.writeFloat(r);
					
				} else {
					loadedSamples.position = loadedSamples.length;
				}
				
				_phase += _playbackSpeed;
				
				// loop
				if (_phase >= _numSamples) {
					_phase -= _numSamples;
					break;
				}
			}
		}
		
		/**
		 * Call after adjusting the volume to update the sound channel's settings.
		 */
		public override function updateTransform():void
		{
			_transform.volume = (FlxG.mute?0:1)*FlxG.volume*_volume*_volumeAdjust;
			//_transform.volume = (FlxG.mute?0:1)*FlxG.volume*_volume*_volumeAdjust * Registry.musicVolume;
			if(_channel != null)
				_channel.soundTransform = _transform;
		}
	}
}
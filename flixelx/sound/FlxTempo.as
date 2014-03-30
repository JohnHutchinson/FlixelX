package com.rubberduckygames.flixelx.sound
{
	import com.rubberduckygames.babies.constants.GameConstants;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	
	/** 
	 * Responsible for automatically playing tones on-tempo.  Tones can be added to list and then they
	 * will all play in unison on the next tempo division. 
	 * **/
	public class FlxTempo extends FlxGroup
	{
		private var timer:FlxTimer;
		private var delayTimer:FlxTimer; // used to delay playback so that on-time events are heard
		private var tempo:Number;
		private var playing:Boolean;
		
		public function FlxTempo(MaxSize:uint=0)
		{
			super(MaxSize);
			timer = new FlxTimer;
			delayTimer = new FlxTimer;
			setTempo(0);
			stop();
		}
		
		/** this is called once every "tempo" seconds, plays all tones in current list,
		 * if any, then clears the list **/
		private function playAndClear(timer:FlxTimer):void
		{
			if (length > 0)
			{
				callAll("play");
				clear();
			}
			
			if (playing)
				playListOnTempo(); 	// continue
			else
				timer.stop();		// stop
		}
		
		private function playListOnTempo():void
		{
			timer.start(tempo, 1, playAndClear);
		}
		
		public function get isPlaying():Boolean
		{
			return playing;
		}
		
		/** Should be called before start().
		 * @param tempo how often to play sounds (in seconds). must be > 0
		 * @param divisions should be a power of 2. **/
		public function setTempo(tempo:Number, divisions:uint = GameConstants.TEMPO_DIVISIONS):void
		{
			if (tempo > 0 && divisions > 0)
				this.tempo = tempo / divisions;
		}
		
		/** Starts playback timing to now (as long as tempo has been correctly set) **/
		public function start(delay:Number = GameConstants.DELAYED_PLAYLIST_START):void
		{
			if (tempo > 0)
			{
				playing = true;
				delayTimer.start(delay, 1, delayedPlaylistStart);
				if (delay <= 0)
					delayedPlaylistStart(delayTimer);
			}	
		}
		
		/** used to delay the playlist a fraction of a second so that events played in time are
		 * heard immediately instead of the next tempo division **/
		private function delayedPlaylistStart(delayTimer:FlxTimer):void
		{
			playAndClear(timer);
			delayTimer.stop();
		}/**/
		
		private function startPlaylist():void
		{
			playing = true;
			playListOnTempo();
		}
		
		/** flags to stop playing once current list is played/cleared **/
		public function stop():void
		{
			playing = false;
		}
	}
}
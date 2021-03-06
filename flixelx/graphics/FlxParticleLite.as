package com.rubberduckygames.flixelx.graphics
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * This is a simple particle class that extends the default behavior
	 * of <code>FlxSprite</code> to have slightly more specialized behavior
	 * common to many game scenarios.  You can override and extend this class
	 * just like you would <code>FlxSprite</code>. While <code>FlxEmitter</code>
	 * used to work with just any old sprite, it now requires a
	 * <code>FlxParticleLite</code> based class.
	 * 
	 * @author Adam Atomic
	 */
	public class FlxParticleLite extends FlxSprite
	{
		/**
		 * How long this particle lives before it disappears.
		 * NOTE: this is a maximum, not a minimum; the object
		 * could get recycled before its lifespan is up.
		 */
		public var lifespan:Number;
		
		/**
		 * Instantiate a new particle.  Like <code>FlxSprite</code>, all meaningful creation
		 * happens during <code>loadGraphic()</code> or <code>makeGraphic()</code> or whatever.
		 */
		public function FlxParticleLite()
		{
			super();
			lifespan = 0;
			solid = false;
			visible = false;
			kill();
		}
		
		/**
		 * The particle's main update logic.  Basically it checks to see if it should
		 * be dead yet, and then has some special bounce behavior if there is some gravity on it.
		 */
		override public function update():void
		{
			//lifespan behavior
			if(lifespan <= 0)
				return;
			lifespan -= FlxG.elapsed;
			if(lifespan <= 0)
				kill();			
		}
		
		override public function kill():void
		{
			lifespan = 0;
			super.kill();
		}
		
		/**
		 * Triggered whenever this object is launched by a <code>FlxEmitter</code>.
		 * You can override this to add custom behavior like a sound or AI or something.
		 */
		public function onEmit():void
		{
		}
	}
}

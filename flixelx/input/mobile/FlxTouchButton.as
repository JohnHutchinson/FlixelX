package com.rubberduckygames.flixelx.input.mobile
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;

	/** On-Screen Touch Button Overlay Class
	 * Each button knows its status (pressed, released, untouched)
	 * This information is sent from FlxTouchButtonManager and used by FlxInputs
	 */
	public class FlxTouchButton extends FlxSprite
	{
		public static const TOUCH_BUTTON_LEFT:int	=	0x0001;
		public static const TOUCH_BUTTON_RIGHT:int	=	0x0010;
		public static const TOUCH_BUTTON_ACTION:int	=	0x0100;
		public static const TOUCH_BUTTON_CANCEL:int	=	0x1000;
		
		private const TOUCH_ID_NONE:int = -99;
		public var touchID:int = TOUCH_ID_NONE;
		private var isPressed:Boolean = false;
		private var wasPressed:Boolean = false;	
		private var receivedNewAction:Boolean = false;
		
		public function FlxTouchButton(Graphic:Class,Animated:Boolean=false,Reverse:Boolean=false,Width:uint=0,Height:uint=0,Unique:Boolean=false)
		{
			super(0, 0);
			
			loadGraphic(Graphic, Animated, Reverse, Width, Height, Unique);

			scrollFactor = new FlxPoint(0, 0);
			moves = false;
			immovable = true;
			solid = false;
			blend = "screen";
			addAnimation("off", [0], 0, false);
			addAnimation("on", [1], 0, false);
		}
		
		public function setAsPressed(touchID:int):void
		{
			isPressed = true;
			receivedNewAction = true;
			play("on");
			this.touchID = touchID;
		}
		
		public function setAsUnpressed():void
		{
			isPressed = false;
			receivedNewAction = true;
			play("off");
			touchID = TOUCH_ID_NONE;
		}
		
		public function justPressed():Boolean
		{
			return isPressed && (!wasPressed);
		}
		
		public function holding():Boolean
		{
			return isPressed;
		}
		
		public function justReleased():Boolean
		{
			return (!isPressed) && wasPressed;
		}
		
		public override function update():void
		{
			super.update();
			
			// give "just" methods a turn to play
			if (!receivedNewAction)
				wasPressed = isPressed;
			receivedNewAction = false;
		}
	}
}
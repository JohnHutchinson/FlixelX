package com.rubberduckygames.flixelx.input.mobile
{
	import com.rubberduckygames.flixelx.graphics.FlxScreenAnchors;
	
	import flash.events.TouchEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;

	/** Receives touch events from your game and sets the appropriate flags
	 * for each FlxButton.  These flags are what FlxInputs uses when you call
	 * the FlxInputs functions from your game. */
	public class FlxTouchButtonManager
	{
		public static var supportsTouch:Boolean;
		
		public static var left:FlxTouchButton;
		public static var right:FlxTouchButton;
		public static var action:FlxTouchButton;
		public static var cancel:FlxTouchButton;
		private static var pt:FlxPoint;
		
		public static function useTheseButtons(leftButton:FlxTouchButton, rightButton:FlxTouchButton, actionButton:FlxTouchButton, cancelButton:FlxTouchButton):void
		{
			left = leftButton;
			right = rightButton;
			action = actionButton;
			cancel = cancelButton;
			pt = new FlxPoint();
		}
		
		public static function showButtons(imgSize:int):void
		{
			left.x = FlxScreenAnchors.ScreenLeft() + imgSize / 8;
			left.y = FlxScreenAnchors.ScreenBottom() - imgSize;
			right.x = FlxScreenAnchors.ScreenLeft() + imgSize + imgSize / 8;
			right.y = FlxScreenAnchors.ScreenBottom() - imgSize;
			action.x = FlxScreenAnchors.ScreenRight() - imgSize;
			action.y = FlxScreenAnchors.ScreenBottom() - imgSize;
			cancel.x = FlxScreenAnchors.ScreenRight() - imgSize;
			cancel.y = FlxScreenAnchors.ScreenTop();
			
			FlxG.state.add(left);
			FlxG.state.add(right);
			FlxG.state.add(action);
			FlxG.state.add(cancel);
		}
		
		private static function getButtonOverlappingTouchPoint():FlxTouchButton
		{
			if (action.overlapsPoint(pt))
				return action;
			if (right.overlapsPoint(pt))
				return right;
			if (left.overlapsPoint(pt))
				return left;
			if (cancel.overlapsPoint(pt))
				return cancel;
			return null;
		}
		
		private static function getButtonWithID(eventID:int):FlxTouchButton
		{
			if (action.touchID == eventID)
				return action;
			if (right.touchID == eventID)
				return right;
			if (left.touchID == eventID)
				return left;
			if (cancel.touchID == eventID)
				return cancel;
			return null;
		}
		
		/** Handles moving on/off buttons.
		 */		
		public static function onTouch(event:TouchEvent):void
		{
			// Save Touch Point World Coordinates
			pt.x = event.stageX + FlxScreenAnchors.ScreenLeft();
			pt.y = event.stageY + FlxScreenAnchors.ScreenTop();
			
			// see if ID in use by button
			var button:FlxTouchButton = getButtonWithID(event.touchPointID);
			if (button)	// ID in use
			{
				// check that button's bounds
				if (!button.overlapsPoint(pt))	// moved out of bounds
					button.setAsUnpressed();
			}
			else	// ID not in use
			{
				// check if this new ID is overlapping any button
				button = getButtonOverlappingTouchPoint();
				if (button)	// overlapping a button
					button.setAsPressed(event.touchPointID);
			}
			event = null;
		}
		
		/** Clear any flags using this event
		 **/
		public static function onTouchEnd(event:TouchEvent):void
		{
			var button:FlxTouchButton = getButtonWithID(event.touchPointID);
			if (button)
				button.setAsUnpressed();
			else
			{
				// Save Touch Point World Coordinates
				pt.x = event.stageX + FlxScreenAnchors.ScreenLeft();
				pt.y = event.stageY + FlxScreenAnchors.ScreenTop();
				
				button = getButtonOverlappingTouchPoint();
				if (button)
					button.setAsUnpressed();
			}
			event = null;
		}
	}
}
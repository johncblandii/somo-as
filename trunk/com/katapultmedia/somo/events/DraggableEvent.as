package com.katapultmedia.somo.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author John C. Bland II
	*/
	public class DraggableEvent extends Event 
	{
		public static const MOVED:String = "moved";
		public static const MOVING:String = "moving";
		
		public function DraggableEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new DraggableEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DraggableEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
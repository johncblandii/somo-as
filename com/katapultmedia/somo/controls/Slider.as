package com.katapultmedia.somo.controls{
	import com.katapultmedia.somo.core.Draggable;
	import com.katapultmedia.somo.events.DraggableEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	* A slider class used for things like volume controls, etc.
	* 
	* @author John C. Bland II - Katapult Media, Inc.
	*/
	public class Slider extends Sprite{
		/********************************************************
		* Variable API
		********************************************************/
		public function get position():Number{
			return (handle.x/(track.width-handle.width))*100;
		}
		public function set position(value:Number):void{
			if(value < 0) value = 0;
			if(value > 100) value = 100;
			
			handle.x = ((track.width-handle.width)*(value*.01))+track.x;
		}
		
		/********************************************************
		* Stage Items
		********************************************************/
		public var handle:MovieClip;
		public var track:MovieClip;
		
		public function Slider(){
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void{ init(); });
		}
		
		private function init():void{
			if (!handle || !track) throw new Error("Slider expects a handle and track MovieClip on the stage.");
			
			var draggable:Draggable = new Draggable(handle);
			draggable.constraint = new Rectangle(track.x, handle.y, track.width-handle.width, 0);
			draggable.addEventListener(DraggableEvent.MOVING, handleDrag);
			
			track.addEventListener(MouseEvent.CLICK, handleTrackClick);
			
			handle.buttonMode = true;
			handle.mouseChildren = false;
		}
		
		private function handleTrackClick(event:MouseEvent):void{
			position = (event.localX/track.width)*100;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function handleDrag(event:Event):void{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}
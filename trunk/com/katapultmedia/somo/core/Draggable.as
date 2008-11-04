package com.katapultmedia.somo.core{
	import com.katapultmedia.somo.events.DraggableEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	* ...
	* @author John C. Bland II
	*/
	public class Draggable extends EventDispatcher{
		private var _target:Sprite;
		
		private var _isDragging:Boolean = false;
		public function get isDragging():Boolean{ return _isDragging; }
		public function set isDragging(value:Boolean):void{ _isDragging = value; }
		
		private var _constraint:Rectangle;
		public function get constraint():Rectangle{ return _constraint; }
		public function set constraint(value:Rectangle):void{
			_constraint = value;
		}
		
		private var _lockCenter:Boolean = false;
		public function set lockCenter(value:Boolean):void{ _lockCenter = value; }
		public function get lockCenter():Boolean{ return _lockCenter; }
		
		private var _canDrag:Boolean;
		public function get canDrag():Boolean{ return _canDrag; }
		public function set canDrag(value:Boolean):void{
			_canDrag = value;
			_canDrag ? addListeners() : removeListeners();
		}
		
		function Draggable(target:Sprite){
			_target = target;
			
			canDrag = true;
		}
		
		private function addListeners():void{
			if(!_target) return;
			
			_target.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_target.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_target.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function removeListeners():void{
			if(!_target) return;
			
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_target.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_target.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function handleMouseUp(event:MouseEvent):void{
			if(!_isDragging) return;
		
			_isDragging = false;
			_target.stopDrag();
			_target.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			_target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);;
			dispatchEvent(new DraggableEvent(DraggableEvent.MOVED));
		}
		
		private function handleMouseDown(event:MouseEvent):void{
			_isDragging = true;
			if (_constraint != null){
				_target.startDrag(_lockCenter, _constraint);
			}else{
				_target.startDrag(_lockCenter);
			}
			
			_target.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);;
			_target.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove); 
		}
		
		private function handleMouseMove(event:MouseEvent):void{
			dispatchEvent(new DraggableEvent(DraggableEvent.MOVING));
		}
	}
}
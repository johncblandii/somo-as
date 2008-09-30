/*
	Copyright (c) 2008 John C. Bland II.

	Permission is hereby granted, free of charge, to any person obtaining a copy of
	this software and associated documentation files (the "Software"), to deal in
	the Software without restriction, including without limitation the rights to
	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
	of the Software, and to permit persons to whom the Software is furnished to do
	so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
*/

package com.katapultmedia.somo.controls{
	import flash.events.Event;
	
	import mx.controls.TextArea;
	import mx.controls.textClasses.TextRange;
	
	/**
	 * The <code>RestrictedTextArea</code> component is a small enhancement to
	 * standard <code>TextArea</code>.  It adds the ability to specify a character limit
	 * and have the characters after the limit show up in the specified color.
	 */
	public class RestrictedTextArea extends TextArea{
		private var _charLimit:uint = 0;
		/**
		 * Sets the character limit
		 * <p>All characters after this limit will change to the
		 * specified color.</P
		 *  
		 * @return uint
		 */		
		public function get charLimit():uint{ return _charLimit; }
		public function set charLimit(value:uint):void{
			_charLimit = value;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		/**
		 * @private
		 * 
		 * Manages the "dirtyness" of the text property
		 * 
		 * @see <code>handleChange</code> 
		 */		
		private var _textLonger:Boolean;
		
		[Bindable("textChanged")]
		[CollapseWhiteSpace]
		[Inspectable(category="General", defaultValue="")]
		[NonCommittingChangeEvent("change")]
		/**
		 * Override the behavior of text so only the characters within the
		 * limit get returned
		 *  
		 * @return String 
		 * 
		 */
		public override function get text():String{
			var $text:String = super.text;
			
			if($text && _textLonger) $text = $text.substr(0, _charLimit); 
			
			return $text;
		} 
		
		/**
		 * Constructor
		 */
		public function RestrictedTextArea(){
			super();
			
			_textLonger = false;
			
			addEventListener(Event.CHANGE, handleChange);
		}
		
		/**
		 * @private
		 * Handles <code>text</code> property changes 
		 * @param event
		 * 
		 */		
		private function handleChange(event:Event):void{
			_textLonger = _charLimit > 0 && super.text.length > _charLimit;
			invalidateDisplayList();
		}
		
		/**
		 * @private
		 * 
		 * Update the display accordingly 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			//if super.text isn't valid or the length is 0 don't even worry about it
			if(!super.text || super.text.length == 0) return;
			
			var $range:TextRange;
			
			if(_textLonger){
				$range = new TextRange(this, false, _charLimit, super.text.length);
				$range.color = 0xFF0000;
			}else{
				$range = new TextRange(this);
				$range.color = getStyle("color");
			}
		}
	}
}
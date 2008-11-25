package com.katapultmedia.somo.keyboard{
	import com.katapultmedia.somo.events.PhraseEvent;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	[Bindable(name="phraseFound", type="com.katapultmedia.somo.events.PhraseEvent")]
	public class PhraseWatcher extends EventDispatcher{
		private var _phrase:String = "";
		public function get phrase():String{ return _phrase; }
		public function set phrase(value:String):void{
			_phrase = value;
			_currentPhrase = "";
		}
		
		private var _currentPhrase:String;
		public function get currentPhrase():String{ return _currentPhrase; }
		
		public function PhraseWatcher(stage:DisplayObject, phrase:String):void{
			super();
			
			if(stage == null) throw new ArgumentError("'stage' argument cannot be 'null'.");
			
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp, false, 0, true);
			
			this.phrase = phrase;
		}
		
		private function handleKeyUp(event:KeyboardEvent):void{
			var typedChar:String = String.fromCharCode(event.charCode);
			if(typedChar == _phrase.charAt(_currentPhrase.length)){
				_currentPhrase += typedChar;
				if(_currentPhrase == _phrase){
					_currentPhrase = "";
					
					var ev:PhraseEvent = new PhraseEvent(PhraseEvent.PHRASE_FOUND);
					ev.phrase = _phrase;
					dispatchEvent(ev);
				}
			}else{
				_currentPhrase = "";
			}
		}
	}
}
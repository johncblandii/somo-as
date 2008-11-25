package com.katapultmedia.somo.events{
	import flash.events.Event;

	public class PhraseEvent extends Event{
		public static const PHRASE_FOUND:String = "phraseFound";
		
		public var phrase:String;
		
		public function PhraseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}
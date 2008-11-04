package com.katapultmedia.somo.loggers 
{
	/**
	 * This is a simple class used for logging.
	 * 
	 * @example <listing version="3.0">OutputLogger.target = myObject;
	 * OutputLogger.logLine("hi mom", "this is my log entry");
	 * OutputLogger.logLine("another log entry");</listing>
	 * 
	 * @author John C. Bland II, john@katapultmedia.com
	 */	
	public class OutputLogger
	{
		private static var _enabled:Boolean = true;
		public static function get enabled():Boolean{ return _enabled; }
		public static function set enabled(value:Boolean):void{ _enabled = value; }
		
		private static var _target:Object;
		
		/**
		 * Current log target
		 * 
		 * @return Object
		 */
		public static function get target():Object{ return _target; }
		
		/**
		 * Sets the target Object for appending log entries
		 *  
		 * @param value 
		 */		
		public static function set target(value:Object):void{
			_target = value;
			_target.text = "Log Initialized - " + new Date().toDateString() + " :: " + new Date().toTimeString();
			_target.text += "\n----------\n\n";
		}
		
		/*
		 * When true, log format includes time.
		 */
		private static var _logDateEnabled:Boolean = true;
		public static function get logDateEnabled():Boolean{ return _logDateEnabled; }
		
		/**
		 * Controls whether the date/time is included in each log entry 
		 * @param value 
		 */		
		public static function set logDateEnabled(value:Boolean):void{ _logDateEnabled = value; }
		
		/**
		 * Sets the DateFormatter to anything other than the default format (LL:NN:SS A).
		 *  
		 * @param value
		 *		
		public static function set dateFormatter(value:DateFormatter):void{ _dateFormatter = value; }
		*/
		
		/**
		 * Clears the log contents
		 */
		public static function clear():void{
			try{
			_target.text = "";
			}catch(e:Object){}
		}
		
		/**
		 * Clears the current log then writes a new log entry, regardless of date settings.
		 * 
		 * <p>If a <code>target</code> has not been set, the arguments will be output via a <code>trace()</code> statement.</p> 
		 * 
		 * @param value Any traceable variable can be passed in. No special tracing will be performed for complex objects.
		 */
		public static function log(... args):void{
			clear();
			logLine(args);
		}
		
		/**
		 * Appends to the trace arguments to the log
		 * 
		 * <p>If a <code>target</code> has not been set, the arguments will be output via a <code>trace()</code> statement.</p>
		 * 
		 * @param args This is a rest argument so any number of arguments can be passed.
		 */
		public static function logLine(... args):void{
			if(!OutputLogger.enabled) return;
			
			var _date:Date = new Date();
			try{
				if(logDateEnabled){
					_target.text += _date.toTimeString() + " :: ";
				}
				
				var len:Number = args.length;
				for(var i:uint = 0; i <  len; i++){
					_target.text += args[i];
					
					if(i != len-1){
						_target.text += " - ";
					}
				}
				_target.text += "\n";
				_target.verticalScrollPosition = _target.maxVerticalScrollPosition;
			}catch(e:Object){
				trace(_date.toTimeString(), " :: ", args);
			}
		}
	}
}
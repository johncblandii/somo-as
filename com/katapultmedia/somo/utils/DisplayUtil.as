package com.katapultmedia.somo.utils 
{
	import flash.display.DisplayObjectContainer;
	
	/**
	* DisplayUtil
	* @author John C. Bland II, john@katapultmedia.com
	*/
	public class DisplayUtil 
	{
		public static function removeAllChildren(target:DisplayObjectContainer):void{
			try{
				while (target.numChildren > 0) target.removeChildAt(0);
			}catch (e:Error){
				//do nothing
			}
		}
	}
}
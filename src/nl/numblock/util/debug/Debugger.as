package nl.numblock.util.debug {
	
	import flash.utils.describeType;			import com.epologee.logging.Logee;	
	
	import flash.display.DisplayObjectContainer;	
	
	import com.carlcalderon.arthropod.Debug;	import com.foobr.FlashBug;		import flash.display.DisplayObject;	import flash.text.Font;		import nl.numblock.DebugSettings;	import nl.numblock.util.DisplayUtils;	import nl.numblock.util.data.Collection;		

	/**	 * @author Peter	 * To prevent the need for import we could move this class, 	 * together with the debugSettings en DebugInterests 	 * to the root source folder (not within a package).	 * But to prevent name conflicts with possible other 	 * debug classes we should kut FC (FlashClub) in front of the names.	 */	public class Debugger 	{				// Debug methods		public static const ARTHROPOD:String = "arthropod";		public static const TRACE:String = "trace";				public static const FLASH_BUG:String = "flashBug";		public static const ON_SCREEN:String = "onScreen";		public static const SOS:String = "SOS";				private static const LOCATION_EXTRACTOR:RegExp = /([^ ]*)\(\)+/g;		private static const LINE_NUMBER_EXTRACTOR:RegExp = /:[0-9]*]/g;				private static var _interests:Collection;			static public function log(msg:String,id:String,addLocation:Boolean = false):void		{			if(!hasId(id)) return;						if(addLocation && DebugSettings.METHOD != SOS)				msg += " @ "+location;						switch(DebugSettings.METHOD)			{				case ARTHROPOD:					Debug.log(msg);					break;				case FLASH_BUG:					FlashBug.debug(msg);					break;				case ON_SCREEN:					OnScreenDebugger.log(msg);					break;				case SOS:					Logee.debug(msg, location);					break;				case TRACE:				default:					trace(msg);					break;			}		}				static public function logDisplayList(target:DisplayObject,id:String,traceFunc:Function = null):void		{			if(!hasId(id)) return;			DisplayUtils.traceDisplayList(target,traceFunc);		}		static public function logParents(target:DisplayObject,id:String):void		{			if(!hasId(id)) return;						DisplayUtils.traceParents(target);		}		static public function logFonts(enumerateDeviceFonts:Boolean,id:String):void		{			var traceStr:String = "    Fonts: ";						var fonts:Array = Font.enumerateFonts(enumerateDeviceFonts);			for each(var font:Font in fonts)			{				traceStr += "\n        "+font.fontName+" ("+font.fontStyle+")";			}			log(traceStr,id);		}		static public function logObject(objectName:String, object:Object,id:String):void		{			var msg:String = logSubObject(objectName,object);						log(msg,id);		}				static private function logSubObject(objectName:String, object:Object,indent:String = "    "):String		{			var description:XML = describeType(object);						var qualifiedClassName:String = description.@name;			var className:String = qualifiedClassName.split("::")[1];			var msg:String = "\n"+indent+"[";			if(className == null)			{				for(var propName:String in object)				{					msg += getValueString(propName,object,indent);				}			}			else			{				msg += className;				var propNames:XMLList = description.variable.@name;							for each(propName in propNames)				{					msg += getValueString(propName,object,indent);				}				var accessorNames:XMLList = description.accessor.(@access != "writeonly").@name;				for each(var accessorName:String in accessorNames)				{					msg += getValueString(accessorName,object,indent);				}			}			msg += "\n"+indent+"]";						return msg;		}		static private function getValueString(propName:String,object:Object,indent:String):String		{			var value:* = object[propName];						if(value is String || value is int || value is uint || value is Number || value is Boolean)				value = "'"+value+"'";			else if(value is Object)				value = logSubObject(propName,value,indent+"  ");							var msg:String = "\n"+indent+"  "+propName+"="+value+"";			return msg;		}				static public function logStackTrace(id:String):void		{			if(!hasId(id)) return;			var stackTrace:String = (new Error()).getStackTrace();			stackTrace = stackTrace.replace("Error", "StackTrace: ");			log(stackTrace,id);		}		static private function get location():String		{			var stackTrace:String = (new Error()).getStackTrace();						var location:String = stackTrace.match(LOCATION_EXTRACTOR)[1];			var lineNumber:String = stackTrace.match(LINE_NUMBER_EXTRACTOR)[1];			return (location+lineNumber).replace("]","");		}		static public function logLocation(id:String):void		{			log(location, id);		}		static private function hasId(id:String):Boolean		{			if(_interests == null)			{				_interests = new Collection(DebugSettings.INTERESTS);			}			return _interests.has(id);		}				static public function get onScreenDebuggerContainer():DisplayObjectContainer		{			return OnScreenDebugger.container;		}		static public function set onScreenDebuggerContainer(newValue:DisplayObjectContainer):void		{			OnScreenDebugger.container = newValue;		}	}}
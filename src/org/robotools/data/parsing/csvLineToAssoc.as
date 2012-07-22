package org.robotools.data.parsing
{
	public function csvLineToAssoc( line:String, keys:Vector.<String> ):Object {
		var values:Vector.<String> = splitToVector( line, ";" );
		return CsvLineToAssocHelper.toAssoc( values, keys );
	}
}

internal class CsvLineToAssocHelper
{
	public static function toAssoc( values:Vector.<String>, keys:Vector.<String> ):Object {
		var assoc:Object = {};
		var i:int = -1;
		while(++i < keys.length) {
			var key:String = keys[i];
			var value:String = values[i];
			if(key != null && key != "") assoc[key] = value;
		}
		return assoc;
	}
}

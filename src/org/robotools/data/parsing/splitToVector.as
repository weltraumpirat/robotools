package org.robotools.data.parsing
{
	public function splitToVector( str:String, delimiter:* ):Vector.<String> {
		var arr:Array = str.split( delimiter );
		return Vector.<String>( arr );
	}
}

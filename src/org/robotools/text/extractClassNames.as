package org.robotools.text
{
	public function extractClassNames( text:String ):Array {
		var reg:RegExp = /(?<=class\=\")[A-Za-z0-9_-]*(?=\")/g;

		var array:Array = null;
		array = text.match( reg );

		return array;
	}
}

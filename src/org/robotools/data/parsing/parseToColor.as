package org.robotools.data.parsing
{
	public function parseToColor( col:String ):uint {
		var numToParse:String = ParseToColorHelper.getNumberToParse( col );
		if(!numToParse) return 0;
		var color:uint = uint( "0x"+numToParse );
		return isNaN( color ) ? 0 : color;
	}
}

internal class ParseToColorHelper
{
	public static function getNumberToParse( col:String ):String {
		var regExp:RegExp = /(?<=#)[0-9|A-F]{1,8}/i;
		return regExp.exec( col );
	}
}
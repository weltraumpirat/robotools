package org.robotools.text
{
	public function toCamelCase( str:String ):String {
		var ret:String = str;
		var index:int = ret.indexOf( "_" );
		while( index > -1 && index < ret.length-2) {
			var tmp:String = StringPartHelper.getFirstPart( ret, index );
			tmp += StringPartHelper.getCapitalizedLetterAfterIndex( ret, index );
			tmp += StringPartHelper.getRest( ret, index );
			ret = tmp;
			index = ret.indexOf( "_" );
		}
		return ret;
	}
}

internal class StringPartHelper
{
	public static function getFirstPart( str:String, index:int ):String {
		return str.substr( 0, index );
	}

	public static function getCapitalizedLetterAfterIndex( str:String, index:int ):String {
		return index < str.length ? str.charAt( index+1 ).toUpperCase() : "";
	}

	public static function getRest( str:String, index:int ):String {
		return index < str.length-3 ? str.substr( index+2 ) : "";
	}
}

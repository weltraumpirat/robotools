package org.robotools.data.parsing
{
	public function parseToFloat( float:String ):Number {
		if(float != null) {
			return ParseToFloatHelper.convertStringToFloat( float );
		} else return 0;
	}
}

internal class ParseToFloatHelper
{
	public static function convertStringToFloat( float:String ):Number {
		var numToParse:String = getNumberToParse( float );

		var fl:Number = parseFloat( numToParse );
		return isNaN( fl ) ? 0 : fl;
	}

	private static function getNumberToParse( float:String ):String {
		var reg:RegExp = /^[0-9]+(\.[0-9]+)?/;
		return reg.exec( float );
	}
}

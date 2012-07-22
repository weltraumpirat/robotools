package org.robotools.text
{
	public function csvToArray( data:String ):Array {
		var lines:Array = CSV.getLines( data );
		var keyArray:Array = CSV.getKeys( lines );
		return CSV.getAssocArray( lines );
	}
}


import org.robotools.data.parsing.csvLineToAssoc;
internal class CSV
{
	public static function getLines( data:String ):Array {
		return data.split( /\R/ );
	}

	public static function getKeys( lines:Array ):Array {
		return lines.splice( 0, 1 )[0].split( ";" );
	}

	public static function getAssocArray( lines:Array ):Array {
		var assocArray:Array = [];
		var keyArray : Array = getKeys(lines);
		for each(var line:String in lines)
			assocArray.push( csvLineToAssoc( line, Vector.<String>( keyArray ) ) );
		return assocArray;
	}
}
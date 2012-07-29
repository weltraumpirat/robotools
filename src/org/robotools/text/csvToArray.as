/* Copyright (c) 2012 Tobias Goeschel
 *
 * Permission is hereby granted, free of charge, to any person 
 * obtaining a copy of this software and associated documentation 
 * files (the "Software"), to deal in the Software without restriction, 
 * including without limitation the rights to use, copy, modify, merge, 
 * publish, distribute, sublicense, and/or sell copies of the Software, 
 * and to permit persons to whom the Software is furnished to do so, 
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included 
 * in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package org.robotools.text {
	public function csvToArray( data:String ):Array {
		var lines:Array = CSV.getLines( data );
		var keyArray:Array = CSV.getKeys( lines );
		return CSV.getAssocArray( lines );
	}
}

import org.robotools.data.parsing.csvLineToAssoc;

internal class CSV {
	public static function getLines( data:String ):Array {
		return data.split( /\R/ );
	}

	public static function getKeys( lines:Array ):Array {
		return lines.splice( 0, 1 )[0].split( ";" );
	}

	public static function getAssocArray( lines:Array ):Array {
		var assocArray:Array = [];
		var keyArray:Array = getKeys( lines );
		for each( var line:String in lines )
			assocArray.push( csvLineToAssoc( line, Vector.<String>( keyArray ) ) );
		return assocArray;
	}
}
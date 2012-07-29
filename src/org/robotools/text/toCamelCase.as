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
	public function toCamelCase( str:String ):String {
		var ret:String = str;
		var index:int = ret.indexOf( "_" );
		while( index>-1 && index<ret.length-2 ) {
			var tmp:String = StringPartHelper.getFirstPart( ret, index );
			tmp += StringPartHelper.getCapitalizedLetterAfterIndex( ret, index );
			tmp += StringPartHelper.getRest( ret, index );
			ret = tmp;
			index = ret.indexOf( "_" );
		}
		return ret;
	}
}

internal class StringPartHelper {
	public static function getFirstPart( str:String, index:int ):String {
		return str.substr( 0, index );
	}

	public static function getCapitalizedLetterAfterIndex( str:String, index:int ):String {
		return index<str.length ? str.charAt( index+1 ).toUpperCase() : "";
	}

	public static function getRest( str:String, index:int ):String {
		return index<str.length-3 ? str.substr( index+2 ) : "";
	}
}

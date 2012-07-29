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
package org.robotools.data.copy {
	/**
	 * Returns the value of the field with the given name, if it
	 * does exist and has a valid value, or the provided default value.
	 *
	 * @param target Any object instance.
	 * @param name The name of the field to return.
	 * @param defaultValue The value to return if the field does not contain a valid value.
	 * @return The field value if it is valid, or the default value if the field is
	 *             <code>null</code>, if any errors occur or a number type is <code>NaN</code>.
	 */

	public function safeGetPropertyOrDefault( target:*, name:String, defaultValue:* ):* {
		var result:*;
		try {
			result = target[name];
		} catch( e:Error ) {
		}
		return result == null || ((result is Number || result is int || result is uint ) && isNaN( result )) ?
			   defaultValue : result;
	}
}

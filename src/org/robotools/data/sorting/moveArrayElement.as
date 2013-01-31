/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package org.robotools.data.sorting {
	/**
	 * Moves one element of an array to another index, shifting the other elements in between.
	 * I.e.:  moveArrayElement( [0,1,2,3], 1, 3) returns [0,2,3,1] (1 has moved from index 1 to index 3).
	 * Warning: This method does not return a copy of the array. It modifies the actual variable that was originally passed in.
	 *
	 * @param arr   The array to manipulate.
	 * @param from  The index from which to move the element
	 * @param to    The index where the element should be placed
	 * @return The modified Array.
	 */
	public function moveArrayElement( arr:Array, from:int, to:int ):Array {
		return from == to ? arr :
			   from>to ? moveArrayElementRight( arr, from, to ) : moveArrayElementLeft( arr, from, to );
	}
}

internal function moveArrayElementLeft( arr:Array, from:int, to:int ):Array {
	var movedItem:* = arr[from];
	var i:int = from;
	while( ++i<=to )
		arr[i-1] = arr[i];
	arr[to] = movedItem;
	return arr;
}

internal function moveArrayElementRight( arr:Array, from:int, to:int ):Array {
	var movedItem:* = arr[from];
	var i:int = from;
	while( --i>=to )
		arr[i+1] = arr[i];
	arr[to] = movedItem;
	return arr;
}
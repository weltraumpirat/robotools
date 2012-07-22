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
package org.robotools.data.copy
{
	import org.as3commons.reflect.Type;

	public function shallowCopy( from:* ):* {
		var type:Type = Type.forInstance( from );
		return ShallowObjectCopy.toType( from, type );
	}
}
import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Type;
import org.as3commons.reflect.Variable;


internal class ShallowObjectCopy
{
	public static function toType( from:*, type:Type ):* {
		if(isComplexType( type.name ))
			return toComplexType( from, type );
		else
			return from;
	}

	private static function isComplexType( typeName:String ):Boolean {
		const PRIMITIVE_TYPES:Array = ["int", "uint", "String", "Number"];
		return PRIMITIVE_TYPES.indexOf( typeName ) == -1;
	}

	private static function toComplexType( from:*, type:Type ):* {
		var to:* = new type.clazz();
		if(isArrayType( type.name ))
			copyElements( from, to );
		else
			copyValues( from, to, type );
		return to;
	}

	private static function isArrayType( typeName:String ):Boolean {
		return typeName == "Array" || typeName.indexOf( "Vector.<" ) >= 0;
	}

	private static function copyElements( from:*, to:* ):void {
		for(var i:int = 0; i < from.length; i++)
			to[i] = from[i];
	}

	public static function copyValues( from:*, to:*, type:Type ):void {
		copyProperties( from, to );
		copyAccessors( type, to, from );
		copyVariables( type, to, from );
	}

	public static function copyProperties( from:*, to:* ):void {
		for(var key:String in from)
			copyValue( to, key, from );
	}

	public static function copyAccessors( type:Type, to:*, from:* ):void {
		for each(var accessor:Accessor in type.accessors)
			if(accessor.isWriteable())
				copyValue( to, accessor.name, from );
	}

	private static function copyVariables( type:Type, to:*, from:* ):void {
		for each(var variable:Variable in type.variables)
			copyValue( to, variable.name, from );
	}

	private static function copyValue( to:*, field:String, from:* ):void {
		try {
			to[field] = from[field];
		} catch (e:Error) {
		}
	}
}
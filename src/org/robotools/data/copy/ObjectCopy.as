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
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;


	internal class ObjectCopy
	{
		public static function toType( from:*, type:Type ):* {
			if(isComplexType( type.name ))
				return toComplexType( from, type );
			else
				return from;
		}

		public static function copyValues( from:*, to:*, type:Type ):void {
			copyProperties( from, to );
			copyAccessors( type, to, from );
			copyVariables( type, to, from );
		}

		private static function isComplexType( typeName:String ):Boolean {
			const PRIMITIVE_TYPES:Array = ["int", "uint", "String", "Number"];
			return PRIMITIVE_TYPES.indexOf( typeName ) == -1;
		}

		private static function toComplexType( from:*, type:Type ):* {
			var to:* = new type.clazz();
			if(isArrayType( type.name )) copyElements( from, to );
			else
				copyValues( from, to, type );
			return to;
		}
		
		private static function isArrayType( typeName:String ):Boolean {
			return typeName == "Array" || typeName.indexOf( "Vector.<" ) >= 0;
		}

		private static function copyElements( from:*, to:* ):void {
			for(var i:int = 0; i < from.length; i++) {
				to[i] = copy( from[i] );
			}
		}

		public static function copyProperties( from:*, to:* ):void {
			for(var key:String in from)
				copyPropertyValue( to, key, from );
		}

		private static function copyPropertyValue( to:*, key:String, from:* ):void {
			try {
				to[key] = copy( from[key] );
			} catch (e:Error) {
			}
		}

		public static function copyAccessors( type:Type, to:*, from:* ):void {
			for each(var accessor:Accessor in type.accessors)
				if(accessor.isWriteable()) copyAccessorValue( to, accessor, from );
		}

		private static function copyAccessorValue( to:*, accessor:Accessor, from:* ):void {
			try {
				to[accessor.name] = copy( from[accessor.name] );
			} catch (e:Error) {
			}
		}

		private static function copyVariables( type:Type, to:*, from:* ):void {
			for each(var variable:Variable in type.variables)
				copyVariableValue( to, variable, from );
		}

		private static function copyVariableValue( to:*, variable:Variable, from:* ):void {
			try {
				to[variable.name] = copy( from[variable.name] );
			} catch (e:Error) {
			}
		}
	}
}

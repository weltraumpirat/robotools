/*
 * Copyright (c) 2013 Tobias Goeschel.
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
package org.robotools.data.copy {
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;
	import org.robotools.data.enumerateFields;

	/**
	 * Copies all primitive field values from the source to the target.
	 *
	 * Essentially, this does the same thing as safeCopyProperties(), but for
	 * non-dynamic classes.
	 *
	 * @param from Any object instance.
	 * @param to Any other object instance.
	 * @param type The desired target type.
	 * @return The target instance.
	 */
	public function safeCopyFields( from:*, to:*, type:Type = null ):* {
		var toType:Type = type ? type : Type.forInstance( to );
		var props:Array = enumerateFields( from );

		for each( var acc:Accessor in toType.accessors )
			if( props.indexOf( acc.name )> -1 && acc.isWriteable() )
				try{
					to[acc.name] = from[acc.name];
				} catch( ignore:Error) {}

		for each( var variable:Variable in toType.variables )
			if( props.indexOf( variable.name )> -1 )
				try {
					to[variable.name] = from[variable.name];
				} catch( ignore:Error ) {}

		return to;
	}
}

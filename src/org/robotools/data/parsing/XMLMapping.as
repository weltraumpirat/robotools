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

package org.robotools.data.parsing {
	public class XMLMapping {
		private var _clazz:Class;

		/**
		 * Constructor
		 * @param clazz The type that should be created when this mapping is triggered.
		 */
		public function XMLMapping( clazz:Class ) {
			_clazz = clazz;
		}

		/**
		 * Creates a new object of the specified type from the XML given.
		 * @param node The XML to parse.
		 * @return An object of the specified type for this XMLMapping.
		 */
		public function map( node:XML ): * {
			var obj:* = new _clazz();
			obj = copyAttributes( node, obj );
			return obj;
		}

		private function copyAttributes( node:XML, obj:* ):* {
			for each( var attr:XML in node.attributes() )
				obj = copyAttribute( attr, obj );
			return obj;
		}

		private function copyAttribute( attr:XML, obj:* ):* {
			try {
				obj[attr.name().toString()] = attr.valueOf().toString();
			} catch( ignore:Error ) {
			}
			return obj;
		}

		/**
		 * Returns the type associated with this XMLMapping.
		 */
		public function get clazz():Class {
			return _clazz;
		}
	}
}

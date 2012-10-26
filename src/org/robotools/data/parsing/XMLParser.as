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
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;

	import org.robotools.data.XMLMapping;
	import org.robotools.text.plural;

	public class XMLParser {
		private var _mappings:Dictionary;

		public function XMLParser() {
			_mappings = new Dictionary();
		}

		public function destroy():void {
			_mappings = null;
		}

		public function get mappings():Dictionary {
			return _mappings;
		}

		public function addMapping( nodeName:String, mapping:XMLMapping ):void {
			_mappings[nodeName] = mapping;
		}

		public function parse( node:XML ):* {
			return applyMapping( node );
		}

		private function applyMapping( node:XML ):* {
			var mapping:XMLMapping = mappings[node.name()];
			var ret:* = mapping.map( node );
			ret = mapChildNodes( node, ret );
			return ret;
		}

		private function mapChildNodes( node:XML, ret:* ):* {
			try {
				for each( var child:XML in node.elements() ) {
					var childObj:* = applyMapping( child );
					var name:String = plural( child.name() );
					ret[name] ||= new ArrayCollection();
					ret[name].addItem( childObj );
				}
			} catch( ignore:Error ) {
			}
			return ret;
		}
	}
}

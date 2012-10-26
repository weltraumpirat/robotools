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

	import org.robotools.text.plural;

	public class XMLParser {
		private var _mappings:Dictionary;
		private var _nameMap:Object;

		public function XMLParser() {
			_nameMap = {};
			_mappings = new Dictionary();
			addMapping( "__default", new XMLMapping( Object ) );
		}

		public function destroy():void {
			_mappings = null;
		}

		public function get mappings():Dictionary {
			return _mappings;
		}

		public function addMapping( nodeName:String, mapping:XMLMapping, mappedElementName:String = null ):void {
			_mappings[nodeName] = mapping;
			_nameMap[nodeName] = mappedElementName;
		}

		public function parse( node:XML ):* {
			var ret:* = applyMapping( node );
			trace( node.name()+" => "+ret );
			return ret;
		}

		private function applyMapping( node:XML ):* {
			var mapName:String = node.name().toString();
			mapName = mappings.hasOwnProperty( mapName ) ? mapName : "__default";
			var mapping:XMLMapping = mappings[mapName];
			var ret:* = mapping.map( node );
			ret = mapChildNodes( node, ret );
			return ret;
		}

		private function mapChildNodes( node:XML, ret:* ):* {
			for each( var child:XML in node.elements() ) {
				try {
					var childObj:* = applyMapping( child );
					var childName:String = child.name().toString();
					_nameMap[childName] ||= plural(childName);
					var propertyName:String = _nameMap[childName];
					trace( childName+" => "+propertyName);
					ret[propertyName] ||= new ArrayCollection();
					ret[propertyName].addItem( childObj );
				}
				catch( ignore:Error ) {
					trace(ignore.message);
				}
			}
			return ret;
		}
	}
}

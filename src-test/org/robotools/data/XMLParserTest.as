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

package org.robotools.data {
	import flash.geom.Rectangle;

	import org.flexunit.assertThat;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.hamcrest.object.instanceOf;
	import org.robotools.data.parsing.XMLMapping;
	import org.robotools.data.parsing.XMLParser;

	public class XMLParserTest {
		private var parser:XMLParser;

		[Before]
		public function setUp():void {
			parser = new XMLParser();
		}

		[Test]
		public function containsDefaultMapping():void {
			var mapping:XMLMapping = parser.mappings["__default"];
			assertNotNull( mapping);
			assertEquals( Object,  mapping.clazz);
		}

		[Test]
		public function addsAMapping():void {
			var mapping:XMLMapping = new XMLMapping(Object);
			parser.addMapping( "something", mapping);
			assertEquals( mapping, parser.mappings["something"] );
		}

		[Test]
		public function returnsMappedObjectForNode():void {
		  	parser.addMapping("rect", new XMLMapping( Rectangle ));
			var parsed:* = parser.parse( <rect /> );
			assertThat( parsed, instanceOf( Rectangle ));
		}

		[Test]
		public function copiesObjectAttributes	():void {
			parser.addMapping("rect", new XMLMapping( Rectangle ));
			var parsed:* = parser.parse(<rect x="10" y="20" width="30" height="40" />);
			assertEquals( 10, parsed.x );
			assertEquals( 20, parsed.y );
			assertEquals( 30, parsed.width );
			assertEquals( 40, parsed.height );
		}

		[Test]
		public function noErrorsWhenUnknownAttributesAreEncountered():void {
			parser.addMapping("rect", new XMLMapping( Rectangle ));
			var parsed:* = parser.parse(<rect whatever="something" />);
		}

		[Test]
		public function mapsChildObjects ():void {
			parser.addMapping( "container", new XMLMapping( Object ));
			parser.addMapping( "rect", new XMLMapping( Rectangle ));
			var parsed:* = parser.parse(<container><rect /><rect /></container>);
			assertThat ( parsed.rects.getItemAt(0), instanceOf( Rectangle ));
		}

		[Test]
		public function mapsChildElementNamesToPluralIfNoNameMappingIsGiven():void {
			parser.addMapping( "container", new XMLMapping( Object ));
			parser.addMapping( "rect", new XMLMapping( Rectangle ));
			var parsed:* = parser.parse(<container><rect /><rect /></container>);
			assertNotNull ( parsed.rects );
		}

		[Test]
		public function explicitlyMapsChildElementNames():void {
			parser.addMapping( "container", new XMLMapping( Object ));
			parser.addMapping( "rect", new XMLMapping( Rectangle ), "rectangles");
			var parsed:* = parser.parse(<container><rect /><rect /></container>);
			assertNotNull ( parsed.rectangles );
		}

		[Test]
		public function unknownNodeNamesAreMappedToObject():void {
			var parsed:*=parser.parse(<unknown />);
			assertNotNull( parsed );
		}

		[Test]
		public function cleansUpNicely() : void {
			assertNotNull(parser.mappings);
			parser.destroy();
			assertNull( parser.mappings );
		}

		[After]
		public function tearDown():void {
			parser = null;
		}
	}
}
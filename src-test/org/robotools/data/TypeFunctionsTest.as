package org.robotools.data
{
	import flashx.textLayout.formats.TextLayoutFormat;

	import org.as3commons.reflect.Type;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.data.comparison.equalAsString;
	import org.robotools.data.comparison.equals;
	import org.robotools.data.copy.copy;
	import org.robotools.data.copy.safeCopyProperties;
	import org.robotools.data.copy.safeGetPropertyOrDefault;
	import org.robotools.data.parsing.csvLineToAssoc;
	import org.robotools.data.parsing.parseToColor;
	import org.robotools.data.parsing.parseToFloat;
	import org.robotools.data.parsing.parseToInt;
	import org.robotools.data.parsing.splitToVector;
	import org.robotools.data.parsing.stringPropertyToType;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;




	public class TypeFunctionsTest
	{
		[Before]
		public function setUp():void {
		}

		[Test]
		public function parsesStringToColor():void {
			assertEquals( 0, parseToColor( null ) );
			assertEquals( 0, parseToColor( "something else than a color value" ) );
			assertEquals( 0, parseToColor( "#something else than a color value" ) );
			assertEquals( 0, parseToColor( "000000ValueWithoutA#" ) );
			assertEquals( 0, parseToColor( "#000000" ) );
			assertEquals( 1, parseToColor( "#000001" ) );
			assertEquals( 2, parseToColor( "#000002" ) );
			assertEquals( 255, parseToColor( "#0000FF" ) );
			assertEquals( 65535, parseToColor( "#00FFFF" ) );
			assertEquals( 16777215, parseToColor( "#FFFFFF" ) );
			assertEquals( 16777215, parseToColor( "#FFFFFFValueWithTrailingStuff" ) );
			assertEquals( 4294967295, parseToColor( "#FFFFFFFF" ) );
			assertEquals( 4294967295, parseToColor( "#ffffffff" ) );
		}

		[Test]
		public function parsesStringToFloat():void {
			assertEquals( 0, parseToFloat( null ) );
			assertEquals( 0, parseToFloat( "something else than a Number" ) );
			assertEquals( 1, parseToFloat( "1" ) );
			assertEquals( 1.1, parseToFloat( "1.1" ) );
			assertEquals( 1.1, parseToFloat( "1.1.1.1" ) );
			assertEquals( 1.1, parseToFloat( "1.1AndSomeOtherTrailingStuff" ) );
		}

		[Test]
		public function parsesStringToInt():void {
			assertEquals( 0, parseToInt( null ) );
			assertEquals( 0, parseToInt( "something else than an int" ) );
			assertEquals( 1, parseToInt( "1" ) );
			assertEquals( 1, parseToInt( "1.1" ) );
			assertEquals( 1, parseToInt( "1AndSomeOtherTrailingStuff" ) );
		}

		[Test]
		public function parsesValuesFromStringProperties():void {
			var obj:Object = {string:"test", number:"1.2", u_int:"#0000FF", _int:"1"};

			assertEquals( "test", stringPropertyToType( obj, "string", String ) );
			assertEquals( "test", stringPropertyToType( obj, "string", Rectangle ) );
			assertEquals( "test", stringPropertyToType( obj, "string", Dictionary ) );
			assertEquals( "test", stringPropertyToType( obj, "string", Vector ) );
			assertEquals( 1.2, stringPropertyToType( obj, "number", Number ) );
			assertEquals( 255, stringPropertyToType( obj, "u_int", uint ) );
			assertEquals( 1, stringPropertyToType( obj, "_int", int ) );

			assertNull( stringPropertyToType( obj, "something_else", Object ) );
		}

		[Test]
		public function countsDynamicProperties():void {
			var inObj:Object = {one:"one", two:"two"};
			assertEquals( 2, propertyCount( inObj ) );
		}

		[Test]
		public function checksForEqualStringValues():void {
			var str1:String = "one";
			var str2:String = "one";

			assertTrue( equalAsString( str1, str2 ) );
			str2 = "two";
			assertFalse( equalAsString( str1, str2 ) );

			var obj:Object = {};
			obj.toString = function():String {
				return "one";
			};
			assertTrue( equalAsString( str1, obj ) );
			assertFalse( equalAsString( str2, obj ) );
		}

		[Test]
		public function splitsLineFromCsvAndTransformsToAssociativeArray():void {
			var propertyTitles:Vector.<String> = new <String>["property1", "property2"];
			var lineToParse:String = "1;2";
			var result:Object = csvLineToAssoc( lineToParse, propertyTitles );

			assertEquals( "1", result.property1 );
			assertEquals( "2", result.property2 );
		}

		[Test]
		public function splitsStringToStringVector():void {
			var str:String = "A;test";
			var vect:Vector.<String> = splitToVector( str, ";" );
			assertEquals( "A", vect[0] );
			assertEquals( "test", vect[1] );
		}

		[Test]
		public function copiesDynamicProperties():void {
			var inObj:Object = {one:"one", two:"two"};
			var outObj:Object = copy( inObj );

			assertEquals( "one", outObj.one );
			assertEquals( "two", outObj.two );
		}
		
		
		
		[Test]
		public function copiesSafeDynamicProperiesAccordingToType () : void 
		{
			var inObj:Object = {fontFamily:"Arial", fontSize:12, fontWeight:"bold", color:0x223455, arbitrary:"value"};
			var outObj:Object = {};
			outObj = safeCopyProperties( inObj, outObj, Type.forClass(TextLayoutFormat) );

			assertEquals( "Arial", outObj.fontFamily );
			assertEquals( "bold", outObj.fontWeight );
			assertFalse( outObj.hasOwnProperty("arbitrary") );
		}
		
		[Test]
		public function getsSafeDynamicPropertyOrDefaultValue () : void 
		{
			var obj:Object = {fontFamily:"Arial", nullValue:null, fontSize:12, someValue:NaN};
			assertEquals( "Arial", safeGetPropertyOrDefault( obj, "fontFamily", "no value"));
			assertEquals( "no value", safeGetPropertyOrDefault( obj, "nullValue", "no value"));
			assertEquals( 12, safeGetPropertyOrDefault( obj, "fontSize", 0));
			assertEquals( 0, safeGetPropertyOrDefault( obj, "someValue", 0));
			assertEquals( "no value", safeGetPropertyOrDefault( obj, "nonexistantField", "no value"));
			assertEquals( 0, safeGetPropertyOrDefault( obj, "nonexistantField", 0));
		}

		[Test]
		public function copiesValuesFromAccessors():void {
			var inRect:Rectangle = new Rectangle( 0, 100, 200, 10 );
			var outRect:Rectangle = copy( inRect ) as Rectangle;

			assertEquals( 0, outRect.x );
			assertEquals( 100, outRect.y );
			assertEquals( 200, outRect.width );
			assertEquals( 10, outRect.height );
		}

		[Test]
		public function copiesValuesFromArrays():void {
			var inObj:Array = ["one", "two", "three", {"four":"four", "five":"five"}];
			var outObj:Array = copy( inObj );

			assertEquals( "one", outObj[0] );
			assertEquals( "two", outObj[1] );
			assertEquals( "three", outObj[2] );
			assertEquals( "four", outObj[3].four );
			assertEquals( "five", outObj[3].five );
			assertFalse( inObj == outObj );
			assertFalse( inObj === outObj );
		}

		[Test]
		public function copiesValuesFromVectors():void {
			var inObj:Vector.<Object> = new <Object>["one", "two", "three", {"four":"four", "five":"five"}];
			var outObj:Vector.<Object> = copy( inObj );

			assertEquals( "one", outObj[0] );
			assertEquals( "two", outObj[1] );
			assertEquals( "three", outObj[2] );
			assertEquals( "four", outObj[3].four );
			assertEquals( "five", outObj[3].five );
			assertFalse( inObj == outObj );
			assertFalse( inObj === outObj );
		}

		[Test]
		public function testsEqualityBasedOnPrimitiveValue():void {
			assertTrue( equals( 1, 1 ) );
			assertTrue( equals( 1, "1" ) );
			assertTrue( equals( 1, 1.0 ) );
			assertTrue( equals( 0, 0x000000 ) );

			assertFalse( equals( 1, 2 ) );
			assertFalse( equals( 1, 1.1 ) );
			assertFalse( equals( 1, "2" ) );
			assertFalse( equals( 1, 0x00000F ) );
		}

		[Test]
		public function testsEqualityBasedOnArrayValues():void {
			var arr1:Array = ["one", "two", "three"];
			var arr2:Array = ["one", "two", "three"];

			assertTrue( equals( arr1, arr2 ) );

			arr1 = [1, 2, 3];
			arr2 = ["1", "2", "3"];

			assertTrue( equals( arr1, arr2 ) );

			var vec:Vector.<int> = new <int>[1, 2, 3];
			assertTrue( equals( arr1, vec ) );
		}

		[Test]
		public function testsEqualityBasedOnPropertyValues():void {
			var obj:Object = {"one":"one", two:{two:"two", three:["three", 3, 4, 5], four:new <int>[1,2,3]} };
			var obj2:Object = {"one":"one", two:{two:"two", three:["three", 3, 4, 5], four:new <int>[1,2,3]} };
			var obj3:Object = {"one":"1", two:{two:"2", three:["3", 3, 4, 5], four:new <int>[1,2,3]} };
			
			assertTrue (equals (obj, obj2));
			assertFalse (equals (obj, obj3));
			assertFalse (equals (obj, 1));
			assertFalse (equals(obj, "2"));
		}

		[After]
		public function tearDown():void {
		}
	}
}

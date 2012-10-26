package org.robotools.text
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.text.endsWith;

	public class TextFunctionsTest
	{
		private var tx:String = <p class="text"><span class="anothertext"></span></p>.toXMLString();

		private var tx2:String = <p class="text_with_underscores"><span class="text-with-dashes"></span></p>.toXMLString();

		[Before]
		public function setUp():void {
		}

		[Test]
		public function checksIfAStringEndsWithTheGivenSubstring():void {
			assertTrue( endsWith("task","k"));
			assertFalse( endsWith("task","s"));
		}

		[Test]
		public function givesProperPluralForm():void {
			assertEquals( "tasks", plural("tasks"));
			assertEquals( "ceremonies", plural("ceremony"));
			assertEquals( "kisses", plural("kiss"));
			assertEquals( "keys", plural("key"));
			assertEquals( "harmonicas", plural("harmonica"));
			assertEquals( "responses", plural("response") );
		}

		[Test]
		public function convertsBrToNewLine():void {
			var str:String = "this<br /> is <br /> a <br /> test <br />.";
			var resultStr:String = "this\n is \n a \n test \n.";
			var changed:String = brToNewline( str );
			assertEquals( resultStr, changed );

			str = "this<br> is <br> a <br> test <br></br>.";
			changed = brToNewline( str );
			assertEquals( str, changed );
		}

		[Test]
		public function extractsClassNames():void {
			var arr:Array = extractClassNames( tx );
			assertNotNull( arr );
			assertEquals( 2, arr.length );
			assertEquals( "text", arr[0] );
			assertEquals( "anothertext", arr[1] );
			arr = null;

			arr = extractClassNames( "some text without class name" );
			assertNotNull( arr );
			assertEquals( 0, arr.length );
			arr = null;

			arr = extractClassNames( tx2 );
			assertNotNull( arr );
			assertEquals( 2, arr.length );
			assertEquals( "text_with_underscores", arr[0] );
			assertTrue( "text-with-dashes", arr[1] );
		}

		[Test]
		public function getsDateAsString():void {
			var date:Date = new Date( 2011, 10, 6, 11, 5, 35 );
			var str:String = dateAsString( date );
			assertEquals( "06-11-2011", str );
		}

		[Test]
		public function getTimeAsString():void {
			var date:Date = new Date( 2011, 10, 6, 11, 5, 35 );
			var str:String = timeAsString( date );
			assertEquals( "11-05-35", str );
		}

		[Test]
		public function checksIfStringIsEmail():void {
			assertTrue( isEmail( "huhu@huhu.de" ) );
			assertTrue( isEmail( "123@123.de" ) );
			assertFalse( isEmail( "asd@asd.asd" ) );
			assertFalse( isEmail( "huhu@hu@hu.de" ) );
			assertTrue( isEmail( "huhu@hu.hu.de" ) );
			assertTrue( isEmail( "hu.hu@huhu.de" ) );
			assertTrue( isEmail( "asdf.234@huhu.de" ) );
			assertFalse( isEmail( "hu.__SFHUEZRHj--asdfawer@huhu.de" ) );
			assertFalse( isEmail( "_#+24567@huhu.de" ) );
			assertFalse( isEmail( "huhu@ä25678|{«}¢®.de" ) );
			assertFalse( isEmail( "234z9° @huhu.de" ) );
		}

		[Test]
		public function checksIfStringIsFloat():void {
			assertFalse( isFloat( "0000" ) );
			assertFalse( isFloat( "9907" ) );
			assertFalse( isFloat( "3434678" ) );
			assertFalse( isFloat( "235673849657892463578964378965789367589" ) );
			assertFalse( isFloat( "asdfasdf" ) );
			assertFalse( isFloat( "___fsdf_" ) );
			assertFalse( isFloat( "__a0000" ) );
			assertFalse( isFloat( "__0100" ) );
			assertFalse( isFloat( "a000sadf" ) );
			assertFalse( isFloat( "))/§%fJAsdas" ) );
			assertFalse( isFloat( "(0000" ) );
			assertFalse( isFloat( "/%0A00dasd0" ) );
			assertTrue( isFloat( "15.010" ) );
			assertFalse( isFloat( "15.010.1010" ) );
			assertTrue( isFloat( "0.00" ) );
		}

		[Test]
		public function checksIfStringIsInteger():void {
			assertTrue( isInteger( "0000" ) );
			assertTrue( isInteger( "9907" ) );
			assertTrue( isInteger( "3434678" ) );
			assertTrue( isInteger( "235673849657892463578964378965789367589" ) );
			assertFalse( isInteger( "asdfasdf" ) );
			assertFalse( isInteger( "___fsdf_" ) );
			assertFalse( isInteger( "__a0000" ) );
			assertFalse( isInteger( "__0100" ) );
			assertFalse( isInteger( "a000sadf" ) );
			assertFalse( isInteger( "))/§%fJAsdas" ) );
			assertFalse( isInteger( "(0000" ) );
			assertFalse( isInteger( "/%0A00dasd0" ) );
			assertFalse( isInteger( "15.010" ) );
		}

		[Test]
		public function joinsStringsWithSeparator():void {
			assertEquals( "one.two.three", joinStrings( ".", "one", "two", "three" ) );
			assertEquals( "oneDOTtwoDOTthree", joinStrings( "DOT", "one", "two", "three" ) );
		}

		[Test]
		public function convertslineBreaksToBr():void {
			var str:String = "this\n is \n a \n test \n.";
			var resultStr:String = "this<br /> is <br /> a <br /> test <br />.";
			var changed:String = lineBreaksToBr( str );
			assertEquals( resultStr, changed );

			str = "this\r is \n a \r test \n.";
			changed = lineBreaksToBr( str );
			assertEquals( resultStr, changed );
		}

		[Test]
		public function normalizesLineBreaks():void {
			var str:String = "this\r is \n a \r\r test    \n.";
			var resultStr:String = "this\n is \n a \n\n test    \n.";
			var changed:String = normalizeLineBreaks( str );
			assertEquals( resultStr, changed );
		}

		[Test]
		public function stripsLeadingAndTrailingWhitespace():void {
			assertEquals( "ein Text", stripLeadingAndTrailingWhitespace( " ein Text " ) );
			assertEquals( "ein Text", stripLeadingAndTrailingWhitespace( "\rein Text\n" ) );
			assertEquals( "ein Text", stripLeadingAndTrailingWhitespace( "\r\n\r ein Text " ) );
			assertEquals( "ein Text", stripLeadingAndTrailingWhitespace( "ein Text " ) );
			assertEquals( "ein Text", stripLeadingAndTrailingWhitespace( " ein Text" ) );
		}

		[Test]
		public function normalizesMultipleLinesByStrippingAwayLeadingAndTrailingWhitespace():void {
			var str:String = "this\r is \n a \r\r test    \n.";
			var resultStr:String = "this\nis\na\ntest\n.";
			var changed:String = stripLeadingAndTrailingWhitespace( str );
			assertEquals( resultStr, changed );
		}

		[Test]
		public function stripsLeadingWhitespace():void {
			assertEquals( "ein Text", stripLeadingWhitespace( " ein Text" ) );
			assertEquals( "ein Text", stripLeadingWhitespace( "  ein Text" ) );
			assertEquals( "ein Text", stripLeadingWhitespace( " \tein Text" ) );
			assertEquals( "ein Text", stripLeadingWhitespace( " \r\rein Text" ) );
			assertEquals( "ein Text", stripLeadingWhitespace( " \r\n\tein Text" ) );
			assertEquals( "ein Text ", stripLeadingWhitespace( " \r\n\tein Text " ) );
			assertEquals( "ein Text\n", stripLeadingWhitespace( " \r\n\tein Text\r  " ) );
			assertEquals( "ein Text\n.", stripLeadingWhitespace( " \r\n\tein Text\r  ." ) );
		}

		[Test]
		public function stripsTrailingWhitespace():void {
			assertEquals( "ein Text", stripTrailingWhitespace( "ein Text " ) );
			assertEquals( "ein Text", stripTrailingWhitespace( "ein Text\r" ) );
			assertEquals( "ein Text", stripTrailingWhitespace( "ein Text \n" ) );
			assertEquals( "ein Text", stripTrailingWhitespace( "ein Text \r\n\t" ) );
			assertEquals( "\nein Text", stripTrailingWhitespace( " \nein Text \r\n\t" ) );
			assertEquals( "\n \tein Text", stripTrailingWhitespace( "\r \tein Text \r\n\t" ) );
		}

		[Test]
		public function stripsLineBreaks():void {
			assertEquals( " ein Text ", stripLineBreaks( "\r \tein Text \r\n\t" ) );
			assertEquals( "ein Text", stripLineBreaks( "\tein\r\n\t Text\t\t\r" ) );
		}

		[Test]
		public function normalizesWhitespace():void {
			var str:String = "This \n is\ta\r  \t\r\ntest.";
			var resultStr:String = "This is a test.";
			var changed:String = normalizeWhitespace( str );
			assertEquals( resultStr, changed );
		}

		[Test]
		public function transformsUnderscoresToCamelCase():void {
			var str:String = "a_test_string";
			var changed:String = toCamelCase( str );
			assertEquals( "aTestString", changed );
		}

		[After]
		public function tearDown():void {
		}
	}
}

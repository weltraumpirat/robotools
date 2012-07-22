package org.robotools.data
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.data.copy.shallowCopy;

	import flash.display.MovieClip;


	public class ShallowCopyTest
	{
		private var itemToCopy:*;

		private var copiedItem:*;

		[Before]
		public function setUp():void {
			itemToCopy = new MovieClip();
			itemToCopy.anotherClip = new MovieClip();
			itemToCopy.someValue = "someValue";
		}

		[Test]
		public function makesAShallowCopyWithDynamicProperties():void {
			copiedItem = shallowCopy( itemToCopy );
			assertEquals( "someValue", copiedItem.someValue );
			assertNotNull( copiedItem.anotherClip );
			assertTrue( itemToCopy.anotherClip == copiedItem.anotherClip );
		}

		[Test]
		public function makesAShallowCopyOfAStronglyTypedClass():void {
			itemToCopy = new TestClass();
			itemToCopy.value1 = 1;
			itemToCopy.value2 = "SomeValue";
			var nestedObj:Object = {};
			itemToCopy.value3 = nestedObj;

			copiedItem = shallowCopy( itemToCopy );
			assertEquals( 1, copiedItem.value1 );
			assertEquals( "SomeValue", copiedItem.value2 );
			assertEquals( nestedObj, copiedItem.value3 );
		}

		[After]
		public function tearDown():void {
			itemToCopy = null;
			copiedItem = null;
		}
	}
}



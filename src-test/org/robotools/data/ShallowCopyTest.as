package org.robotools.data
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.robotools.data.copy.shallowCopy;

	import flash.display.MovieClip;


	public class ShallowCopyTest
	{
		private var itemToCopy:MovieClip;

		private var copiedItem:MovieClip;

		[Before]
		public function setUp():void {
			itemToCopy = new MovieClip();
			itemToCopy.anotherClip = new MovieClip();
			itemToCopy.someValue = "someValue";
		}

		[Test]
		public function makesAShallowCopy():void {
			copiedItem = shallowCopy( itemToCopy );
			assertEquals( "someValue", copiedItem.someValue );
			assertNotNull( copiedItem.anotherClip );
			assertTrue( itemToCopy.anotherClip == copiedItem.anotherClip );
		}

		[After]
		public function tearDown():void {
			itemToCopy = null;
			copiedItem = null;
		}
	}
}

package org.robotools.graphics
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotools.graphics.drawing.GraphRectangle;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;



	public class GraphicsFunctionsTest
	{
		private var container:Sprite;

		[Before]
		public function setUp():void {
			container = new Sprite();
		}

		[Test]
		public function bringsDisplayObjectToFront():void {
			var child1:Sprite = new Sprite();
			var child2:Sprite = new Sprite();
			container.addChild( child1 );
			container.addChild( child2 );

			bringToFront( child1 );
			assertEquals( 1, container.getChildIndex( child1 ) );

			bringToFront( child2 );
			assertEquals( 1, container.getChildIndex( child2 ) );
		}

		[Test(expects="org.robotools.graphics.error.GraphicsException")]
		public function throwsExceptionWhenTryingToBringNullObjectToFront():void {
			bringToFront( null );
		}

		[Test(expects="org.robotools.graphics.error.GraphicsException")]
		public function throwsExceptionWhenTryingToBringObjectWithoutParentToFront():void {
			bringToFront( new Sprite() );
		}

		[Test]
		public function copiesObjectAsBitmap():void {
			var sideLength:int = 100;
			var area:Rectangle = new Rectangle( 0, 0, sideLength, sideLength );
			var red:uint = 0xFFFF0000;

			var source:Sprite = createVectorRedSquare( area, red );
			var target:Bitmap = copyAsBitmap( source );
			var redSquare:BitmapData = createPixelRedSquare( sideLength, area, red );

			assertEquals( 0, redSquare.compare( target.bitmapData ) );
		}

		private function createVectorRedSquare( area:Rectangle, red:uint ):Sprite {
			var source:Sprite = new Sprite();
			new GraphRectangle( source ).createRectangle( area ).fill( red, 1 ).noLine().draw();
			return source;
		}

		private function createPixelRedSquare( sideLength:int, area:Rectangle, red:uint ):BitmapData {
			var redSquare:BitmapData = new BitmapData( sideLength, sideLength );
			redSquare.fillRect( area, red );
			return redSquare;
		}

		[Test(expects="org.robotools.graphics.error.GraphicsException")]
		public function throwsExceptionWhenTryingToDuplicateNullAsBitmap():void {
			copyAsBitmap( null);
		}

		[Test]
		public function getsMovieClipByName():void {
			var child:Sprite = createChildMovieClip();
			container.addChild( child );

			assertEquals( child, getMovieClipByName( container, "childClip" ) );
		}

		[Test]
		public function getMovieClipByNameReturnsNullForUnknownName():void {
			container.addChild( createChildMovieClip() );

			assertNull( getMovieClipByName( container, "unknownName" ) );
		}

		[Test]
		public function getMovieClipByNameReturnsNullForNonMovieClip():void {
			container.addChild( createChildSprite() );

			assertNull( getMovieClipByName( container, "childClip" ) );
		}

		[Test]
		public function getsSpriteByName():void {
			var child:Sprite = createChildSprite();
			container.addChild( child );

			assertEquals( child, getSpriteByName( container, "childClip" ) );
		}

		[Test]
		public function getSpriteByNameReturnsNullForUnknownName():void {
			container.addChild( createChildSprite() );

			assertNull( getSpriteByName( container, "unknownName" ) );
		}

		[Test]
		public function getSpriteByNameReturnsNullForNonSprite():void {
			container.addChild( createChildShape() );

			assertNull( getSpriteByName( container, "childClip" ) );
		}

		[Test]
		public function getsTextFieldByName():void {
			var child:TextField = createChildTextField();
			container.addChild( child );

			assertEquals( child, getTextFieldByName( container, "childClip" ) );
		}

		[Test]
		public function getTextFieldByNameReturnsNullForUnknownName():void {
			container.addChild( createChildTextField() );

			assertNull( getTextFieldByName( container, "unknownName" ) );
		}

		[Test]
		public function getTextFieldByNameReturnsNullForNonTextField():void {
			container.addChild( createChildShape() );

			assertNull( getSpriteByName( container, "childClip" ) );
		}

		private function createChildMovieClip():Sprite {
			var child:Sprite = new MovieClip();
			child.name = "childClip";
			return child;
		}

		private function createChildShape():Shape {
			var child:Shape = new Shape();
			child.name = "childClip";
			return child;
		}

		private function createChildSprite():Sprite {
			var child:Sprite = new Sprite();
			child.name = "childClip";
			return child;
		}

		private function createChildTextField():TextField {
			var child:TextField = new TextField();
			child.name = "childClip";
			return child;
		}

		[Test(ui)]
		public function returnsGlobalPosition():void {
			var child:Sprite = createChildSprite();
			child.x = child.y = 100;
			var grandChild:Shape = createChildShape();
			grandChild.x = grandChild.y = 100;
			child.addChild( grandChild );
			container.addChild( child );

			UIImpersonator.addChild( container );

			var pos:Point = globalPosition( grandChild );
			assertEquals( 200, pos.x, pos.y );

			UIImpersonator.removeChild( container );
		}

		[Test]
		public function tintsDisplayObject():void {
			var sideLength:int = 100;
			var area:Rectangle = new Rectangle( 0, 0, sideLength, sideLength );
			var red:uint = 0xFFFF0000;
			var redSquare:BitmapData = createPixelRedSquare( sideLength, area, red );

			var child:Sprite = createChildSprite();
			container.addChild( child );

			new GraphRectangle( child ).createRectangle( area ).fill( 0xFFFFFF, 1 ).noLine().draw();
			tint( child, red );

			var containerBitmap:BitmapData = new BitmapData( sideLength, sideLength );
			containerBitmap.draw( container );

			assertEquals( 0, containerBitmap.compare( redSquare ) );
		}

		[After]
		public function tearDown():void {
			
			while (container.numChildren > 0) container.removeChildAt(0);
			container = null;
		}
	}
}

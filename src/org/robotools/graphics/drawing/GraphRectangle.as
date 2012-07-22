package org.robotools.graphics.drawing
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;


	public class GraphRectangle extends GraphArea
	{
		private var _roundCorners:Number = 0;

		private var _rectangle:Rectangle;

		public function createRectangle( rect:Rectangle ):GraphRectangle {
			_rectangle = rect;
			return this;
		}

		override public function draw():void {
			super.draw();
			if(_roundCorners != 0) _parent.graphics.drawRoundRect( _rectangle.x, _rectangle.y, _rectangle.width, _rectangle.height, _roundCorners, _roundCorners );
			else _parent.graphics.drawRect( _rectangle.x, _rectangle.y, _rectangle.width, _rectangle.height );
			if(_fill) _parent.graphics.endFill();
		}

		public function fill( color:uint = 0, alpha:Number = 1, gradient:Gradient = null ):GraphRectangle {
			setFill( color, alpha, gradient );
			return this;
		}

		public function line( thickness:Number, color:uint = 0, alpha:Number = 1, gradient:Gradient = null, pixelHinting:Boolean = false ):GraphRectangle {
			setLine( thickness, color, alpha, gradient, pixelHinting );
			return this;
		}

		public function noFill():GraphRectangle {
			setNoFill();
			return this;
		}

		public function noLine():GraphRectangle {
			setNoLine();
			return this;
		}

		public function withRoundCorners( roundCorners:Number ):GraphRectangle {
			_roundCorners = roundCorners;
			return this;
		}

		public function GraphRectangle( parent:Sprite ) {
			super( parent );
		}
	}
}

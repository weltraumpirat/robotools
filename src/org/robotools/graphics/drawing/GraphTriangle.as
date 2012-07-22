package org.robotools.graphics.drawing
{
	import flash.display.Sprite;
	import flash.geom.Point;


	public class GraphTriangle extends GraphArea
	{
		private var _begin:Point;

		private var _end:Point;

		private var _mid:Point;

		override public function draw():void {
			super.draw();
			_parent.graphics.moveTo( _begin.x, _begin.y );
			_parent.graphics.lineTo( _mid.x, _mid.y );
			_parent.graphics.lineTo( _end.x, _end.y );
			_parent.graphics.lineTo( _begin.x, _begin.y );

			if(_fill) {
				_parent.graphics.endFill();
			}
		}

		public function fill( color:uint = 0, alpha:Number = 1, gradient:Gradient = null ):GraphTriangle {
			setFill( color, alpha, gradient );
			return this;
		}

		public function from( begin:Point ):GraphTriangle {
			_begin = begin;
			return this;
		}

		public function line( thickness:Number, color:uint = 0, alpha:Number = 1, gradient:Gradient = null, pixelHinting:Boolean = false ):GraphTriangle {
			setLine( thickness, color, alpha, gradient, pixelHinting );
			return this;
		}

		public function noFill():GraphTriangle {
			setNoFill();
			return this;
		}

		public function noLine():GraphTriangle {
			setNoLine();
			return this;
		}

		public function to( end:Point ):GraphTriangle {
			_end = end;
			return this;
		}

		public function via( mid:Point ):GraphTriangle {
			_mid = mid;
			return this;
		}

		public function GraphTriangle( parent:Sprite ) {
			super( parent );
		}
	}
}

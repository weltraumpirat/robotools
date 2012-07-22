package org.robotools.graphics.drawing
{
	import flash.display.Sprite;
	import flash.geom.Point;


	public class GraphCircle extends GraphArea
	{
		private var _origin:Point;

		private var _radius:Number;

		override public function draw():void {
			super.draw();
			_parent.graphics.drawCircle( _origin.x, _origin.y, _radius );
			if(_fill) _parent.graphics.endFill();
		}

		public function atPoint( x:Number, y:Number ):GraphCircle {
			_origin = new Point( x, y );
			return this;
		}

		public function withRadius( radius:Number ):GraphCircle {
			_radius = radius;
			return this;
		}

		public function fill( color:uint = 0, alpha:Number = 1, gradient:Gradient = null ):GraphCircle {
			setFill( color, alpha, gradient );
			return this;
		}

		public function line( thickness:Number, color:uint = 0, alpha:Number = 1, gradient:Gradient = null, pixelHinting:Boolean = false ):GraphCircle {
			setLine( thickness, color, alpha, gradient, pixelHinting );
			return this;
		}

		public function noFill():GraphCircle {
			setNoFill();
			return this;
		}

		public function noLine():GraphCircle {
			setNoLine();
			return this;
		}

		public function GraphCircle( parent:Sprite ) {
			super( parent );
		}
	}
}

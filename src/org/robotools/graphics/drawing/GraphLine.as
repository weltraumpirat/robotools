package org.robotools.graphics.drawing
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;


	public class GraphLine
	{
		private var _begin:Point;

		private var _end:Point;

		private var _gradient:Gradient;

		private var _lineAlpha:Number;

		private var _lineColor:uint;

		private var _lineThickness:Number;

		private var _parent:Sprite;

		private var _pixelHinting:Boolean;

		public function draw():void {
			var graphics:Graphics = _parent.graphics;
			graphics.moveTo( _begin.x, _begin.y );
			graphics.lineStyle( _lineThickness, _lineColor, _lineAlpha, _pixelHinting );
			if(_gradient) {
				_gradient.create();
				graphics.lineGradientStyle( _gradient.type, _gradient.colors, _gradient.alphas, _gradient.ratios, _gradient.matrix, _gradient.spreadMethod );
			}
			graphics.lineTo( _end.x, _end.y );
		}

		public function from( begin:Point ):GraphLine {
			_begin = begin;
			return this;
		}

		public function line( thickness:Number, color:uint, alpha:Number, gradient:Gradient = null, pixelHinting:Boolean = false ):GraphLine {
			_lineThickness = thickness;
			_lineColor = color;
			_lineAlpha = alpha;
			_gradient = gradient;
			_pixelHinting = pixelHinting;

			return this;
		}

		public function to( end:Point ):GraphLine {
			_end = end;
			return this;
		}

		public function GraphLine( parent:Sprite ) {
			_parent = parent;
		}
	}
}

package org.robotools.graphics.drawing
{
	import flash.display.Graphics;
	import flash.display.Sprite;


	public class GraphArea
	{
		protected var _fill:Boolean;

		protected var _fillAlpha:Number;

		protected var _fillColor:uint;

		protected var _fillGradient:Gradient;

		protected var _line:Boolean;

		protected var _lineAlpha:Number;

		protected var _lineColor:uint;

		protected var _lineGradient:Gradient;

		protected var _linePixelHinting:Boolean;

		protected var _lineThickness:Number;

		protected var _parent:Sprite;

		public function draw():void {
			var graphics:Graphics = _parent.graphics;
			if(_line) {
				graphics.lineStyle( _lineThickness, _lineColor, _lineAlpha, _linePixelHinting );

				if(_lineGradient != null) {
					_lineGradient.create();
					graphics.lineGradientStyle( _lineGradient.type, _lineGradient.colors, _lineGradient.alphas, _lineGradient.ratios, _lineGradient.matrix, _lineGradient.spreadMethod );
				}
			}
			if(_fill) {
				if(_fillGradient != null) {
					_fillGradient.create();
					graphics.beginGradientFill( _fillGradient.type, _fillGradient.colors, _fillGradient.alphas, _fillGradient.ratios, _fillGradient.matrix, _fillGradient.spreadMethod );
				} else {
					graphics.beginFill( _fillColor, _fillAlpha );
				}
			}
		}

		public function setFill( color:uint = 0, alpha:Number = 1, gradient:Gradient = null ):void {
			_fill = true;
			_fillColor = color;
			_fillAlpha = alpha;
			_fillGradient = gradient;
		}

		public function setLine( thickness:Number, color:uint = 0, alpha:Number = 1, gradient:Gradient = null, pixelHinting:Boolean = false ):void {
			_line = true;
			_lineThickness = thickness;
			_lineColor = color;
			_lineAlpha = alpha;
			_lineGradient = gradient;
			_linePixelHinting = pixelHinting;
		}

		public function setNoFill():void {
			_fill = false;
		}

		public function setNoLine():void {
			_line = false;
		}

		public function GraphArea( parent:Sprite ) {
			_parent = parent;
		}
	}
}

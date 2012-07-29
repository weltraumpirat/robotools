/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
package org.robotools.graphics.drawing {
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class GraphArea {
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
			if( _line )
				drawLine( graphics );

			if( _fill )
				drawFill( graphics );
		}

		private function drawFill( graphics:Graphics ):void {
			if( _fillGradient )
				drawGradientFill( graphics );
			 else
				drawSolidFill( graphics );

		}

		private function drawGradientFill( graphics:Graphics ):void {
			_fillGradient.create();
			graphics.beginGradientFill( _fillGradient.type, _fillGradient.colors, _fillGradient.alphas,
										_fillGradient.ratios, _fillGradient.matrix,
										_fillGradient.spreadMethod );
		}

		private function drawSolidFill( graphics:Graphics ):void {
			graphics.beginFill( _fillColor, _fillAlpha );
		}

		private function drawLine( graphics:Graphics ):void {
			graphics.lineStyle( _lineThickness, _lineColor, _lineAlpha, _linePixelHinting );

			if( _lineGradient != null )
				drawGradientLine( graphics );
		}

		private function drawGradientLine( graphics:Graphics ):void {
			_lineGradient.create();
			graphics.lineGradientStyle( _lineGradient.type, _lineGradient.colors, _lineGradient.alphas,
										_lineGradient.ratios, _lineGradient.matrix,
										_lineGradient.spreadMethod );
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

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
	import flash.geom.Point;

	public class GraphLine {
		private var _begin:Point;

		private var _end:Point;

		private var _gradient:Gradient;

		private var _lineAlpha:Number;

		private var _lineColor:uint;

		private var _lineThickness:Number;

		private var _parent:Sprite;

		private var _pixelHinting:Boolean;



		public function from( begin:Point ):GraphLine {
			_begin = begin;
			return this;
		}

		public function to( end:Point ):GraphLine {
			_end = end;
			return this;
		}

		public function draw():void {
			var graphics:Graphics = _parent.graphics;
			drawLine( graphics );
		}

		private function drawLine( graphics:Graphics ):void {
			graphics.moveTo( _begin.x, _begin.y );
			graphics.lineStyle( _lineThickness, _lineColor, _lineAlpha, _pixelHinting );
			if( _gradient )
				drawGradientLine( graphics );
			graphics.lineTo( _end.x, _end.y );
		}

		private function drawGradientLine( graphics:Graphics ):void {
			_gradient.create();
			graphics.lineGradientStyle( _gradient.type, _gradient.colors, _gradient.alphas, _gradient.ratios,
										_gradient.matrix, _gradient.spreadMethod );
		}

		public function line( thickness:Number, color:uint, alpha:Number, gradient:Gradient = null, pixelHinting:Boolean = false ):GraphLine {
			_lineThickness = thickness;
			_lineColor = color;
			_lineAlpha = alpha;
			_gradient = gradient;
			_pixelHinting = pixelHinting;

			return this;
		}

		public function GraphLine( parent:Sprite ) {
			_parent = parent;
		}
	}
}

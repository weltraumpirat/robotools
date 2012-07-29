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
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class GraphRectangle extends GraphArea {
		private var _roundCorners:Number = 0;

		private var _rectangle:Rectangle;

		public function createRectangle( rect:Rectangle ):GraphRectangle {
			_rectangle = rect;
			return this;
		}

		override public function draw():void {
			super.draw();
			if( _roundCorners == 0 )
				drawRectangle();
			else
				drawRoundRectangle();
			if( _fill )
				_parent.graphics.endFill();
		}

		private function drawRectangle():void {
			_parent.graphics.drawRect( _rectangle.x, _rectangle.y, _rectangle.width, _rectangle.height );
		}

		private function drawRoundRectangle():void {
			_parent.graphics.drawRoundRect( _rectangle.x, _rectangle.y, _rectangle.width,
											_rectangle.height, _roundCorners, _roundCorners );
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

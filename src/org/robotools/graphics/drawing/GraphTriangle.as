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
	import flash.geom.Point;

	public class GraphTriangle extends GraphArea {
		private var _begin:Point;

		private var _end:Point;

		private var _mid:Point;

		public function from( begin:Point ):GraphTriangle {
			_begin = begin;
			return this;
		}

		public function via( mid:Point ):GraphTriangle {
			_mid = mid;
			return this;
		}

		public function to( end:Point ):GraphTriangle {
			_end = end;
			return this;
		}

		override public function draw():void {
			super.draw();
			drawTriangle();
			if( _fill )
				_parent.graphics.endFill();

		}

		private function drawTriangle():void {
			_parent.graphics.moveTo( _begin.x, _begin.y );
			_parent.graphics.lineTo( _mid.x, _mid.y );
			_parent.graphics.lineTo( _end.x, _end.y );
			_parent.graphics.lineTo( _begin.x, _begin.y );
		}

		public function fill( color:uint = 0, alpha:Number = 1, gradient:Gradient = null ):GraphTriangle {
			setFill( color, alpha, gradient );
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

		public function GraphTriangle( parent:Sprite ) {
			super( parent );
		}
	}
}

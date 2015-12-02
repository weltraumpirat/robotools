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
	import flash.geom.Rectangle;

	public class GraphRectangle extends GraphArea {
		private var _roundCorners:Number = 0;

		private var _rectangle:Rectangle;
		private var _dashLength:uint;
		private var _spaceLength:uint;

		public function createRectangle( rect:Rectangle ):GraphRectangle {
			_rectangle = rect;
			return this;
		}

		override public function draw():void {
			super.draw();
			if( _roundCorners == 0 ) {
				if( _dashLength > 0)
					drawDashedRectangle();
				else
					drawRectangle();
			}
			else
				drawRoundRectangle();
			if( _fill )
				_parent.graphics.endFill();
		}

		private function drawDashedRectangle():void {

			_spaceLength = _spaceLength<1 ? _spaceLength : 1;
			var g:Graphics = _parent.graphics;
			g.moveTo( 0, 0 );
			var minx:Number = _rectangle.x;
			var miny:Number = _rectangle.y;
			var maxx:Number = _rectangle.x+_rectangle.width;
			var maxy:Number = _rectangle.y+_rectangle.height;
			var xpos:Number = minx, ypos:Number = miny, remainder:Number;

			// dim.x, dim.y => dim.x + dim.width, dim.y
			while( xpos+_dashLength<maxx ) {
				xpos += _dashLength;
				g.lineTo( xpos, miny );
				xpos += _spaceLength;
				g.moveTo( xpos, miny );
			}
			// lines fall short of endpoint
			if( xpos<maxx ) {
				remainder = maxx-xpos;
				xpos = maxx;
				g.lineTo( xpos, miny );
			}
			else {
				xpos = maxx;
				ypos += _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// restline
			if( remainder>0 ) {
				if( ypos+remainder>maxy ) {
					remainder -= maxy-ypos;
					ypos = maxy;
				}
				else ypos += remainder;
				g.lineTo( xpos, ypos );

				if( ypos<maxy ) ypos += _spaceLength;
				g.moveTo( xpos, ypos );
			}

			// dim.x + dim.width, dim.y => dim.x + dim.width, dim.y + dim.height
			while( ypos+_dashLength<maxy ) {
				ypos += _dashLength;
				g.lineTo( xpos, ypos );
				ypos += _spaceLength;
				g.moveTo( xpos, ypos );
			}

			remainder = 0;
			// lines fall short
			if( ypos<maxy ) {
				remainder = maxy-ypos;
				ypos = maxy;
				g.lineTo( xpos, ypos );
			}
			else {
				ypos = maxy;
				ypos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// restline
			if( remainder>0 ) {
				if( xpos-remainder<0 ) {
					remainder -= xpos;
					xpos = minx;
				}
				else xpos -= remainder;
				g.lineTo( xpos, ypos );

				if( xpos>minx ) xpos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// dim.x + dim.width, dim.y + dim.height => dim.x, dim.y + dim.height
			while( xpos-_dashLength>minx ) {
				xpos -= _dashLength;
				g.lineTo( xpos, ypos );
				xpos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// lines fall short
			if( xpos>minx ) {
				remainder = xpos;
				xpos = minx;
				g.lineTo( xpos, ypos );
			}
			else {
				xpos = minx;
				ypos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// restline
			if( remainder>0 ) {
				if( ypos-remainder<miny ) {
					g.lineTo( minx, miny );
				}
				else ypos -= remainder;
				g.lineTo( xpos, ypos );

				if( ypos>miny ) ypos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}
			// dim.x, dim.y + dim.height => dim.x, dim.y
			while( ypos-_dashLength>miny ) {
				ypos -= _dashLength;
				g.lineTo( xpos, ypos );
				ypos -= _spaceLength;
				g.moveTo( xpos, ypos );
			}

			remainder = 0;
			// restline
			if( ypos>miny ) {
				ypos = miny;
				g.lineTo( xpos, ypos );
			}
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

		public function spaceLength( spaceLength:uint = 0 ) : GraphRectangle {
			_spaceLength = spaceLength;
			return this;
		}

		public function dashLength( dashLength:uint = 0 ) : GraphRectangle {
			_dashLength = dashLength;
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

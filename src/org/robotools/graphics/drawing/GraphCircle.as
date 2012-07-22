/* Copyright (c) 2012 Tobias Goeschel
 *
 * Permission is hereby granted, free of charge, to any person 
 * obtaining a copy of this software and associated documentation 
 * files (the "Software"), to deal in the Software without restriction, 
 * including without limitation the rights to use, copy, modify, merge, 
 * publish, distribute, sublicense, and/or sell copies of the Software, 
 * and to permit persons to whom the Software is furnished to do so, 
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included 
 * in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
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

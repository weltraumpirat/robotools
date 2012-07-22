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
	import org.robotools.graphics.error.GraphicsException;

	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;


	public class Gradient
	{
		private var _alphas:Array = [1, 1];

		private var _colors:Array = [0, 0];

		private var _dimensions:Rectangle;

		private var _ratios:Array = [0x00, 0xFF];

		private var _matrix:Matrix = new Matrix();

		private var _rotation:Number;

		private var _spreadMethod:String = SpreadMethod.PAD;

		private var _type:String = GradientType.LINEAR;

		public function get alphas():Array {
			return _alphas;
		}

		public function set alphas( alphas:Array ):void {
			_alphas = alphas;
		}

		public function get colors():Array {
			return _colors;
		}

		public function set colors( colors:Array ):void {
			_colors = colors;
		}

		public function get dimensions():Rectangle {
			return _dimensions;
		}

		public function set dimensions( dimensions:Rectangle ):void {
			_dimensions = dimensions;
		}

		public function get ratios():Array {
			return _ratios;
		}

		public function set ratios( ratios:Array ):void {
			_ratios = ratios;
		}

		public function get matrix():Matrix {
			return _matrix;
		}

		public function set matrix( matrix:Matrix ):void {
			_matrix = matrix;
		}

		public function get rotation():Number {
			return _rotation;
		}

		public function set rotation( rotation:Number ):void {
			_rotation = rotation;
		}

		public function get spreadMethod():String {
			return _spreadMethod;
		}

		public function set spreadMethod( spreadMethod:String ):void {
			_spreadMethod = spreadMethod;
		}

		public function get type():String {
			return _type;
		}

		public function set type( type:String ):void {
			_type = type;
		}

		public function create():void {
			if(!(_alphas.length == _colors.length && alphas.length == _ratios.length)) {
				throw new GraphicsException( GraphicsException.PARAMETER_ERROR, "Your Gradient must have the same number of entries for alphas, colors and ratios." );
				return;
			}

			if(_dimensions == null) {
				throw new GraphicsException( GraphicsException.PARAMETER_ERROR, "Your Gradient must have dimensions set." );
				return;
			}
			_matrix.createGradientBox( _dimensions.width, _dimensions.height, _rotation, 0, 0 );
		}

		public function Gradient( dimensions:Rectangle = null, alphas:Array = null, ratios:Array = null, matrix:Matrix = null, rotation:Number = 0, spreadMethod:String = null ) {
			_dimensions = dimensions;
			_alphas = alphas;
			_ratios = ratios;
			_matrix = matrix;
			_rotation = rotation;
			_spreadMethod = spreadMethod;
		}
	}
}

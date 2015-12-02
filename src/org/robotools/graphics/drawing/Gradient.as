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
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import org.robotools.graphics.error.GraphicsException;

	public class Gradient {
		private var _alphas:Array = [1, 1];

		private var _colors:Array = [0, 0];

		private var _dimensions:Rectangle;

		private var _ratios:Array = [0x00, 0xFF];

		private var _matrix:Matrix = new Matrix();

		private var _rotation:Number;

		private var _spreadMethod:String = SpreadMethod.PAD;

		private var _type:String = GradientType.LINEAR;



		public function create():void {
			if ( validate() )
				_matrix.createGradientBox( _dimensions.width, _dimensions.height, _rotation, 0, 0 );
		}

		public function validate() : Boolean {
			if( incompleteSetOfDivisionParameters() )
				throw new GraphicsException( "Your Gradient must have the same number of parameters for alphas, colors and ratios.",
											 GraphicsException.PARAMETER_ERROR );
			if( _dimensions == null )
				throw new GraphicsException( "You must set the dimensions for your Gradient.",
											 GraphicsException.PARAMETER_ERROR );
			return true;
		}

		private function incompleteSetOfDivisionParameters():Boolean {
			return alphas == null || colors == null || ratios == null ||
				   !(alphas.length == colors.length && alphas.length == ratios.length);
		}

		public function Gradient( dimensions:Rectangle = null, alphas:Array = null, ratios:Array = null, matrix:Matrix = null, rotation:Number = 0, spreadMethod:String = null ) {
			_dimensions = dimensions != null ? dimensions : _dimensions;
			_alphas = alphas != null ? alphas : _alphas;
			_ratios = ratios != null ? ratios : _ratios;
			_matrix = matrix != null ? matrix : _matrix;
			_rotation = rotation;
			_spreadMethod = spreadMethod != null ? spreadMethod : _spreadMethod;
		}

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
	}
}

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
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;


	public class DropShadow
	{
		public static var defaultAlpha:Number = .5;

		public static var defaultAngle:Number = 45;

		public static var defaultBlur:Number = 3;

		public static var defaultColor:uint = 0;

		public static var defaultDistance:Number = 1;

		public static var defaultQuality:Number = BitmapFilterQuality.LOW;

		public static var defaultStrength:Number = 1;

		public static var defaultInner:Boolean = false;

		public static var defaultKnockout:Boolean = false;

		private var _filter:DropShadowFilter = new DropShadowFilter();

		private var _params:Object;

		private var _target:DisplayObject;

		public function get params():Object {
			return _params;
		}

		public function set params( params:Object ):void {
			_params = params;
		}

		public function get target():DisplayObject {
			return _target;
		}

		public function set target( target:DisplayObject ):void {
			_target = target;
		}

		private function applyParams():void {
			if(!_filter || !params) return;
			for( var str:String in params) {
				_filter[str] = params[str];
			}
		}

		public function atAngle( ang:Number ):DropShadow {
			params.angle = ang;
			return this;
		}

		public function atDistance( dist:Number ):DropShadow {
			params.distance = dist;
			return this;
		}

		public function clear():void {
			if(!_target || !_filter) return;
			var filters:Array = [];
			for each( var f:Object in _target.filters) {
				if(!(f is DropShadowFilter)) filters.push( f );
			}
			_target.filters = filters.length < 1 ? null : filters;
			_filter = null;
			_filter = new DropShadowFilter();
			_params = null;
			_params = initParams();
			_target = null;
		}

		public function create():void {
			if(!_target || !_filter || !params) return;
			applyParams();
			var filters:Array = [];
			for each( var f:Object in _target.filters) {
				if(!(f is DropShadowFilter)) filters.push( f );
			}
			filters.push( _filter );
			_target.filters = filters;
		}

		public function forItem( obj:DisplayObject ):DropShadow {
			_target = obj;
			return this;
		}

		private function initParams():Object {
			return {color:defaultColor, alpha:defaultAlpha, blurX:defaultBlur, blurY:defaultBlur, strength:defaultStrength, angle:defaultAngle, distance:defaultDistance, inner:defaultInner, knockout:DropShadow.defaultKnockout, quality:defaultQuality};
		}

		public function withAlpha( n:Number ):DropShadow {
			params.alpha = n;
			return this;
		}

		public function withBlur( n1:Number, n2:Number = NaN ):DropShadow {
			if(isNaN( n2 )) n2 = n1;
			params.blurX = n1;
			params.blurY = n2;
			return this;
		}

		public function withColor( col:Number ):DropShadow {
			params.color = col;
			return this;
		}

		public function withParams( params:Object ):DropShadow {
			_params = params;
			applyParams();
			return this;
		}
		
		public function toString() : String {
			var ret:String = "DropShadow:{";
			ret += "color:"+params.color;
			ret += ", alpha:"+params.alpha;
			ret += ", distance:"+params.distance;
			ret += ", blur:"+params.blurX+","+params.blurY;
			ret += ", angle:"+params.angle;
			ret +="}";
			return ret;
		}

		public function DropShadow( obj:DisplayObject = null, params:Object = null ) {
			_target = obj;
			_params = params ? params : initParams();
		}
	}
}

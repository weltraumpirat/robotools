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
package org.robotools.graphics {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	import org.robotools.graphics.error.GraphicsException;

	public function copyAsBitmap( source:Sprite ):Bitmap {
		if( source )
			return BitmapCopy.getCopy( source );
		else
			throw new GraphicsException( "The source must not be null." );
		return new Bitmap();
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.geom.Matrix;

internal class BitmapCopy {
	public static function getCopy( source:Sprite ):Bitmap {
		source.cacheAsBitmap = true;
		return new Bitmap( createCopyBitmapData( source ), PixelSnapping.AUTO, true );
	}

	private static function createCopyBitmapData( source:Sprite ):BitmapData {
		var bitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0xFFFFFF );
		bitmapData.draw( source, new Matrix(), null, null, null, true );
		return bitmapData;
	}
}
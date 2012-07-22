package org.robotools.graphics
{
	import org.robotools.graphics.error.GraphicsException;

	import flash.display.Bitmap;
	import flash.display.Sprite;

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


internal class BitmapCopy
{
	public static function getCopy( source:Sprite ):Bitmap {
		source.cacheAsBitmap = true;

		var bitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0xFFFFFF );
		bitmapData.draw( source, new Matrix(), null, null, null, true );

		return new Bitmap( bitmapData, PixelSnapping.AUTO, true );
	}
}
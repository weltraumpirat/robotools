package org.robotools.graphics
{
	import org.robotools.graphics.error.GraphicsException;

	import flash.geom.Point;

	public function globalPosition( displayObject:* ):Point {
		if(displayObject)
			return Position.getGlobal( displayObject );
		else
			throw new GraphicsException( "The argument for globalPosition() must not be null." );
		return new Point();
	}
}
import org.robotools.graphics.error.GraphicsException;

import flash.geom.Point;


internal class Position
{
	public static function getLocal( displayObject:* ):Point {
		return new Point( displayObject.x, displayObject.y );
	}

	public static function getGlobal( item:* ):Point {
		var parent:* = item.parent;
		if( parent ) {
			var local:Point = getLocal( item );
			return parent.localToGlobal( local );
		} else throw new GraphicsException( "You must first add the argument display object to the display list." );
		return new Point();
	}
}

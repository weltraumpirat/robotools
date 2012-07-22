package org.robotools.graphics
{
	import org.robotools.graphics.error.GraphicsException;

	import flash.display.DisplayObject;

	public function bringToFront( obj:DisplayObject ):void {
		if(obj) ChildIndex.setToHighest( obj );
		else throw new GraphicsException( "The argument for bringToFront() must not be null." );
	}
}
import org.robotools.graphics.error.GraphicsException;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;


internal class ChildIndex
{
	public static function setToHighest( obj:DisplayObject ):void {
		var container:DisplayObjectContainer = obj.parent;
		if(container) container.setChildIndex( obj, container.numChildren-1 );
		else throw new GraphicsException( "You must first add the argument display object to the display list." );
	}
}
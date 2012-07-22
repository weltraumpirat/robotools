package org.robotools.graphics
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	public function tint( displayObject:Sprite, color:uint ):void {
		var colorTransform:ColorTransform = new ColorTransform();
		colorTransform.color = color;
		displayObject.transform.colorTransform = colorTransform;
	}
}

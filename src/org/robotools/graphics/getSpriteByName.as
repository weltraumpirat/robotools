package org.robotools.graphics
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public function getSpriteByName( parent:DisplayObjectContainer, name:String ):Sprite {
		return parent.getChildByName( name ) as Sprite;
	}
}

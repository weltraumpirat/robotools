package org.robotools.graphics
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;

	public function getTextFieldByName( parent:DisplayObjectContainer, name:String ):TextField {
		return parent.getChildByName( name ) as TextField;
	}
}

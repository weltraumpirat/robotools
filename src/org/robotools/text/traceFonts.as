package org.robotools.text
{
	import flash.text.Font;

	public function traceFonts():void {
		var fonts:Array = Font.enumerateFonts( false );
		trace( "Available fonts:\r----------" );
		for each(var font:Font in fonts)
			trace( font.fontName+":"+font.fontType );
		trace( "----------" );
	}
}

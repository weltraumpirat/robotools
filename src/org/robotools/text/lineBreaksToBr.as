package org.robotools.text
{
	public function lineBreaksToBr( str:String ):String {
		return str.replace( /[\r\n]/gi, "<br />" );
	}
}

package org.robotools.text
{
	public function stripLineBreaks( str:String ):String {
		return str.replace( /[\r\n\t]*/gi, "" );
	}
}

package org.robotools.text
{
	public function normalizeLineBreaks( str:String ):String {
		return str.replace( /\R/g, "\n" );
	}
}

package org.robotools.text
{
	public function stripLeadingWhitespace( str:String ):String {
		var ret:String = str.replace( /^\s+/gm, "" );
		return normalizeLineBreaks( ret );
	}
}

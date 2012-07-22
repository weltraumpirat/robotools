package org.robotools.text
{
	public function stripTrailingWhitespace( str:String ):String {
		var ret:String = str.replace( /\s+$/gm, "" );
		return normalizeLineBreaks( ret );
	}
}

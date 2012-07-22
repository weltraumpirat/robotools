package org.robotools.text
{
	public function normalizeWhitespace( str:String ):String {
		return str.replace( /\s+/g, " " );
	}
}

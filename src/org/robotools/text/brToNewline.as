package org.robotools.text
{
	public function brToNewline( str:String ):String {
		return str.replace( /<br\s*\/>/gi, "\n" );
	}
}

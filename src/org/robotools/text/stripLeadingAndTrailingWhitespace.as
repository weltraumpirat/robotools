package org.robotools.text
{
	public function stripLeadingAndTrailingWhitespace( str:String ):String {
		var ret:String = stripLeadingWhitespace( str );
		ret = stripTrailingWhitespace( ret );
		return ret;
	}
}

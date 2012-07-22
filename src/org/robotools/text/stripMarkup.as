package org.robotools.text
{
	public function stripMarkup( str:String ):String {
		var ret:String = str.replace (/<[^>]+>/gm, "");
		return stripLineBreaks( stripLeadingWhitespace( ret ) );
	}
}

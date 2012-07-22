package org.robotools.text
{
	public function stripWhitespaceAroundPunctuation( str:String ):String {
		var ret:String = str.replace( /(?<!\w)([\s]+)/g, "" );
		ret = ret.replace( /([\s]+)(?!\w)/g, "" );
		return ret;
	}
}

package org.robotools.text
{
	import flash.text.TextField;

	public function toPlainText( str:String ):String {
		var tx:TextField = new TextField();
		tx.htmlText = str;
		return stripLeadingWhitespace( tx.text );
	}
}

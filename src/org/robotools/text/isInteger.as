package org.robotools.text
{
	public function isInteger( str:String ):Boolean {
		var reg:RegExp = /(^[0-9]+$)/;
		return reg.exec( str );
	}
}

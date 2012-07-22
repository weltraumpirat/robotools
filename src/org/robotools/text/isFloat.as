package org.robotools.text
{
	public function isFloat( str:String ):Boolean {
		var reg:RegExp = /(^[0-9]+\.[0-9]+$)/;
		return reg.exec( str );
	}
}

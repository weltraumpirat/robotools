package org.robotools.text
{
	public function timeAsString( date:Date ):String {
		var hours:String = leadingZeros( date.getHours(), 2 );
		var minutes:String = leadingZeros( date.getMinutes(), 2 );
		var seconds:String = leadingZeros( date.getSeconds(), 2 );
		return hours+"-"+minutes+"-"+seconds;
	}
}
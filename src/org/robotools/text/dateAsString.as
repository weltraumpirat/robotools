package org.robotools.text
{
	public function dateAsString( date:Date ):String {
		var day:String = leadingZeros (date.getDate(), 2);
		var month:String = leadingZeros (date.getMonth()+1, 2);
		return day+"-"+month+"-"+date.getFullYear();
	}
}
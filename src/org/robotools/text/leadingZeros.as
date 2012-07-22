package org.robotools.text
{
	public function leadingZeros( value:*, digits:int):String {
		var valueAsString: String = "" + value;
		var remaining:int = digits - valueAsString.length;
		while (--remaining >= 0) 
			valueAsString = "0" + valueAsString;
		return valueAsString;
	}
}

package org.robotools.text
{
	public function leadingSpaces( value:*, digits:int):String {
		var valueAsString: String = "" + value;
		var remaining:int = digits - valueAsString.length;
		while (--remaining >= 0) 
			valueAsString = " " + valueAsString;
		return valueAsString;
	}
}

package org.robotools.data.parsing
{
	public function parseToInt( num:String ):int {
		if(num == null) return 0;
		var n:int = parseInt( num );
		return isNaN( n ) ? 0 : n;
	}
}

package org.robotools.data
{
	public function propertyCount( obj:Object ):uint {
		var count:int = 0;
		for(var prop:Object in obj) count++;
		return count;
	}
}

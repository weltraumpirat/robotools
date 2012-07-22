package org.robotools.data
{
	public function enumerateProperties( obj:* ):Array {
		var keys:Array = [];
		for( var key : * in obj )
			keys.push( key );
		return keys;
	}
}

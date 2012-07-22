package org.robotools.data.copy
{
	import org.as3commons.reflect.Type;

	public function copyTo( from:*, to:* ):* {
		var type:Type = Type.forInstance( from );
		return ObjectCopy.copyValues( from, to, type );
	}
}

package org.robotools.data.copy
{
	import org.as3commons.reflect.Type;

	public function copy( from:* ):* {
		var type:Type = Type.forInstance( from );
		return ObjectCopy.toType( from, type );
	}
}
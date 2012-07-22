package org.robotools.data.comparison
{
	import org.as3commons.reflect.Type;

	public function isPrimitiveObj( obj:* ):Boolean {
		var type:Type = Type.forInstance( obj );
		return isPrimitiveType( type.name );
	}
}

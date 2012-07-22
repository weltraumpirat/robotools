package org.robotools.data.comparison
{
	import org.as3commons.reflect.Type;

	public function isArrayObj( obj:* ):Boolean {
		var type:Type = Type.forInstance( obj );
		return isArrayType( type.name );
	}
}

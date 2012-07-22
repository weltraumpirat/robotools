package org.robotools.data.comparison
{
	import org.as3commons.reflect.Type;

	public function isComplexObj( obj:* ):Boolean {
		var type:Type = Type.forInstance( obj );
		return isComplexType( type.name );
	}
}

package org.robotools.data.comparison
{
	public function isComplexType( typeName:String ):Boolean {
		const PRIMITIVE_TYPES:Array = ["int", "uint", "String", "Number"];
		return PRIMITIVE_TYPES.indexOf( typeName ) == -1;
	}
}

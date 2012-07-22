package org.robotools.data.comparison
{
	public function valueType( arg:* ):String {
		return isComplexType( arg ) ? "complex" : "primitive";
	}
}

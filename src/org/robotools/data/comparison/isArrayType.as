package org.robotools.data.comparison
{
	public function isArrayType( typeName:String ):Boolean {
		return typeName == "Array" || typeName.indexOf( "Vector.<" ) >= 0;
	}
}

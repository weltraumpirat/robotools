package org.robotools.data.comparison
{
	public function includesBothComplexAndPrimitiveValues( ...args:* ):Boolean {
		var type:String = null;
		for each(var arg:* in args)
			if(!type) type = valueType( arg );
			else if(type != valueType( arg )) return true;
		return false;
	}
}

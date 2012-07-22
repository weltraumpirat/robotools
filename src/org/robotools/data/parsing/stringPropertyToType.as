package org.robotools.data.parsing
{
	public function stringPropertyToType( valueHolder:Object, propertyName:String, returnType:Class ):* {
		var value:* = ConversionUtil.getPropertyValue( valueHolder, propertyName );

		if(returnType == Number)
			return parseToFloat( value );
		else if(returnType == int) 
			return parseToInt( value );
		else if(returnType == uint) 
			return parseToColor( value );
		else if(returnType == Boolean) 
			return value === "true";
		
		return value;
	}
}

internal class ConversionUtil
{
	public static function getPropertyValue( valueHolder:*, propertyName:String ):* {
		if(valueHolder && propertyName) {
			try {
				return valueHolder[propertyName];
			} catch(e:Error) {
			}
		}
		return null;
	}
}

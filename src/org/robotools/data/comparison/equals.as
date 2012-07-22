package org.robotools.data.comparison
{
	public function equals( obj:*, compareObj:* ):Boolean {
		if(PrimitiveValueComparison.fails( obj, compareObj )) return false;
		if(ArrayComparison.fails( obj, compareObj )) return false;
		if(PropertyComparison.fails( obj, compareObj )) return false;
		return true;
	}
}

import org.robotools.data.comparison.equalPrimitiveValues;
import org.robotools.data.comparison.equals;
import org.robotools.data.comparison.includesBothComplexAndPrimitiveValues;
import org.robotools.data.comparison.isArrayObj;
import org.robotools.data.comparison.isEnumerableObj;
import org.robotools.data.comparison.isPrimitiveObj;
import org.robotools.data.enumerateProperties;


internal class PropertyComparison
{
	public static function fails( obj:*, compareObj:* ):Boolean {
		if(haveAtLeastOneEnumerableValue( obj, compareObj )) {
			var notBothEnumerable:Boolean = notBothEnumerableValues( obj, compareObj );
			var notEqualValues:Boolean = doNotHaveEqualValues( obj, compareObj );
			return notBothEnumerable || notEqualValues;
		} else return false;
	}

	private static function haveAtLeastOneEnumerableValue( obj:*, compareObj:* ):Boolean {
		return isEnumerableObj( obj ) || isEnumerableObj( compareObj );
	}

	private static function notBothEnumerableValues( obj:*, compareObj:* ):Boolean {
		return (isEnumerableObj( obj ) && isEnumerableObj( compareObj )) == false;
	}

	private static function doNotHaveEqualValues( obj:*, compareObj:* ):Boolean {
		var keys:Array = commonKeysArrayOrNull( obj, compareObj );
		return keys && haveDifferentValues( keys, obj, compareObj ) ? true : false;
	}

	private static function commonKeysArrayOrNull( obj:*, compareObj:* ):Array {
		var keys:Array = enumerateProperties( obj );
		var compareKeys:Array = enumerateProperties( compareObj );
		return equals( keys, compareKeys ) ? keys : null;
	}

	private static function haveDifferentValues( keys:Array, obj:*, compareObj:* ):Boolean {
		for each( var key:String in keys)
			if(different( obj[key], compareObj[key] )) return true;
		return false;
	}

	private static function different( value:*, compareValue:* ):Boolean {
		return equals( value, compareValue ) == false;
	}
}

internal class PrimitiveValueComparison
{
	public static function fails( obj:*, compareObj:* ):Boolean {
		if(haveAtLeastOnePrimitiveValue( obj, compareObj )) {
			var mixedTypes:Boolean = includesBothComplexAndPrimitiveValues( obj, compareObj );
			var notEqualValues:Boolean = doNotHaveEqualValues( obj, compareObj );
			return mixedTypes || notEqualValues;
		} else return false;
	}

	private static function haveAtLeastOnePrimitiveValue( obj:*, compareObj:* ):Boolean {
		return isPrimitiveObj( obj ) || isPrimitiveObj( compareObj );
	}

	private static function doNotHaveEqualValues( obj:*, compareObj:* ):Boolean {
		var primitive:Boolean = isPrimitiveObj( obj );
		var equalValues:Boolean = equalPrimitiveValues( obj, compareObj );
		return (primitive && equalValues) == false;
	}
}

internal class ArrayComparison
{
	public static function fails( obj:*, compareObj:* ):Boolean {
		if( haveAtLeastOneArray( obj, compareObj )) {
			var notBothArrays:Boolean = areNotBothArrays( obj, compareObj );
			var notEqualLength:Boolean = doNotHaveEqualLength( obj, compareObj );
			var notEqualValues:Boolean = doNotHaveEqualValues( obj, compareObj );
			return (notBothArrays || notEqualLength || notEqualValues );
		}
		return false;
	}

	private static function haveAtLeastOneArray( obj:*, compareObj:* ):Boolean {
		return isArrayObj( obj ) || isArrayObj( compareObj );
	}

	private static function areNotBothArrays( obj:*, compareObj:* ):Boolean {
		return (isArrayObj( obj ) && isArrayObj( compareObj )) == false;
	}

	private static function doNotHaveEqualValues( obj:*, compareObj:* ):Boolean {
		var i:int = 0;
		while(i < obj.length && equals( obj[i], compareObj[i] ) ) i++;
		return i != obj.length;
	}

	private static function doNotHaveEqualLength( obj:*, compareObj:* ):Boolean {
		return obj.length != compareObj.length;
	}
}
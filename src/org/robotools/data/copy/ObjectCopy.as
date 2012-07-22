package org.robotools.data.copy
{
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;


	internal class ObjectCopy
	{
		public static function toType( from:*, type:Type ):* {
			if(isComplexType( type.name ))
				return toComplexType( from, type );
			else
				return from;
		}

		public static function copyValues( from:*, to:*, type:Type ):void {
			copyProperties( from, to );
			copyAccessors( type, to, from );
			copyVariables( type, to, from );
		}

		private static function isComplexType( typeName:String ):Boolean {
			const PRIMITIVE_TYPES:Array = ["int", "uint", "String", "Number"];
			return PRIMITIVE_TYPES.indexOf( typeName ) == -1;
		}

		private static function toComplexType( from:*, type:Type ):* {
			var to:* = new type.clazz();
			if(isArrayType( type.name )) copyElements( from, to );
			else
				copyValues( from, to, type );
			return to;
		}
		
		private static function isArrayType( typeName:String ):Boolean {
			return typeName == "Array" || typeName.indexOf( "Vector.<" ) >= 0;
		}

		private static function copyElements( from:*, to:* ):void {
			for(var i:int = 0; i < from.length; i++) {
				to[i] = copy( from[i] );
			}
		}

		public static function copyProperties( from:*, to:* ):void {
			for(var key:String in from)
				copyPropertyValue( to, key, from );
		}

		private static function copyPropertyValue( to:*, key:String, from:* ):void {
			try {
				to[key] = copy( from[key] );
			} catch (e:Error) {
			}
		}

		public static function copyAccessors( type:Type, to:*, from:* ):void {
			for each(var accessor:Accessor in type.accessors)
				if(accessor.isWriteable()) copyAccessorValue( to, accessor, from );
		}

		private static function copyAccessorValue( to:*, accessor:Accessor, from:* ):void {
			try {
				to[accessor.name] = copy( from[accessor.name] );
			} catch (e:Error) {
			}
		}

		private static function copyVariables( type:Type, to:*, from:* ):void {
			for each(var variable:Variable in type.variables)
				copyVariableValue( to, variable, from );
		}

		private static function copyVariableValue( to:*, variable:Variable, from:* ):void {
			try {
				to[variable.name] = copy( from[variable.name] );
			} catch (e:Error) {
			}
		}
	}
}

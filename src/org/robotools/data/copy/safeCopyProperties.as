package org.robotools.data.copy
{
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;
	import org.robotools.data.enumerateProperties;

	public function safeCopyProperties( from:*, to:*, type:Type = null ):* {
		var toType:Type = type ? type : Type.forInstance( to );
		var props:Array = enumerateProperties( from );

		for each( var acc:Accessor in toType.accessors )
			if(props.indexOf( acc.name ) > -1)
				to[acc.name] = from[acc.name];

		for each( var variable:Variable in toType.variables )
			if(props.indexOf( variable.name ) > -1)
				to[variable.name] = from[variable.name];

		return to;
	}
}

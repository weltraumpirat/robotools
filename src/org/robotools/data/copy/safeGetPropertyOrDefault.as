package org.robotools.data.copy
{
	public function safeGetPropertyOrDefault( target:*, name:String, defaultValue:* ):* {
		var result:*;
		try {
			result = target[name];
		} catch (e:Error) {
		}
		if (result is Number || result is int || result is uint ) { 
			if (isNaN(result)) 
				return defaultValue;
			else return result;
		}
		else if (result) 
			return result;
		else 
			return defaultValue;
	}
}

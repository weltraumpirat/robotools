package org.robotools.data.copy
{
	public function safeGetProperty( obj:*, name:String ):* {
		try {
			var result:* = obj[name];
			if ((result is Number || result is int || result is uint ) && isNaN(result)) 
				return 0;
			else 
				return result;
		} catch (e:Error) {
		}
		return null;
	}
}

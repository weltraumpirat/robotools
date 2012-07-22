package org.robotools.data.comparison
{
	public function equalAsString( obj:Object, compareObj:Object ):Boolean {
		if(obj.toString() == compareObj.toString()) return true;
		else return false;
	}
}

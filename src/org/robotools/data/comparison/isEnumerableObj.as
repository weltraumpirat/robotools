package org.robotools.data.comparison
{
	public function isEnumerableObj( obj:* ):Boolean {
		return isComplexObj( obj ) && (isArrayObj( obj ) == false);
	}
}

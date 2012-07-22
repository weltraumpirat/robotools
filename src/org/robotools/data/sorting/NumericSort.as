package org.robotools.data.sorting
{
	import mx.collections.Sort;


	public class NumericSort extends Sort
	{
		public function NumericSort( fieldNames:Array ) {
			super();
			fields = createSortFields( fieldNames );
		}

		private function createSortFields( fieldNames:Array ):Array {
			var fields:Array = [];
			var i:int = -1;
			while(++i < fieldNames.length)
				fields[i] = new NumericSortField( fieldNames[i] );
			return fields;
		}
	}
}

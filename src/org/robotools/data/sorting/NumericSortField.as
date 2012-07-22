package org.robotools.data.sorting
{
	import mx.collections.SortField;


	public class NumericSortField extends SortField
	{
		public function NumericSortField ( name:String ) {
			this.name = name;
			numeric = true;
		}
	}
}

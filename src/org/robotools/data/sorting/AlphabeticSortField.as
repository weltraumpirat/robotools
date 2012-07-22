package org.robotools.data.sorting
{
	import mx.collections.SortField;


	public class AlphabeticSortField extends SortField
	{
		public function AlphabeticSortField( name:String ) {
			this.name = name;
			caseInsensitive = true;
		}
	}
}

package org.robotools.data
{

	public class TestClass
	{
		public var value1:int;

		public var value2:String;

		private var _value3:Object;

		public function get value3():Object {
			return _value3;
		}

		public function set value3( value3:Object ):void {
			_value3 = value3;
		}
	}
}

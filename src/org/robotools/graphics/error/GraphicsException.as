package org.robotools.graphics.error
{

	public class GraphicsException extends Error
	{
		public static const PARAMETER_ERROR:String = "parameterError";

		public function GraphicsException( msg:* = "", id:* = 0 ) {
			super( msg, id );
		}
	}
}

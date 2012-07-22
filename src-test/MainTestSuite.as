package
{
	import org.robotools.data.ShallowCopyTest;
	import org.robotools.data.TypeFunctionsTest;
	import org.robotools.graphics.GraphicsFunctionsTest;
	import org.robotools.text.TextFunctionsTest;


	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class MainTestSuite
	{
		public var shallowCopyTest:ShallowCopyTest;

		public var typeFunctionsTest:TypeFunctionsTest;

		public var textFunctionsTest:TextFunctionsTest;
		
		public var graphicsFunctionsTest:GraphicsFunctionsTest;
	}
}

package ane.proxy.testflight
{
	import com.adobe.ane.testFlight.TestFlight;

	public class TestFlighter
	{
		private static var _tf:Object;

		public function TestFlighter()
		{
		}

		public static function setup():void
		{
			try
			{
//				SilentSwitch.apply();
				if (TestFlight.isSupported)
					_tf=new TestFlight("11874e4e-59fe-4172-8375-ab17f26af1b9", true);
			}
			catch (error:Error)
			{
			}
			if (_tf)
			{

				var stderr:Object=new Object();
				stderr.key="logToSTDERR";
				stderr.value="YES";

				var console:Object=new Object();
				console.key="logToConsole";
				console.value="YES";

				var optArr:Array=new Array();
				optArr[0]=stderr;
				optArr[1]=console;

				_tf.setOptions(optArr);
				_tf.passCheckPoint(CheckPoints.SOME_SECTION_CP);

				trace('test flight set up success!!')
			}
			else
			{
				trace('test flight set up failed!!')
			}
		}

		public static function isTestFlightSupport():Boolean
		{
			return _tf;
		}

		public static function openFeedBackWindow():void
		{
			if (_tf)
			{
				_tf.openFeedBackView();
			}
		}

		public static function log(str:String):void
		{
			if (_tf)
				_tf.log(str);
		}

		public static function passCheckPoint(checkPoint:String):void
		{
			if (_tf)
				_tf.passCheckPoint(checkPoint);
		}
	}
}

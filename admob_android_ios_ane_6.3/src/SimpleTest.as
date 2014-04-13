package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	
	import so.cuo.anes.admob.*;

	[SWF(width="960", height="640", frameRate="35", backgroundColor="#cccccc")]
	public class SimpleTest extends Sprite
	{
		public function SimpleTest()
		{
			super();
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var title:TextField=new TextField();
			title.text="admob simple demo";
			this.addChild(title);
			
			
			this.showAd();
		}

		private function showAd():void
		{
			var admob:Admob=Admob.getInstance();
			if (admob.isSupported)
			{
				admob.createADView(AdSize.BANNER, "a1514bcdferve3437"); //create a banner ad view.this init the view 
				admob.addToStage(0, 0); // ad to displaylist position 0,0
				admob.load(false); // send a ad request.  
			}
			else
			{
				trace("not support");
			}
		}

	}
}

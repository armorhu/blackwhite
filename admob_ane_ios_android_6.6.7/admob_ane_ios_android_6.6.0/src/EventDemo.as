package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;

	public class EventDemo extends Sprite
	{
		var admob:Admob= Admob.getInstance();

		public function EventDemo()
		{
			super();
			if (admob.supportDevice)
			{
				admob.setKeys("a152834c8723912");//Interstitial and banner use the same key
				admob.addEventListener(AdmobEvent.onBannerFailedReceive, onAdReceived);
				admob.addEventListener(AdmobEvent.onBannerReceive, onAdReceived);
			}
			stage.addEventListener(MouseEvent.CLICK, clickStage);
		}

		protected function clickStage(event:MouseEvent):void
		{
			admob.showBannerAbsolute(Admob.IAB_BANNER, 0, 10);
			if (admob.isInterstitialReady())
			{
				admob.showInterstitial();
			}
			else
			{
				admob.cacheInterstitial();
			}
		}

		protected function onAdReceived(event:AdmobEvent):void
		{
			trace(event.type, event.data);
		}
	}
}

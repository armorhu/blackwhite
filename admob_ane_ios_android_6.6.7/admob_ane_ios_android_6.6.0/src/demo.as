package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	import so.cuo.platform.admob.AdmobSize;

	public class demo extends Sprite
	{
		public var ios_full:String="a152834c8723912";
		public var ios_banner:String="a152834c2b8cce6";
		public var xkey:TextField=new TextField();
		public var ykey:TextField=new TextField();
		public var typekey:TextField=new TextField();
		public var absSubmitButton:TextField=new TextField();
		public var relationSubmitButton:TextField=new TextField();
		public var hideSubmitButton:TextField=new TextField();
		public var interstitialSubmitButton:TextField=new TextField();
		private var format:TextFormat=new TextFormat(null, 38);
		private var admob:Admob;

		public function demo()
		{
			super();

			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			initUI();

			admob=Admob.getInstance();
			if (admob.supportDevice)
			{
				admob.setKeys(ios_banner, ios_full);
				admob.addEventListener(AdmobEvent.onInterstitialReceive, onAdReceived);
				admob.addEventListener(AdmobEvent.onBannerReceive, onAdReceived);
				admob.enableTrace=true;
			}
		}

		private function initUI():void
		{
			typekey.y=ykey.y=xkey.y=100;
			xkey.x=100;
			ykey.x=300;
			typekey.x=500;
			typekey.type=ykey.type=xkey.type=TextFieldType.INPUT;
			typekey.border=xkey.border=ykey.border=true;

			this.hideSubmitButton.width=relationSubmitButton.width=interstitialSubmitButton.width=absSubmitButton.width=xkey.width=ykey.width=140;
			this.typekey.height=this.hideSubmitButton.height=relationSubmitButton.height=interstitialSubmitButton.height=absSubmitButton.height=xkey.height=ykey.height=48;
			this.typekey.defaultTextFormat=this.hideSubmitButton.defaultTextFormat=interstitialSubmitButton.defaultTextFormat=relationSubmitButton.defaultTextFormat=absSubmitButton.defaultTextFormat=xkey.defaultTextFormat=ykey.defaultTextFormat=this.format;
			absSubmitButton.text="absolute";
			relationSubmitButton.text="relation";
			interstitialSubmitButton.text="interstitial";
			this.hideSubmitButton.text="hide";
			xkey.text="8"; // relation position type or abs position x value
			ykey.text="0"; //abs position y value
			typekey.text="1"; // banner type
			this.addChild(xkey);
			this.addChild(ykey);
			this.addChild(this.typekey);
			this.addChild(absSubmitButton);
			this.addChild(this.relationSubmitButton);
			this.addChild(this.interstitialSubmitButton);
			this.addChild(this.hideSubmitButton);
			this.hideSubmitButton.x=relationSubmitButton.x=interstitialSubmitButton.x=absSubmitButton.x=100;
			this.relationSubmitButton.selectable=this.absSubmitButton.selectable=this.interstitialSubmitButton.selectable=false;
			this.relationSubmitButton.border=this.absSubmitButton.border=this.interstitialSubmitButton.border=true;
			this.relationSubmitButton.y=200;
			this.absSubmitButton.y=300;
			this.interstitialSubmitButton.y=400;
			this.hideSubmitButton.y=500;
			absSubmitButton.addEventListener(MouseEvent.CLICK, this.click);
			relationSubmitButton.addEventListener(MouseEvent.CLICK, this.click);
			interstitialSubmitButton.addEventListener(MouseEvent.CLICK, this.click);
			this.hideSubmitButton.addEventListener(MouseEvent.CLICK, this.click);
		}

		protected function click(event:MouseEvent):void
		{
			trace("click-------1");
			if (!admob.supportDevice)
			{
				trace("not support device");
				return
			}
			else
			{
				var text:TextField=event.currentTarget as TextField;
				var xv:int=parseInt(xkey.text);
				var yv:int=parseInt(ykey.text);
				var size:int=parseInt(typekey.text);
				var adsize:AdmobSize;
				if (size == 1)
				{
					adsize=Admob.BANNER;
				}
				if (size == 2)
				{
					adsize=Admob.IAB_BANNER;
				}
				if (size == 3)
				{
					adsize=Admob.SMART_BANNER;
				}
				if (size == 4)
				{
					adsize=Admob.IAB_MRECT;
				}
				if (size == 5)
				{
					adsize=Admob.IAB_WIDE_SKYSCRAPER;
				}
				if (size == 6)
				{
					adsize=Admob.IAB_LEADERBOARD;
				}
				if (adsize == null)
				{
					adsize=new AdmobSize(320, 50);
				}
				if (text == this.hideSubmitButton)
				{
					admob.hideBanner();
				}
				if (text == this.absSubmitButton)
				{
					admob.showBannerAbsolute(adsize, xv, yv);
				}
				else if (text == this.relationSubmitButton)
				{
					if (xv > 9)
						xv=9;
					if (xv < 1)
						xv=1;
					admob.showBanner(adsize, xv);
				}
				else if (text == this.interstitialSubmitButton)
				{
					if (admob.isInterstitialReady())
					{
//						trace("flash showInterstitial");
						admob.hideBanner();
						admob.showInterstitial();
					}
					else
					{
//						trace("flash cacheInterstial");
						admob.cacheInterstitial();
					}
				}
			}
		}

		protected function onBannerFail(event:Event):void
		{
			trace(event.type);
		}

		protected function onAdReceived(event:AdmobEvent):void
		{
			if (event.type == AdmobEvent.onBannerReceive)
			{
				trace(event.data.width, event.data.height);
			}
			if (event.type == AdmobEvent.onInterstitialReceive)
			{
//				trace("flash showInterstitial");
//				admob.showInterstitial();
			}
		}

	}
}

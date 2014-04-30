package com.blackwhite
{
	import com.agame.utils.SystemUtil;
	import com.amgame.utils.BitmapdataUtils;

	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.SoundTransform;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import ane.proxy.wechat.WechatProxy;

	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksMobileTheme;

	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobPosition;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class GameRoot extends Sprite
	{
		//default setting ....
		public var app_type:String='default';
		public var appid:String='860769730';
		public var appstore_url:String='https://itunes.apple.com/us/app/bie-cai-hei-kuai-er/id';
		public var cloums:int=4;
		public var rows:int=4;
		public var withe:uint=0x0;
		public var black:uint=0xffffff;
		public var yellow:uint=0xFFFF99;
		public var grey:uint=0x999999;
		public var red:uint=0xCC3333;
		public var blue:uint=0x01ffff;
		public var green:uint=0x009900;
		public var MODE_CLASSIC:String='捉鸡模式';
		public var CLASSIC_STEP:int=50;
		public var MODE_JIE:String='无尽模式';
		public var MODE_CHAN:String="30″\n竞速模式";
		public var CHAN_LIFE:Number=30.000;
		public var BUTTON_RETRY:String='重玩';
		public var BUTTON_BACK:String='首页';
		public var BUTTON_SHARED:String='炫耀';
		public var TEXT_BEST:String='最佳:';
		public var TEXT_FAILED:String='失败了!';
		public var TEXT_MODE:String='';
		public var TEXT_TIME_OUT:String='时间到!!!';
		public var TEXT_NEW_RECORED:String='新纪录!';
		public var BUTTON_GAME_CENTER:String='排行榜';
		public var BUTTON_SHARE_APP:String='推荐给朋友';
		public var BUTTON_RATE_ME:String='评分';
		public var BUTTON_MORE_GAME:String='更多游戏';
		public var blockWidht:Number;
		public var blockHeight:Number;
		public var stageWidth:Number;
		public var stageHeight:Number
		public var Scale:Number=1;
		public var XXL:int=120;
		public var XL:int=100;
		public var L:int=60;
		public var S:int=40;

		public var admob_iphone:String='a153491819ad964';
		public var admob_ipad:String='a1534a7ec255c50';
		public var admob_android:String='a1534a7f76632ce';

		public var fontName:String='fonts';
		public var assets:AssetManager;

		private var gameScore:Object;

		public function GameRoot()
		{
			super();
			Game=this;
			addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler)
		}

		private function addedToStageHandler():void
		{
			// TODO Auto Generated method stub
			Starling.current.nativeStage.dispatchEvent(new flash.events.Event('init'));
			initliaze();
		}


		public function initliaze():void
		{
			new MetalWorksMobileTheme(stage);
			stage.color=0x0;
			stageWidth=stage.stageWidth;
			stageHeight=stage.stageHeight;
			blockWidht=stageWidth / cloums;
			blockHeight=stageHeight / rows;
			Scale=stageWidth / 640;
			Cookies.initialize('blackwhite');
			gameScore=Cookies.getObject('gameScore');
			if (gameScore == null)
				gameScore={};
			loading=new TextField(256 * Scale, 64 * Scale, '', 'mini', 48 * Scale, 0xffffff);
			loading.x=(stageWidth - loading.width) / 2;
			loading.y=(stageHeight - loading.height) / 2;
			addChild(loading);
			assets=new AssetManager;
			assets.enqueue(File.applicationDirectory.resolvePath('res'));
			assets.loadQueue(assetsProgressing);
			admob=Admob.getInstance();
			if (admob.supportDevice)
			{
				if (SystemUtil.isAndroid())
					admob.setKeys(admob_android);
				else if (SystemUtil.isIpad())
					admob.setKeys(admob_ipad);
				else
					admob.setKeys(admob_iphone);
				admob.enableTrace=false;
			}
		}

		private var loading:TextField;

		private function assetsProgressing(percent:Number):void
		{
			loading.text=int(percent * 100) + '%';
			if (percent == 1)
			{
				setupGame();
			}
		}

		public var map:Map;
		public var menu:Menu;
		public var result:GameResult;

		private function setupGame():void
		{
			trace('Game font', TextField.getBitmapFont(fontName));
			WechatProxy.setup('wx83705d131d3c73ef'); //启动ane

			loading.removeFromParent(true);
			trace('setupGame....');
			map=new Map;
			result=new GameResult;
			menu=new Menu;

			showMenu();
			stage.color=withe;
		}

		public function start(mode:String=''):void
		{
			// TODO Auto Generated method stub
			trace('start game', mode);
			showMap();
			map.reset(mode);
		}

		private var _first:Boolean=true;

		public function showMap():void
		{
			removeChildren();
			addChild(map);
			if (intersititialTimeOut > 0)
			{
				clearTimeout(intersititialTimeOut);
				intersititialTimeOut=0;
			}

			if (_first)
			{
				_first=false;
				return;
			}
			admob.hideBanner();
			admob.showBanner(Admob.BANNER, app_type == 'default' ? AdmobPosition.BOTTOM_CENTER : AdmobPosition.TOP_CENTER);
		}

		public function showMenu():void
		{
			removeChildren();
			addChild(menu);
		}

		private var admob:Admob;

		private var intersititialTimeOut:int;


		public function showResult():void
		{
			admob.hideBanner();
			admob.showBanner(Admob.BANNER, AdmobPosition.BOTTOM_CENTER);
//			if (admob.isInterstitialReady())
//				intersititialTimeOut=setTimeout(show, 1500);
//			else
//				admob.cacheInterstitial();
			removeChildren();
			addChild(result);
		}

//		public function show():void
//		{
//			admob.showInterstitial();
//			admob.cacheInterstitial();
//		}

		public function createTextfiled(text:String='', width:Number=128, height:Number=64, size:int=30, color:uint=0x0):TextField
		{
			var result:TextField=new TextField(width, height, text, Game.fontName, size, color);
			result.autoScale=true;
			return result;
		}

		public function getScore(mode:String):Number
		{
			if (gameScore[mode] == undefined)
			{
				if (mode == MODE_CLASSIC)
					return int.MAX_VALUE;
				else
					return 0;
			}
			else
				return Number(gameScore[mode]);
		}

		public function setScore(mode:String, score:Number):void
		{
			trace('setScore', mode, score);
			gameScore[mode]=score;
			Cookies.setObject('gameScore', gameScore, 0, true);
		}

		public var beep:String='beep';
		public var cheer:String='cheer';
		public var error:String='error';
		public var tick:String='tick';
		public var touch:String='touch';
		private var transfrom:SoundTransform;

		public function playSound(name:String, loops:int):void
		{
			if (name == touch)
			{
				if (transfrom == null)
					transfrom=new SoundTransform(2);
				assets.playSound(name, 0, loops, transfrom);
			}
			else
				assets.playSound(name, 0, loops);
		}

		public function alter(title:String, msg:String, buttonLabels:Array, buttonTriggers:Array):void
		{
			var _buttons:ListCollection=new ListCollection;
			var num:int=buttonLabels.length;
			for (var i:int=0; i < num; i++)
				_buttons.addItem({label: buttonLabels[i], triggered: buttonTriggers[i]});
			var alter:Alert=Alert.show(msg, title, _buttons);
			alter.width*=1.5;
			alter.height*=1.2;
		}

		public function share():void
		{
			var bmd:BitmapData=new BitmapData(stage.stageWidth, stage.stageHeight);
			this.stage.drawToBitmapData(bmd);
			var imgURL:String=File.applicationStorageDirectory.nativePath + File.separator + 'screen_shot.png';
			BitmapdataUtils.saveBitmapTo(imgURL, bmd, new PNGEncoderOptions);
			WechatProxy.sendImage( //
				imgURL, //
				'下载地址:' + appstore_url + appid, // 
				'下载地址:' + appstore_url + appid, // 
				WechatProxy.SHARE_TO_ALL_FRIENDS);
		}
	}
}

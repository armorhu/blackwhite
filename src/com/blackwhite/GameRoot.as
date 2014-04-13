package com.blackwhite
{
	import flash.filesystem.File;
	import flash.media.SoundTransform;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobPosition;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class GameRoot extends Sprite
	{
		public const cloums:int=4;
		public const rows:int=4;

		public const withe:uint=0xffffff;
		public const black:uint=0x0;
//		public const withe:uint=0x0;
//		public const black:uint=0xffffff;


		public const yellow:uint=0xFFFF99;
		public const grey:uint=0x999999;
		public const red:uint=0xCC3333;
		public const green:uint=0x009900;


		public const MODE_CLASSIC:String='捉鸡模式';
		public const CLASSIC_STEP:int=50;
		public const MODE_JIE:String='无尽模式';
		public const MODE_CHAN:String="30″\n竞速模式";
		public const CHAN_LIFE:Number=30.000;

		public const BUTTON_RETRY:String='重玩';
		public const BUTTON_BACK:String='首页';

		public const TEXT_BEST:String='最佳:';
		public const TEXT_FAILED:String='失败了!';
		public const TEXT_MODE:String='';

		public const TEXT_TIME_OUT:String='时间到!!!';

		public const TEXT_NEW_RECORED:String='新纪录!'

		public var blockWidht:Number;
		public var blockHeight:Number;
		public var stageWidth:Number;
		public var stageHeight:Number

		public var Scale:Number=1;

		public var XXL:int=120;
		public var XL:int=100;
		public var L:int=60;
		public var S:int=40;

		public var fontName:String='fonts';
		public var assets:AssetManager;

		private var gameScore:Object;

		public function GameRoot()
		{
			super();
			Game=this;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
		}

		private function addedToStageHandler():void
		{
			// TODO Auto Generated method stub
			initliaze();
		}


		public function initliaze():void
		{
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
				admob.setKeys('a153491819ad964');
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

		public function showMap():void
		{
			removeChildren();
			addChild(map);
			if (intersititialTimeOut > 0)
			{
				clearTimeout(intersititialTimeOut);
				intersititialTimeOut=0;
			}

			admob.hideBanner();
			admob.showBanner(Admob.BANNER, AdmobPosition.BOTTOM_CENTER);
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
			if (admob.isInterstitialReady())
				intersititialTimeOut=setTimeout(show, 1500);
			else
				admob.cacheInterstitial();
			removeChildren();
			addChild(result);
		}

		public function show():void
		{
			admob.showInterstitial();
			admob.cacheInterstitial();
		}

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

		public const beep:String='beep';
		public const cheer:String='cheer';
		public const error:String='error';
		public const tick:String='tick';
		public const touch:String='touch';

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
	}
}

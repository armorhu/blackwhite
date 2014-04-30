package com.blackwhite
{
	import com.agame.utils.SystemUtil;
	import com.greensock.easing.Back;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import ane.proxy.wechat.WechatProxy;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Menu extends Sprite
	{

		private var labelButton:LabelButton;

		public function Menu()
		{
			super();
			initliaze();
		}

		private function drawBackground(w:Number, h:Number):void
		{
			var bg:Sprite=new Sprite;
			var quad:Quad;
			quad=new Quad(w, h);
			quad.color=Game.withe;
			bg.addChild(quad);

			quad=new Quad(w, h);
			quad.x=w;
			quad.color=Game.black;
			bg.addChild(quad);

			quad=new Quad(w, h);
			quad.y=h;
			quad.color=Game.black;
			bg.addChild(quad);

			quad=new Quad(w, h);
			quad.x=w, quad.y=h;
			quad.color=Game.withe;
			bg.addChild(quad);
			addChild(bg);
			bg.flatten();
		}

		private function drawBackgroundEx(w:Number, h:Number):void
		{
			var bg:Sprite=new Sprite;
			addChild(bg);
			var quad:Quad;
			for (var i:int=0; i < 8; i++)
			{
				for (var j:int=0; j < 8; j++)
				{
					quad=new Quad(w / 4, h / 4);
					quad.x=i * w / 4;
					quad.y=j * h / 4;
					quad.color=(i + j) % 2 == 0 ? Game.black : Game.withe;
					bg.addChild(quad);
				}
			}

			quad=new Quad(w / 32, h * 2, Game.blue);
			quad.pivotX=quad.width / 2;
			quad.x=w;
			bg.addChild(quad);


			quad=new Quad(w * 2, w / 32, Game.blue);
			quad.pivotY=quad.height / 2;
			quad.y=h;
			bg.addChild(quad);

			bg.flatten();
		}

		public function initliaze():void
		{
			const w:int=Game.stageWidth / 2;
			const h:int=Game.stageHeight / 2;

			if (Game.app_type == 'ex')
				drawBackgroundEx(w, h);
			else
				drawBackground(w, h);

			labelButton=new LabelButton(Game.MODE_CLASSIC, w, h, Game.L * Game.Scale, Game.app_type != 'ex' ? Game.black : Game.green);
			labelButton.name=Game.MODE_CLASSIC;
			addChild(labelButton);

			labelButton=new LabelButton(Game.MODE_JIE, w, h, Game.L * Game.Scale, Game.app_type != 'ex' ? Game.withe : Game.green);
			labelButton.name=Game.MODE_JIE;
			addChild(labelButton);
			labelButton.x=w;

			labelButton=new LabelButton(Game.MODE_CHAN, w, h, Game.L * Game.Scale, Game.app_type != 'ex' ? Game.withe : Game.green);
			labelButton.name=Game.MODE_CHAN;
			addChild(labelButton);
			labelButton.y=h;

			addEventListener(Event.TRIGGERED, tiggeredHandler);


			labelButton=new LabelButton(Game.BUTTON_SHARE_APP, w, h / 5, Game.S * Game.Scale, Game.app_type != 'ex' ? Game.black : Game.green);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 1;
			addChild(labelButton);

			labelButton=new LabelButton(Game.BUTTON_RATE_ME, w, h / 5, Game.S * Game.Scale, Game.app_type != 'ex' ? Game.black : Game.green);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 2;
			addChild(labelButton);


			labelButton=new LabelButton(Game.BUTTON_MORE_GAME, w, h / 5, Game.S * Game.Scale, Game.app_type != 'ex' ? Game.black : Game.green);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 3;
			addChild(labelButton);
		}

		private function tiggeredHandler(evt:Event):void
		{
			// TODO Auto Generated method stub
			var labelName:String=evt.target['name'];
			if (labelName == Game.BUTTON_SHARE_APP)
			{
				if (SystemUtil.isIOS())
					WechatProxy.sendMail('推荐一个超好玩的小游戏,别踩黑块儿.下载地址:' + Game.appstore_url + Game.appid, WechatProxy.SHARE_TO_ALL_FRIENDS);
				else if (SystemUtil.isAndroid()) //todo android上线了要替换这个app store的地址。
					WechatProxy.sendMail('推荐一个超好玩的小游戏,别踩黑块儿.下载地址:' + Game.appstore_url + Game.appid, WechatProxy.SHARE_TO_ALL_FRIENDS);
			}
			else if (labelName == Game.BUTTON_MORE_GAME)
			{
				navigateToURL(new URLRequest('https://itunes.apple.com/us/artist/armorhu/id551053513'));
			}
			else if (labelName == Game.BUTTON_RATE_ME)
			{
				navigateToURL(new URLRequest("itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" + Game.appid));
			}
			else if (labelName == Game.BUTTON_GAME_CENTER)
			{
			}
			else
				Game.start(labelName);
		}
	}
}

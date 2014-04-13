package com.blackwhite
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

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

		public function initliaze():void
		{
			const w:int=Game.stageWidth / 2;
			const h:int=Game.stageHeight / 2;

			var quad:Quad;
			quad=new Quad(w, h);
			quad.color=Game.withe;
			addChild(quad);

			quad=new Quad(w, h);
			quad.x=w;
			quad.color=Game.black;
			addChild(quad);

			quad=new Quad(w, h);
			quad.y=h;
			quad.color=Game.black;
			addChild(quad);

			quad=new Quad(w, h);
			quad.x=w, quad.y=h;
			quad.color=Game.withe;
			addChild(quad);


			labelButton=new LabelButton(Game.MODE_CLASSIC, w, h, Game.L * Game.Scale, Game.black);
			labelButton.name=Game.MODE_CLASSIC;
			addChild(labelButton);

			labelButton=new LabelButton(Game.MODE_JIE, w, h, Game.L * Game.Scale, Game.withe);
			labelButton.name=Game.MODE_JIE;
			addChild(labelButton);
			labelButton.x=w;

			labelButton=new LabelButton(Game.MODE_CHAN, w, h, Game.L * Game.Scale, Game.withe);
			labelButton.name=Game.MODE_CHAN;
			addChild(labelButton);
			labelButton.y=h;

			addEventListener(Event.TRIGGERED, tiggeredHandler);


			labelButton=new LabelButton(Game.BUTTON_GAME_CENTER, w, h / 5, Game.S * Game.Scale, Game.black);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 1;
			addChild(labelButton);


			labelButton=new LabelButton(Game.BUTTON_GAME_CENTER, w, h / 5, Game.S * Game.Scale, Game.black);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 2;
			addChild(labelButton);


			labelButton=new LabelButton(Game.BUTTON_GAME_CENTER, w, h / 5, Game.S * Game.Scale, Game.black);
			labelButton.x=w;
			labelButton.y=h + labelButton.height * 3;
			addChild(labelButton);
		}

		private function tiggeredHandler(evt:Event):void
		{
			// TODO Auto Generated method stub
			var labelName:String=evt.target['name'];
			if (labelName == Game.BUTTON_GAME_CENTER)
			{
			}
			else if (labelName == Game.BUTTON_MORE_GAME)
			{
				navigateToURL(new URLRequest("itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" + Game.appid));
			}
			else if (labelName == Game.BUTTON_RATE_ME)
			{
			}
			else
				Game.start(labelName);
		}
	}
}

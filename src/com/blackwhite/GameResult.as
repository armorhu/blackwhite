package com.blackwhite
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class GameResult extends Sprite
	{
		public function GameResult()
		{
			super();
			initliaze();
		}

		public var bg:Quad;
		public var title:TextField;
		public var score:TextField;
		public var bestScore:TextField;

		public var lb:Sprite;
		public var backLabel:LabelButton;
		public var retryLabel:LabelButton;
		public var shareLabel:LabelButton;

		private function initliaze():void
		{
			bg=new Quad(Game.stageWidth, Game.stageHeight);
			addChild(bg);

			title=Game.createTextfiled('经典模式', Game.stageWidth, 100 * Game.Scale, Game.L * Game.Scale);
			title.pivotY=title.height / 2;
			title.y=Game.stageHeight / 5;
			addChild(title);

			score=Game.createTextfiled("100.0″", Game.stageWidth, 150 * Game.Scale, Game.XL * Game.Scale);
			score.pivotY=title.height / 2;
			score.bold=true;
			score.y=Game.stageHeight / 3;
			addChild(score);

			bestScore=Game.createTextfiled('新纪录', Game.stageWidth, 100 * Game.Scale, Game.S * Game.Scale);
			bestScore.pivotY=bestScore.height / 2;
			bestScore.y=score.y + score.height;
			addChild(bestScore);

			lb=new Sprite();
			lb.y=4 * Game.stageHeight / 5;
			addChild(lb);

			shareLabel=new LabelButton(Game.BUTTON_SHARED, 128 * Game.Scale, 64 * Game.Scale, Game.L * Game.Scale);
			shareLabel.pivotX=shareLabel.width / 2;
			shareLabel.x=1 * Game.stageWidth / 5;
			lb.addChild(shareLabel);

			retryLabel=new LabelButton(Game.BUTTON_RETRY, 128 * Game.Scale, 64 * Game.Scale, Game.L * Game.Scale);
			retryLabel.pivotX=retryLabel.width / 2;
			retryLabel.x=2.5 * Game.stageWidth / 5;
			lb.addChild(retryLabel);

			backLabel=new LabelButton(Game.BUTTON_BACK, 128 * Game.Scale, 64 * Game.Scale, Game.L * Game.Scale);
			backLabel.pivotX=backLabel.width / 2;
			lb.addChild(backLabel);
			backLabel.x=4 * Game.stageWidth / 5;

			lb.addEventListener(Event.TRIGGERED, triggeredHandler)
		}

		private function triggeredHandler(event:Event):void
		{
			// TODO Auto Generated method stub
			var targetName:String=event.target['name'];
			if (targetName == Game.BUTTON_BACK)
			{
				Game.showMenu();
			}
			else if (targetName == Game.BUTTON_RETRY)
			{
				Game.start();
			}
			else if (targetName == Game.BUTTON_SHARED)
			{
				Game.share();
			}
		}

		/**
		 * 0 胜利
		 * 1 点到白块失败
		 * 2 错过黑块失败
		 */
		public function setStyle(style:int):void
		{
			if (style == 0)
			{
				bg.color=Game.green;
				title.color=Game.withe;
				score.color=Game.black;
				bestScore.color=Game.black;
				backLabel.textfiled.color=Game.black;
				retryLabel.textfiled.color=Game.black;
				shareLabel.textfiled.color=Game.black;
			}
			else if (style == 1)
			{
				bg.color=Game.red;
				title.color=Game.withe;
				score.color=Game.black;
				bestScore.color=Game.black;
				backLabel.textfiled.color=Game.black;
				retryLabel.textfiled.color=Game.black;
				shareLabel.textfiled.color=Game.black;
			}
			else if (style == 2)
			{
				bg.color=Game.black;
				title.color=Game.withe;
				score.color=Game.withe;
				bestScore.color=Game.withe;
				backLabel.textfiled.color=Game.withe;
				retryLabel.textfiled.color=Game.withe;
				shareLabel.textfiled.color=Game.withe;
			}
		}
	}
}

package com.blackwhite
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.StageQuality;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	import feathers.display.TiledImage;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.core.starling_internal;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Map extends Sprite implements IAnimatable
	{
		public var blocks:Vector.<Quad>;
		public var playing:Boolean;

		public var blockContainer:Sprite;
		public var scoreLabel:TextField;

		public var blockCount:int=0;
		public var gameTime:Number=0;

		public var redBlock:Quad;

		public function Map()
		{
			super();


			blockContainer=new Sprite;
			addChild(blockContainer);
			drawBlocks();

			redBlock=new Quad(Game.blockWidht, Game.blockHeight);
			redBlock.color=Game.red;

			scoreLabel=Game.createTextfiled('', Game.stageWidth, 64 * Game.Scale, Game.L * Game.Scale, Game.red);
			addChild(scoreLabel);
			scoreLabel.x=(Game.stageWidth - scoreLabel.width) / 2;

			Game.stage.addEventListener(TouchEvent.TOUCH, touchStageHandler);



			var tiledImage:TiledImage;
			// TODO Auto Generated method stub
			var s:Shape=new Shape;
			s.graphics.lineStyle(2, Game.black);
			s.graphics.drawRect(0, 0, Game.blockWidht, Game.blockHeight);
			s.graphics.endFill();
			var bmd:BitmapData=new BitmapData(Game.blockWidht, Game.blockHeight, true, 0x0);
			bmd.drawWithQuality(s, null, null, null, null, true, StageQuality.BEST);
			var texture:Texture=Texture.fromBitmapData(bmd, false);
			tiledImage=new TiledImage(texture);
			tiledImage.width=Game.stageWidth;
			tiledImage.height=Game.blockHeight * 1000;
			tiledImage.y=Game.stageHeight - tiledImage.height;
			blockContainer.addChildAt(tiledImage, 0);
			tiledImage.flatten();
			tiledImage.touchable=false;
		}

		private function touchStageHandler(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			if (stage == null || touchable == false)
				return;
			var target:DisplayObject=event.target as DisplayObject;
			var touch:Touch=event.getTouch(target, TouchPhase.BEGAN);
			if (touch == null)
				return;

//			trace('touchStageHandler');

			if (!playing)
			{
				play();
				return;
			}

			sHelperPoint.x=int(touch.globalX);
			sHelperPoint.y=int(touch.globalY);
			blockContainer.globalToLocal(sHelperPoint, sHelperPoint);
			redBlock.x=Math.floor(sHelperPoint.x / Game.blockWidht) * Game.blockWidht;
			redBlock.y=Math.floor(sHelperPoint.y / Game.blockHeight) * Game.blockHeight;

//			var len:int=blocks.length;
//			for (var i:int=0; i < len; i++)
//			{
//				if (blocks[i].x == redBlock.x && blocks[i].y == redBlock.y)
//				{
//					trace('判断重合了！！！');
//					trace('---全局坐标', touch.globalX, touch.globalY);
//					trace('---本地坐标', sHelperPoint);
//					trace('---取整以后的坐标', redBlock.x, redBlock.y);
//					//判断重合了
//					redBlock.x=touch.globalX;
//					redBlock.y=touch.globalY;
//					stage.addChild(redBlock);
////					flashQuad(blocks[i], 1);
//					stop();
//					return;
//				}
//			}
			blockContainer.addChild(redBlock);
			Game.playSound(Game.error, 3);
			flashQuad(redBlock, 1);
		}

		private function touchQuadHandler(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			if (stage == null || touchable == false)
				return;
			var target:DisplayObject=event.target as DisplayObject;
			var touch:Touch=event.getTouch(target, TouchPhase.BEGAN);
			if (touch == null)
				return;
			event.stopImmediatePropagation();
			event.stopPropagation();

			var quad:Quad=target as Quad;
			if (quad)
			{
				if (quad.color == Game.black)
				{
					quad.color=Game.grey;
					blockCount++;
					if (mode == Game.MODE_JIE)
					{
						if (blockCount > 10)
							scoreLabel.text='' + blockCount;
						else
							scoreLabel.text='0' + blockCount;
					}
					else
						speed=Game.blockHeight * 10;

					Game.playSound(Game.touch, 0);
				}
			}
			if (!playing)
			{
				play();
			}
		}

		private static const sHelperPoint:Point=new Point;

		private function drawBlocks():void
		{
			var quad:Quad;
			blocks=new Vector.<Quad>;
			blocks.length=Game.rows + 1;
			//多画一行。。
			for (var r:int=0; r < Game.rows + 1; r++)
			{
				blocks[r]=new Quad(Game.blockWidht, Game.blockHeight + 1);
				blocks[r].y=r * Game.blockHeight;
				blockContainer.addChild(blocks[r]);
				blocks[r].addEventListener(TouchEvent.TOUCH, touchQuadHandler);
				blocks[r].color=Game.black;
			}
		}

		public var mode:String;
		public var result:int=0;
		public var speed:Number;
		public var currentLineNum:int=0;
		public var yPos:Number=0;
		public var sessionStart:int;

		public function play():void
		{
			sessionStart=getTimer();
			playing=true;
			Starling.juggler.add(this);
		}

		public function stop():void
		{
			touchable=false;
			Starling.juggler.remove(this);
		}

		public function reset(newMode:String=''):void
		{
			redBlock.removeFromParent();
			if (newMode != '')
				this.mode=newMode;
			if (mode == Game.MODE_CLASSIC)
			{
				this.scoreLabel.text="00.000″";
				speed=0;
			}
			else if (mode == Game.MODE_JIE)
			{
				this.scoreLabel.text='00';
				speed=Game.blockHeight * 4;
			}
			else if (mode == Game.MODE_CHAN)
			{
				this.scoreLabel.text=Game.CHAN_LIFE + "″";
				tick=5;
				speed=0;
			}
			T=0;
			gameTime=0;
			result=0;
			blockCount=0;
			touchable=true;
			playing=false;
			yPos=0;
			blockContainer.y=0;
			currentLineNum=0;
			var len:int=blocks.length;
			for (var i:int=0; i < len; i++)
			{
				blocks[i].y=Game.blockHeight * i;
				if (i == Game.rows - 1)
				{
					//最开始一行为空
					resetBlockAt(i, Game.yellow);
				}
				else
					resetBlockAt(i, Game.black);
			}
		}

		public function resetBlockAt(index:int, color:uint):void
		{
			blocks[index].color=color;
			if (color == Game.black)
			{
				var random:int=Math.random() * Game.cloums;
				blocks[index].x=random * Game.blockWidht;
				blocks[index].width=Game.blockWidht;
			}
			else
			{
				blocks[index].x=0;
				blocks[index].width=Game.stageWidth;
			}
		}

		public function advanceTime(time:Number):void
		{
			trace(speed);
			T++;
			var newLine:Boolean=yPos >= currentLineNum * Game.blockHeight;
			if (newLine)
			{
				currentLineNum++;
				//start new line;
				var blackQuad:Quad=blocks[Game.cloums - 1];
				trace('newLine', currentLineNum, blackQuad);
				if (blackQuad.color != Game.black)
				{
					var lastBlock:Quad=blocks.pop();
					blocks.unshift(lastBlock);
					lastBlock.y=-currentLineNum * Game.blockHeight;
					if (mode == Game.MODE_CLASSIC)
					{
						if (currentLineNum + Game.cloums - 1 > Game.CLASSIC_STEP)
							resetBlockAt(0, Game.green);
						else
							resetBlockAt(0, Game.black);
					}
					else
						resetBlockAt(0, Game.black);
				}
				else
				{
					Game.playSound(Game.error, 3);
					flashQuad(blackQuad, 2);
				}

			}
			// TODO Auto Generated method stub
			if (mode == Game.MODE_CLASSIC)
			{
				classicLogic(newLine);
			}
			else if (mode == Game.MODE_JIE)
			{
				jiejilogic(newLine);
			}
			else if (mode == Game.MODE_CHAN)
			{
				chanLogic(newLine);
			}


			yPos+=time * speed;
			blockContainer.y=int(yPos);
		}

		private var T:int=0;
		private var tick:int=5;

		private function chanLogic(newLine:Boolean):void
		{
			// TODO Auto Generated method stub
			var last:Number=Game.CHAN_LIFE - (getTimer() - sessionStart) / 1000;
			if (last < 0)
				last=0;
			if (T % 5 == 0)
				this.scoreLabel.text=last.toFixed(3) + "″";
			if (last == 0)
			{
				this.scoreLabel.text=Game.TEXT_TIME_OUT;
				Game.playSound(Game.beep, 3);
				flashQuad(this.scoreLabel, 2);
			}
			else if (newLine)
			{
				if (blockCount < currentLineNum)
					speed=0;
				if (last < tick)
				{
					Game.playSound(Game.tick, 0);
					tick--;
				}
			}
		}

		private function jiejilogic(newLine:Boolean):void
		{
			// TODO Auto Generated method stub
			if (newLine)
			{
				speed+=Game.blockHeight / 200;
			}
		}

		public function classicLogic(newLine:Boolean):void
		{
			gameTime=(getTimer() - sessionStart) / 1000;
			if (T % 5 == 0)
				scoreLabel.text=gameTime.toFixed(3) + "″";
			if (newLine)
			{
				if (blockCount == Game.CLASSIC_STEP)
				{
					gameWin();
					return;
				}
				if (blockCount < currentLineNum)
					speed=0;
			}
		}




		private var _failedTimeline:TimelineMax;

		private function flashQuad(quad:DisplayObject, result:int):void
		{
			if (_failedTimeline)
				return;
			this.result=result;
			stop();
			if (mode == Game.MODE_CLASSIC)
			{
				_failedTimeline=new TimelineMax({onComplete: gameFailed});
			}
			else
			{
				_failedTimeline=new TimelineMax({onComplete: gameWin});
			}
			_failedTimeline.append(TweenLite.to(quad, 0.1, {alpha: 0}));
			_failedTimeline.append(TweenLite.to(quad, 0.1, {alpha: 1}));
			_failedTimeline.repeat(3);
			_failedTimeline.play();
		}

		private function gameFailed():void
		{
			if (_failedTimeline)
			{
				_failedTimeline.stop();
				_failedTimeline.clear();
				_failedTimeline.kill();
				_failedTimeline=null;
			}

			Game.showResult();
			var resultView:GameResult=Game.result;
			resultView.setStyle(result);
			resultView.title.text=this.mode + Game.TEXT_MODE;
			resultView.score.text=Game.TEXT_FAILED;
			resultView.bestScore.text='';
			trace('game failded!!!');
		}

		public function gameWin():void
		{
			if (_failedTimeline)
			{
				_failedTimeline.stop();
				_failedTimeline.clear();
				_failedTimeline.kill();
				_failedTimeline=null;
			}
			trace('game win!!');
			speed=0;
			stop();

			Game.showResult();
			var resultScreen:GameResult=Game.result;
			resultScreen.setStyle(0);
			resultScreen.title.text=this.mode + Game.TEXT_MODE;

			var scroe:Number;
			var bestScroe:Number=Game.getScore(mode);
			if (mode == Game.MODE_CLASSIC)
			{
				scroe=gameTime;
				resultScreen.score.text=scroe.toFixed(3) + "″";
				if (scroe < bestScroe)
				{
					Game.playSound(Game.cheer, 0);
					//新纪录
					resultScreen.bestScore.text=Game.TEXT_NEW_RECORED;
					Game.setScore(mode, scroe);
				}
				else
				{
					resultScreen.bestScore.text=Game.TEXT_BEST + bestScroe.toFixed(3) + "″";
				}
			}
			else
			{
				scroe=blockCount;
				resultScreen.score.text=scroe.toString();
				if (scroe > bestScroe)
				{
					Game.playSound(Game.cheer, 0);
					//新纪录
					resultScreen.bestScore.text=Game.TEXT_NEW_RECORED;
					Game.setScore(mode, scroe);
				}
				else
				{
					resultScreen.bestScore.text=Game.TEXT_BEST + bestScroe.toString();
				}
			}
		}
	}
}

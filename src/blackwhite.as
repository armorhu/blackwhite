package
{
	import com.blackwhite.GameRoot;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.events.KeyboardEvent;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	import so.cuo.platform.admob.Admob;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class blackwhite extends Sprite
	{
		public function blackwhite()
		{
			super();
			stage.color=0x0;
//			TestFlighter.setup();
//			var s:Shape=new Shape;
//			s.graphics.lineStyle(2, 0xffffff);
//			s.graphics.drawRect(0, 0, 100, 100);
//			s.graphics.endFill();
////			addChild(s)
//
//			var bmd:BitmapData=new BitmapData(100, 100,true,0x0);
//			bmd.drawWithQuality(s, null, null, null, null, true, StageQuality.BEST);
//			var i:Bitmap=new Bitmap(bmd);
//			addChild(i);
//
//			return;

			stage.frameRate=60;
			stage.quality=StageQuality.LOW;
			NativeApplication.nativeApplication.systemIdleMode=SystemIdleMode.KEEP_AWAKE; //保持屏幕唤醒
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, onOrientationChanging);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			SoundMixer.audioPlaybackMode=AudioPlaybackMode.AMBIENT;

			start();
		}


		protected var m_starling:Starling;
		protected var viewPort:Rectangle;
		private var admob:Admob;


		public function start():void
		{
			viewPort=new Rectangle();
			viewPort.width=Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			viewPort.height=Math.max(stage.fullScreenWidth, stage.fullScreenHeight);

			Starling.handleLostContext=true; //android建议处理
			m_starling=new Starling(GameRoot, stage, viewPort);
			m_starling.addEventListener(Event.ROOT_CREATED, onCreateContext3d);
			m_starling.simulateMultitouch=false;
			m_starling.enableErrorChecking=false;
		}

		/**
		 * Context3d构造成功
		 * @param e
		 */
		private function onCreateContext3d(e:Event):void
		{
			e.target.removeEventListener(Event.ROOT_CREATED, onCreateContext3d);
			Starling.current.start();
		}


		protected function keyHandler(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if (event.keyCode == Keyboard.BACK)
			{
				//android...
			}
		}

		/**only support landscape mode*/
		private function onOrientationChanging(event:StageOrientationEvent):void
		{
			// If the stage is about to move to an orientation we don't support, lets prevent it 
			// from changing to that stage orientation. 
			if (event.afterOrientation == StageOrientation.UPSIDE_DOWN || event.afterOrientation == StageOrientation.DEFAULT)
				event.preventDefault();
		}
	}
}

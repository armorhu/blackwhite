package
{
	import com.blackwhite.Game;

	import flash.display.Sprite;
	import flash.events.Event;

	public class blackwhiteEx extends Sprite
	{
		public function blackwhiteEx()
		{
			super();
			stage.addEventListener('init', initGameHandler);
			addChild(new blackwhite);
		}

		protected function initGameHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			Game.appid='860798549';
			Game.black=0x0;
			Game.withe=0xffffff;
			Game.rows=8;
			Game.cloums=8;
		}
	}
}

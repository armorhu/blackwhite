package
{
	import flash.display.Sprite;
	
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobPosition;
	
	public class SimpleDemo extends Sprite
	{
		public function SimpleDemo()
		{
			super();
			var admob:Admob= Admob.getInstance();
			if(admob.supportDevice){
				admob.setKeys("a152834c2b8cce6");
				admob.showBanner(Admob.BANNER,AdmobPosition.BOTTOM_CENTER);
			}
		}
	}
}
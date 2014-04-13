package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import so.cuo.anes.admob.AdEvent;
	import so.cuo.anes.admob.AdSize;
	import so.cuo.anes.admob.Admob;
	
	public class FullTest extends Sprite
	{
		private var format:TextFormat;
		private var remove:TextField;
		private var create:TextField;
		private var sizeInput:TextField;
		
		private var xInput:TextField;
		private var yInput:TextField;
		private var move:TextField;
		
		private var mac:TextField;
		private var screen:TextField;
		private var show:TextField;
		
		public function FullTest()
		{
			super();
			this.format=new TextFormat(null,36,0x000000);
			
			this.sizeInput=this.createLabel("0",0);
			this.create=this.createLabel("create",1);
			show=createLabel("show",2);
			
			this.xInput=this.createLabel("200",3);
			this.yInput=this.createLabel("200",4);
			this.move=this.createLabel("move",5);
			
			mac=this.createLabel("mac",6);
			screen=createLabel("screen size",7);
			this.remove=this.createLabel("hide",8);
			
			this.sizeInput.type=TextFieldType.INPUT;
			this.xInput.type=TextFieldType.INPUT;
			this.yInput.type=TextFieldType.INPUT;
			
			if(admob.isSupported){
				mac.text=""+admob.getMacAddress();
				screen.text=""+admob.getScreenSize().width+":"+admob.getScreenSize().height;
				admob.dispatcher.addEventListener(AdEvent.onDismissScreen,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onFailedToReceiveAd,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onLeaveApplication,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onPresentScreen,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onReceiveAd,onAdEvent);
			}
			
		}
		
		protected function onAdEvent(event:Event):void
		{
			trace(event.type);
			if(event.type==AdEvent.onReceiveAd){
				trace(admob.getAdSize().width,admob.getAdSize().height);
			}
		}
		private function createLabel(label:String,c:int):TextField{
			var l:TextField=new TextField();
			l.defaultTextFormat=format;
			l.text=label;
			l.width=160;
			this.addChild(l);
			l.x=c%3*l.width;
			l.y=int(c/3)*l.height;
			l.border=true;
			l.addEventListener(MouseEvent.CLICK,clickButton);
			return l;
		}
		/////////////////////////////
		private var gid:String="a15kkmk14bcf6437";// android id
//		private var gid:String="a14fefcfa5ab372";// ios id
		var admob:Admob=Admob.getInstance();
		protected function clickButton(event:MouseEvent):void
		{
			if(!admob.isSupported)return;
			var t:TextField=event.currentTarget as TextField;
			if(t==this.create){
				var size:int=parseInt(this.sizeInput.text);
				var adsize:AdSize=AdSize.BANNER;
				if(size==1)
					adsize=AdSize.IAB_BANNER;
				if(size==2)
					adsize=AdSize.IAB_LEADERBOARD;
				if(size==3)
					adsize=AdSize.IAB_MRECT;
				if(size==4)
					adsize=AdSize.SMART_BANNER;
				admob.createADView(adsize,gid);
				admob.setIsLandscape(true);
			}
			if(t==this.show){
				admob.addToStage(parseInt(this.xInput.text),parseInt(this.yInput.text));
				admob.load(false);
			}
			if(t==this.remove){
				admob.removeFromStage();
			}
			if(t==this.move){
				admob.addToStage(parseInt(this.xInput.text),parseInt(this.yInput.text));
			}
		}
	}
}
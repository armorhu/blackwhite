package ane.proxy.wechat
{
	import com.tencent.wechat.ane.WeChat;


	public class WechatProxy
	{
		public function WechatProxy()
		{
		}

		public static var SHARE_TO_ALL_FRIENDS:int;
		public static var SHARE_TO_SINGLE_FRIEND:int;


		public static var isSetup:Boolean;
		private static var _appid:String='';

		public static function setup(appid:String):void
		{
			try
			{
				if (WeChat.getInstance().isSupportedWX())
				{
					_appid=appid;
					SHARE_TO_ALL_FRIENDS=WeChat.SHARE_TO_ALL_FRIENDS;
					SHARE_TO_SINGLE_FRIEND=WeChat.SHARE_TO_SINGLE_FRIEND;
					isSetup=true;
				}
			}
			catch (error:Error)
			{
				trace('Wechat setup failed!!');
			}
		}

		public static function sendMail(msg:String, type:int):void
		{
			if (isSetup)
			{
				try
				{
					trace('sendMail', msg, type);
					WeChat.getInstance().initWeChat(_appid);
					WeChat.getInstance().sendText(msg, type);
				}
				catch (error:Error)
				{
					trace(error.getStackTrace());
				}
			}
		}

		public static function sendImage(img:String, title:String, msg:String, type:int):void
		{
			if (isSetup)
			{
				try
				{
					trace('sendImage', img, title, msg, type);
					WeChat.getInstance().initWeChat(_appid);
					WeChat.getInstance().sendImage(img, title, msg, type);
				}
				catch (error:Error)
				{
					trace(error.getStackTrace());
				}
			}
		}

		public static function sendLink(linkPath:String, title:String, msg:String, type:int):void
		{
			if (isSetup)
			{
				try
				{
					trace('sendLink', linkPath, title, msg, type);
					WeChat.getInstance().initWeChat(_appid);
					WeChat.getInstance().sendLink(linkPath, title, msg, type);
				}
				catch (error:Error)
				{
					trace(error.getStackTrace());
				}
			}
		}
	}
}

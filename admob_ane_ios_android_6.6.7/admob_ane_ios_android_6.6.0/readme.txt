admob for flash 
ref:https://code.google.com/p/flash-air-admob-ane-for-ios/
admob_all_in_one.ane      contains admob for ios and for android in one file,very convenient
ref: www.admob.com
requred  air sdk 3.9 or later

admob ane for air mobile ad ,support Interstitial and Banner<p/>
support  landscape and portrait  and autoOrient<p/>
support ios 5, ios 6, ios 7 ,and android<p/>
support all native event<p/>
base on admob ios sdk 6.7.0 and admob android sdk 6.4.1<p/>
air sdk 3.9 <p/>

very easy to use ,just three line code for simple usage<p/>
simple banner usage:
var admob:Admob=Admob.getInstance();<p/>
admob.setKeys("a152834c2b8cce6");<p/>
admob.showBanner(Admob.BANNER,AdPosition.BOTTOM_CENTER);<p/>

usage  Interstitial ad (full screen ad)
var admob:Admob=Admob.getInstance();
admob.setKeys("a152834c8723912");
if (admob.isInterstitialReady())// check ad has cached ,if true show it
{
     admob.showInterstitial();
}
else
{
    admob.cacheInterstitial();
}


for android.  you need add in application-app.xml
<manifest android:installLocation="auto">
     <uses-sdk android:targetSdkVersion="11"/>
     <uses-sdk android:minSdkVersion="8"/>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <application>
  	 <activity android:name="com.google.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"/> 
    </application>
</manifest>



more function
1. handler  ad event  like this.
admob.addEventListener(AdEvent.onBannerReceive, onAdReceived);
2. get ad size info
protected function onAdReceived(event:AdEvent):void
{
if(event.type==AdEvent.onBannerReceive){
	trace(event.data.width,event.data.height);
}
}
3.get screen size info,old version function,not include any more in this version
admob.getScreenSize()
4. get mac address or device id of device  ,old version function,not include any more in this version
admob.getMacAddress()
6.6.0
1.support  landscape and portrait  and autoOrient
2.support relation position and Absolute position
3.support ios 5, ios 6, ios 7 ,and android
4.update admob sdk to last version
6.4.1
enable Interstitial admob ad 
6.3.1
update:
1.include ios and android in one file
2.enable debug and pack on pc
3.base on admob6.3 no more use udid
4.enable get ad size info and screen size info

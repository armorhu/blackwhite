admob for flash 
ref:http://code.google.com/p/flash-for-mobile/
admob_all_in_one.ane      contains admob for ios and for android,file size is large,but more convenient
admob_android.ane         just contains admob for android, file size is small
admob_ios.ane           just contains admob for ios,file size is small
build base on admob ios 6.3.3 and android 6.3.1
ref: www.admob.com
requred  air sdk 3.5
usage:
var admob:Admob=Admob.getInstance();
if (admob.isSupported)
{
	admob.createADView(AdSize.BANNER, "a1514bcdferve3437"); //create a banner ad view.this init the view 
	admob.addToStage(0, 0); // ad to displaylist position 0,0
	admob.load(false); // send a ad request.  
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
admob.dispatcher.addEventListener(AdEvent.onReceiveAd,onAdEvent);
2. get ad size info
admob.getAdSize()
3.get screen size info
admob.getScreenSize()
4. get mac address or device id of device
admob.getMacAddress()


update:
1.include ios and android in one file
2.enable debug and pack on pc
3.base on admob6.3 no more use udid
4.enable get ad size info and screen size info

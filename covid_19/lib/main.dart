import 'package:covid19/NavigationBar/About.dart';
import 'package:covid19/NavigationBar/Statics.dart';
import 'package:covid19/TranslationStrings.dart';
import 'package:covid19/services/Admobbb.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NavigationBar/List.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'app_localizations.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MCS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('tr', 'TR'),

      ],
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },

      home: SplashScreen.navigate(
        name: 'assets/Covid-19.flr',
        next: (_) => MyHomePage(title: 'Covid-19'),
        until: () => Future.delayed(Duration(seconds: 0)),
        startAnimation: 'intro',
      ),




      /*SplashScreen(
        'assets/covid19.flr',
        MyHomePage(title: 'Covid-19'),
        startAnimation: 'intro',
        backgroundColor: Color(0xff181818),
      ),*/
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;




  static void Refresh(){
    _MyHomePageState.Refresh();
  }

  static void Hatalihareket(){
    _MyHomePageState.refreshlact=true;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static void Settime(DateTime time){
    _MyHomePageState.time=time;
  }

  static DateTime Gettime(){
    return _MyHomePageState.time;
  }


}

class _MyHomePageState extends State<MyHomePage> {

  final AdvertService _advertService = AdvertService();

  static DateTime time = DateTime.now();

  static bool refreshlact = false;
  bool first =true;

  static String language ;
  static TranslationStrings ts;

  static Listact lact;
  static Statics sact;
  Widget widgetact;

  String appbartitle;

  static void Refresh(){
    sact.getData();
    //lact.imageSlidersupdate();
    refreshlact = true;
  }

  // ignore: must_call_super
  void initState(){
    FirebaseAdMob.instance.initialize(
        appId: _advertService.getAdMobAppId(),);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
         };


  }



  waittimer(int i) async{
    try{
      await Future.delayed(Duration(milliseconds: i),(){});
      lact.Refresh();
    }catch(e){

    }
  }

  Future<List<String>> Load()async{
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    var list = prefs.getStringList("countries") != null ?  prefs.getStringList("countries"):
    (language=="TR") ? ["all","turkey"] :["all"];
    Listact.countrylist = list;

  }

  @override
  Widget build(BuildContext context) {
    if(language!=AppLocalizations.of(context).translate("language")){
      language = AppLocalizations.of(context).translate("language");
      List<String> basket = [];
      Load().then((value) => basket = value);
      print("language: " + language);
      ts = TranslationStrings(language,context);
      lact = Listact(language, time,ts);
      sact = Statics(lact, ts,);
      widgetact = lact;
      appbartitle = ts.Listbartitle;

      Load();

      sact.getData();
      lact.imageSlidersupdate();
    }
    return Scaffold(
      backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            color: Colors.grey[100],
            buttonBackgroundColor: Colors.grey[100],
            backgroundColor: Colors.white,
            items: <Widget>[
              Icon(Icons.assessment, size: 30),
              Icon(Icons.star, size: 30),
              Icon(Icons.help_outline,color: Colors.black, size: 30),
            ],
            index: 0,
            animationDuration: Duration(
              milliseconds: 800,
            ),
            animationCurve: Curves.easeInOutQuart,
            onTap: (index) {
              setState(() {

                if(index==0){
                  widgetact=lact;
                  appbartitle = ts.Listbartitle;
                  if(refreshlact){

                    waittimer(900);
                    refreshlact=false;
                    RewardedVideoAd.instance.show();
                  }
                }else if(index==1){
                  RewardedVideoAd.instance.load(
                      adUnitId: _advertService.getVideoid(),
                      targetingInfo: _advertService.getTargetinfo());
                  widgetact=sact;
                  appbartitle = ts.Staticsbartitle;
                }else if(index==2){

                  widgetact=Aboutact(ts);
                  appbartitle = ts.Aboutbartitle;
                }

              });

            },
          ),

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.grey[100],
        title: Text(appbartitle),
      ),
      body: widgetact,
    );
  }
}

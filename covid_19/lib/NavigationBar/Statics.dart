import 'dart:convert';
import 'package:covid19/main.dart';
import 'package:covid19/services/Admobbb.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:covid19/NavigationBar/List.dart';
import 'package:covid19/TranslationStrings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Statics extends StatelessWidget {


  final AdvertService _advertService = AdvertService();

  bool videoadd = false;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  Listact lact;
  TranslationStrings ts;
  List<String> contriesinapi = [];
  List<String> languagecountries = [];

  BuildContext bcontext;

  static IndexedScrollController controller = IndexedScrollController(initialIndex: 0);

  Statics(Listact lact, TranslationStrings ts) {
    this.lact = lact;
    this.ts = ts;
    //getData();
  }

  Future<List> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://covid-193.p.rapidapi.com/countries"),
        headers: {
          "x-rapidapi-host": "covid-193.p.rapidapi.com",
          "x-rapidapi-key":
              "7415dcc9d4mshf76404075a3ba34p12a8d3jsndefa14899c55",
        });

    Map<String, dynamic> data = jsonDecode(response.body);

    try {
      var dynamiclist = data["response"];

       for(int i=0;dynamiclist[i]!=null;i++) {
        String basket=dynamiclist[i].toString();
        //print(i.toString()+"  "+basket);
        contriesinapi.add(basket);
        languagecountries.add(ts.Country(basket));
      }
    } catch (e) {
      print("statics catch in içi    "+e.toString());
       //print(contriesinapi.length);
      print("\n\n");
    }
  }

  int BenimSiralamaMethodum(String bir,String iki){


    double ilkskor=0;
    double ikinciskor=0;
    int onuzeri=6;
    for(int i=0;i<bir.length;i++){
      int carpan = Alfabekacinciharfskorcarpani(bir[i]);
      carpan != -1 ? ilkskor+=carpan* pow(10, onuzeri) : //print("!!!sort methodu -1 geldi harf: "+bir[i]);
      onuzeri-=2;
    }

    onuzeri=6;
    for(int i=0;i<iki.length;i++){
      int carpan = Alfabekacinciharfskorcarpani(iki[i]);
      carpan != -1 ? ikinciskor+=carpan* pow(10, onuzeri) : //print("!!!sort methodu -1 geldi harf: "+iki[i]);
      onuzeri-=2;
    }
    //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!sortmethdoum  "+bir+": "+ilkskor.toString()+"--- ${iki}: ${ikinciskor}");
    return ilkskor>ikinciskor ? 0 : 1;
  }

  int Alfabekacinciharfskorcarpani(String harf){
    List <String> alfabe= ["a","b","c","ç","d","e","f","g","ğ","h","ı","i","j","k","l","m","n","o","ö","p","q","r","s","ş","t","u","ü","v","w","x","y","z"];

    for(int i=0;i<alfabe.length;i++){
      if(alfabe[i]==harf.toLowerCase()){
        return alfabe.length-i;
      }
    }
    return -1;
  }

  void Sort(){
    String temp="";
    for(int i=0;i<languagecountries.length;i++){
      for(int j=i+1;j<languagecountries.length;j++){
       if(BenimSiralamaMethodum(languagecountries[i],languagecountries[j])==1){
         temp = contriesinapi[i];
         contriesinapi[i]=contriesinapi[j];
         contriesinapi[j]=temp;

         temp = languagecountries[i];
         languagecountries[i]=languagecountries[j];
         languagecountries[j]=temp;
       }
      }
    }

  }


  bool isincountrylist(String country){
    for(int i=0;i<Listact.countrylist.length;i++){
     // print(contriesinapi[i]);
     // print(Listact.countrylist[i]+"!!!!!!!!!!!!!!!!!${country} ");
      if(Listact.countrylist[i]==country.toLowerCase()){
        return true;
      }
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    _advertService.showIntersinitial();
    Sort();
    bcontext = context;
    print("!!!!!Build!!!!!");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          /*         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ...Iterable<int>.generate(Listact.countrylist.length).map(
                    (int Index) => Flexible(
                  child: returnbutton(Listact.countrylist[Index],Index,context),
                ),
              ),
            ],
          ),*/

          Expanded(
            child: IndexedListView.builder(
              controller: controller,
              itemBuilder: itemBuilder(),
              minItemCount: 0,
              maxItemCount: contriesinapi.length-1,
            ),
          ),

   /*       ...Iterable<int>.generate(Listact.countrylist.length).map(
                (int Index) => Flexible(
              child: Card(
                child: GestureDetector(
                  child: ListTile(
                    leading: boolList[Index] ? Icon(Icons.star) : Icon(Icons.star_border),
                    title: returnbutton(Listact.countrylist[Index],Index,context),
                    onTap: (){
                      boolList[Index]!=boolList[Index];
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
              ),
            ),
          ),*/


        ],
      ),
    );
  }

  Function itemBuilder() {
    print("!!!!!itemBuilder!!!!!");


    return (BuildContext context, int index) {

      try{

      return Card(
          child: GestureDetector(
          child: ListTile(
          leading: isincountrylist(contriesinapi[index]) ? Icon(Icons.star,color: Colors.yellow[700],) : Icon(Icons.star_border),
      title: Text(ts.Country(languagecountries[index])),
      onTap: (){

           if(Listact.countrylist.length<10||isincountrylist(contriesinapi[index])){


      isincountrylist(contriesinapi[index]) ? Listact.countrylist.remove(contriesinapi[index].toLowerCase()) : Listact.countrylist.add(contriesinapi[index].toLowerCase());

      Save(Listact.countrylist);

      MyHomePage.Refresh();
            (context as Element).markNeedsBuild();}else{

             Fluttertoast.cancel();
             Fluttertoast.showToast(
                 msg: ts.morethanninecountry,
                 toastLength: Toast.LENGTH_LONG,
                 gravity: ToastGravity.BOTTOM,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.grey,
                 textColor: Colors.black,
                 fontSize: 16
             );

           }

      },
      ),
      ),
      );}catch(e){
        return Container(
          height: 10,
          width: 10,
        );
      }
    };
  }

  void Save(List<String> list) async{
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setStringList("countries", list);

  }



  Widget returnbutton(String country,int index,BuildContext context){



    return ProgressButton(

      defaultWidget:  Text(
        ts.Country(country),
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 10,),
      ),
      progressWidget: const CircularProgressIndicator(),
      width: 196,
      height: 40,
      onPressed: () async {
        int score = await Future.delayed(
            const Duration(milliseconds: 1000), () => 42);
        // After [onPressed], it will trigger animation running backwards, from end to beginning
        return () {
         // Listact.countrylist.removeAt(index);

          //(context as Element).markNeedsBuild();
          // Optional returns is returning a function that can be called
          // after the animation is stopped at the beginning.
          // A best practice would be to do time-consuming task in [onPressed],
          // and do page navigation in the returned function.
          // So that user won't missed out the reverse animation.
        };
      },
    );



      RaisedButton(
        onPressed: () {},
        child: Text(
          ts.Country(country),
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10,),
        ),);
  }



}

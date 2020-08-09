import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19/TranslationStrings.dart';
import 'package:covid19/main.dart';
import 'package:covid19/services/Admobbb.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Listact extends StatelessWidget {


  final AdvertService _advertService = AdvertService();

  double screenheigt = 0;
  double containerheigt = 0;

  final CarouselController _controller = CarouselController();
  static List<String> countrylist = ["all"];
  bool first;

  bool warning=true;

  List<Widget> imageSliders = [];

  BuildContext bcontext = null;

  DateTime _dateTime;
  TranslationStrings ts;

  String   population = "?";
  String newcases = "?";
  String  activecases = "?";
  String  totalrecoverd = "?";
  String  totalcases = "?";
  String  newdeceased = "?";
  String  totaldeceased = "?";
  String  totaltest="?";

  Listact(String language,DateTime time,TranslationStrings ts) {
    _dateTime = time;
    this.ts = ts;
    //imageSlidersupdate();
    first=true;
    print("constructor");
  }



  String Calendar(String date) {
    String year = date.split(" ")[0].split("-")[0];
    String month = date.split(" ")[0].split("-")[1];
    String day = date.split(" ")[0].split("-")[2];
    return year +" "+ts.Month(month)+" "+day;
  }

  Future<List> getData(String country) async {

    try {
    var response = await http.get(Uri.encodeFull(
        "https://covid-193.p.rapidapi.com/history?day="+_dateTime.toString().split(" ")[0]+"&country="+country),
      headers: {
        "x-rapidapi-host" : "covid-193.p.rapidapi.com",
        "x-rapidapi-key" : "7415dcc9d4mshf76404075a3ba34p12a8d3jsndefa14899c55",
      }
    );

    //print("alll response !!!!!!!!!!!  "+response.body);
    Map<String, dynamic> data = jsonDecode(response.body);



        population = data["response"][0]["population"].toString() == "null"
            ? "?"
            : data["response"][0]["population"].toString();
        newcases = data["response"][0]["cases"]["new"].toString() == "null"
            ? "?"
            : data["response"][0]["cases"]["new"].toString();
        activecases =
        data["response"][0]["cases"]["active"].toString() == "null"
            ? "?"
            : data["response"][0]["cases"]["active"].toString();
        totalrecoverd =
        data["response"][0]["cases"]["recovered"].toString() == "null"
            ? "?"
            : data["response"][0]["cases"]["recovered"].toString();
        totalcases = data["response"][0]["cases"]["total"].toString() == "null"
            ? "?"
            : data["response"][0]["cases"]["total"].toString();
        newdeceased = data["response"][0]["deaths"]["new"].toString() == "null"
            ? "?"
            : data["response"][0]["deaths"]["new"].toString();
        totaldeceased =
        data["response"][0]["deaths"]["total"].toString() == "null"
            ? "?"
            : data["response"][0]["deaths"]["total"].toString();
        totaltest = data["response"][0]["tests"]["total"].toString() == "null"
            ? "?"
            : data["response"][0]["tests"]["total"].toString();

        print("_dateTime: "+Calendar(_dateTime.toString())+"  country:  "+country+"  "+population + " " + newcases + " " + activecases + " " +
            totalrecoverd + " " + totalcases + " " + newdeceased + " " +
            totaldeceased + " " + totaltest);
      }catch (e){
        print(e.toString()+"   "+"catch içi");
        population = "?";
        newcases = "?";
        activecases = "?";
        totalrecoverd = "?";
        totalcases = "?";
        newdeceased = "?";
        totaldeceased = "?";
        totaltest="?";

        if(e.toString().substring(0,15)=="SocketException"&&warning) {
          warning=false;
          showDialog(
              context: bcontext,
              builder: (BuildContext context) {
                return
                  AlertDialog(

                      title: Text(ts.networkwarning)

                  );
              }

          );
        }
/*
        Fluttertoast.cancel();
        Fluttertoast.showToast(
          msg: ts.Country(country)+ " için yeterince veri yok.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16
        );
*/

    }
  }




  @override
  Widget build(BuildContext context) {
  print("build");
  if(countrylist.length<1||countrylist.contains(null)){
    countrylist.add("all");
    if(ts.language=="TR"){
      countrylist.add("turkey");
    }
  }else{
    _advertService.showIntersinitial();
  }
    bcontext = context;
    screenheigt = MediaQuery.of(context).size.height;
    containerheigt = MediaQuery.of(context).size.height-((MediaQuery.of(context).size.height)/2.45);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.date_range),
                iconSize: 30,
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(2019),
                          lastDate: DateTime(2021))
                      .then((date) {
                        if(date!=null){

                    _dateTime = date;
                    MyHomePage.Settime(date);
                    imageSlidersupdate();

                        }
                    (context as Element).markNeedsBuild();
                  });
                },
              ),
              Text(Calendar(_dateTime == null
                  ? DateTime.now().toString()
                  : _dateTime.toString()),style: TextStyle(fontStyle: FontStyle.normal,fontSize: 22),),

              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: (){
                  MyHomePage.Refresh();
                },
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: RaisedButton(
                        onPressed: () => _controller.previousPage(),
                        child: Text('←'),
                      ),
                    ),
                    ...Iterable<int>.generate(countrylist.length).map(
                          (int pageIndex) => Flexible(
                        child: RaisedButton(
                          onPressed: () => _controller.animateToPage(pageIndex),
                          child: Text((countrylist.length>3) ? Writeupsidedown(ts.Country(countrylist[pageIndex])) : (ts.Country(countrylist[pageIndex]).length>7) ? ts.Country(countrylist[pageIndex]).substring(0,7) : ts.Country(countrylist[pageIndex]) ,
                            style: TextStyle(fontSize: countrylist.length>3 ? 6.1: (15-countrylist.length)*0.9),
                          ),
                        ),
                      ),
                    ),

                    Flexible(
                      child: RaisedButton(
                        onPressed: () => _controller.nextPage(),
                        child: Text('→',),
                      ),
                    ),
                    /*...Iterable<int>.generate(imgList.length).map(
                          (int pageIndex) => Flexible(
                        child: RaisedButton(
                          onPressed: () => _controller.animateToPage(pageIndex),
                          child: Text("$pageIndex"),
                        ),
                      ),
                    ),*/
                  ],
                ),
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(enlargeCenterPage: true,
                  height: containerheigt,),
                  carouselController: _controller,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

    void Refresh(){

      imageSlidersupdate();
      (bcontext as Element).markNeedsBuild();
    }

    String Writeupsidedown(String s){
      var charlist = s.split("");
    if(s.length>4){
      String a = " ";
      a+=s;
      charlist = a.substring(0,5).split("");
    }else{
      String a = " "+s;
      for(int i=s.length;i<4;i++){
        a+=" ";
      }

      charlist = a.split("");
    }

    String basket="";
    charlist.forEach((element) {basket+=element+"\n"; });
    return basket;
    }

    void imageSlidersupdate ()async{
    double fontsize=((15-countrylist.length)*0.9);
    print(containerheigt.toString()+"    fontsize: "+fontsize.toString());
    double multiple = containerheigt/375;


    imageSliders = [];
    try {
      for (int i = 0; i < countrylist.length; i++) {
        print("imagesliderupdate i:  ${i}");
        int a = 600;

        await getData(countrylist[i]);

        imageSliders.add(
            !(newcases == "?" && newdeceased == "?" && totalrecoverd == "?" &&
                population == "?") ?
            Container(
              height: double.infinity,
              width: double.infinity,
              //color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 10 * multiple,
                    width: 10 * multiple,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40 * multiple,
                        width: 200 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(ts.Country(countrylist[i]),
                              style: TextStyle(fontSize: 20 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.population + " " +
                                ts.NumberFortmat(population),
                              style: TextStyle(fontSize: 10 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Container(
                        height: 5 * multiple,
                        width: 10 * multiple,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60 * multiple,
                        width: 160 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(ts.newcases, style: TextStyle(fontSize: 15 *
                                multiple, color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.NumberFortmat(newcases),
                              style: TextStyle(fontSize: 15 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text("", style: TextStyle(fontSize: 5 * multiple,
                                color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.totalcases + " " +
                                ts.NumberFortmat(totalcases),
                              style: TextStyle(fontSize: 10 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                      Container(
                        height: 5 * multiple,
                        width: 10 * multiple,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60 * multiple,
                        width: 160 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a += 100],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(ts.language=="TR" ? ts.newdeceased + "\t\t" +
                                ts.NumberFortmat(newdeceased): ts.newdeceased + "\n" +
                                ts.NumberFortmat(newdeceased),
                              style: TextStyle(fontSize: 15 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text("", style: TextStyle(fontSize: 5 * multiple,
                                color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.totaldeceased + " " +
                                ts.NumberFortmat(totaldeceased),
                              style: TextStyle(fontSize: 10 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                      Container(
                        height: 5 * multiple,
                        width: 10 * multiple,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40 * multiple,
                        width: 160 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(ts.activecases, style: TextStyle(fontSize: 15 *
                                multiple, color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.NumberFortmat(activecases),
                              style: TextStyle(fontSize: 15 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                      Container(
                        height: 5 * multiple,
                        width: 10 * multiple,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40 * multiple,
                        width: 160 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a += 100],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              ts.totalrecoverd, style: TextStyle(fontSize: 15 *
                                multiple, color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.NumberFortmat(totalrecoverd),
                              style: TextStyle(fontSize: 15 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                      Container(
                        height: 5 * multiple,
                        width: 10 * multiple,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40 * multiple,
                        width: 160 * multiple,
                        decoration: new BoxDecoration(
                            color: Colors.teal[a],
                            border: Border.all(
                              color: Colors.teal[a],
                            ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(ts.totaltest, style: TextStyle(fontSize: 15 *
                                multiple, color: Colors.white),
                              textAlign: TextAlign.center,),
                            Text(ts.NumberFortmat(totaltest),
                              style: TextStyle(fontSize: 15 * multiple,
                                  color: Colors.white),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              /*
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),*/

            ) :
            Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              child: Text(ts.Country(countrylist[i]) + " \n\n\n" + ts.datanull +
                  "\n\n\n"),
            )
        );
        (bcontext as Element).markNeedsBuild();
      }
    }catch(e){
      print("imagesliderupdate   catch hata: "+e.toString());
      print(e.toString().substring(0,63));
      MyHomePage.Hatalihareket();

    }
    if(first){
      first=false;
      Refresh();
    }

    //print("!!!!!!!!!!!!!!!!!!! "+screenheigt.toString()+"   "+containerheigt.toString());
  }
}

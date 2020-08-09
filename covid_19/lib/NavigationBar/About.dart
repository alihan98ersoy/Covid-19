import 'package:covid19/TranslationStrings.dart';
import 'package:covid19/services/Admobbb.dart';
import 'package:flutter/material.dart';
import "package:covid19/about_icons.dart";

class Aboutact extends StatelessWidget {

  final AdvertService _advertService = AdvertService();

  TranslationStrings ts;

  Aboutact(this.ts);

  @override
  Widget build(BuildContext context) {
    _advertService.showBanner();
    _advertService.showIntersinitial();
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[

              Container(
                height: 40 ,
                width: double.infinity,
                decoration: new BoxDecoration(
                    color: Colors.black54,
                    border: Border.all(
                      color: Colors.black38,
                    ),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Container(height: 5,width: 10,),
                    Text(ts.howcaniprotectmyself,style: TextStyle(fontSize: 25,color: Colors.white),textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  IconButton(
                    icon: Icon(Icons.home),
                  ),
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  Text(ts.home),
                ],
              ),
              Container(height: 5,width: 10,),
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  IconButton(
                    icon: Icon(About.mask),
                  ),
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  Text(ts.maskekullan),
                ],
              ),
              Container(height: 5,width: 10,),
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  IconButton(
                    icon: Icon(About.washhand),
                  ),
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  Text(ts.washhand),
                ],
              ),
              Container(height: 5,width: 10,),
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  IconButton(
                    icon: Icon(About.distance),
                  ),
                  Container(
                    width: 10,
                    height: 1,
                  ),
                  Text(ts.distance),
                ],
              ),
              Container(height: 5,width: 10,),
            ],
          ),

        )
    );
  }
}

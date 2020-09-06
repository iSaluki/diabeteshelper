import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:diabeteshelper/Widget/applogo.dart';
import 'package:diabeteshelper/fooddetail.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'package:diabeteshelper/models/foodmodel.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  List<foodmodel> fooddata = new List();
  String fdata;
  bool _loading = false;
  String query = "";
  String ddata="";
  AdmobBannerSize bannerSize;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: Initialize _bannerAd

    bannerSize = AdmobBannerSize.BANNER;

    // TODO: Load a Banner Ad

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: AppLogo(),
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),

      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xff063000),
                      const Color(0xffffffff)
                    ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical:  30, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Lookup any food",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  Text(
                    "Just enter the food type and we'll load the results for you!",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OverpassRegular'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Overpass'),
                            decoration: InputDecoration(
                              hintText: "Enter food",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: 'Overpass'),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  _loading = true;
                                });
                                fooddata = new List();


                                String url =
                                    "https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=${textEditingController.text}&app_id=fa4127dc&app_key=106896ea69b315214411d6bdefbf21d6";
                                var response = await http.get(url);

                                Map<String, dynamic> jsonData =
                                jsonDecode(response.body);
//                                print("this is json Data $jsonData");
                                jsonData["parsed"].forEach((element) {
//                                  print(element.toString());
                                  foodmodel foodModel = new foodmodel();
                                  foodModel =  foodmodel.fromMap(element['food']);

                                  fooddata.add(foodModel);
                                  print(foodModel.image);
                                });
                                setState(() {
                                  _loading = false;
                                });

                                print("doing it");
                                print(url);
                              } else {
                                print("not doing it");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffA2834D),
                                        const Color(0xffBC9A5F)
                                      ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Colors.white
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  fooddata.length!=0?Container(

                    child: GridView(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),

                        shrinkWrap: true,

                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: List.generate(fooddata.length, (index) {
                          return

                            GridTile(
                                child: FoodTile(
                                  title: fooddata[index].label,
                                  imgUrl: fooddata[index].image,
                                  desc: fooddata[index].source,

                                  carbs: fooddata[index].nutrient,
                                ));
                        })),
                  ):
                  Center(

                    child: Column(
                      children: [
                        SizedBox(height: 300,),
                        Container(

                          child: new SpinKitCubeGrid(
                            color: Colors.green[900],
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Center(
                child: Container(

                          width: MediaQuery.of(context).size.width,
                  child: AdmobBanner(

                    adUnitId: "ca-app-pub-6099843304230476/6601492865",
                    adSize: bannerSize,


                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
class FoodTile extends StatefulWidget {
  final String title, imgUrl,desc,url;
  final double carbs;

  FoodTile({this.title,  this.imgUrl, this.carbs,this.desc,this.url});

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {


              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                       imgUrl: widget.imgUrl,
                        carbs: widget.carbs,
                        name: widget.title,
                      )));
            },

          child: Container(

            margin: EdgeInsets.all(8),
            child: Container(

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),),
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Image.network(

                        widget.imgUrl,
                        height: 200,
                        width: 200,


                      ),
                    ),
                    Container(

                      width: 200,
                      alignment: Alignment.bottomLeft,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          gradient: LinearGradient(
                              colors: [Colors.white30, Colors.white],
                              begin: FractionalOffset.centerRight,
                              end: FractionalOffset.centerLeft)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontFamily: 'Overpass'),
                            ),
                            Text(
                              widget.desc,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                  fontFamily: 'OverpassRegular'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {this.topColor,
        this.bottomColor,
        this.topColorCode,
        this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

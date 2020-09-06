
import 'package:diabeteshelper/Widget/applogo.dart';
import 'package:flutter/material.dart';

import 'package:beauty_textfield/beauty_textfield.dart';

class RecipeView extends StatefulWidget {
  final String imgUrl;
  final double carbs;
  final String name;

  const RecipeView({ this.imgUrl, this.carbs, this.name});



  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  double unitdata;

  String finalUrl ;
  double c;
  String nam;
  double fdata=0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.imgUrl;
    c= widget.carbs;
    nam=widget.name;
    print(finalUrl);
    print(c);
    print(nam);


  }


  double calcarbs(double userin){
    return userin*(c/100);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppLogo(),
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          //brightness: Brightness.li,
        ),
        body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),


                        SizedBox(height: 40,),
                        Column(
                          children: [

                            Container(
                              height: 200,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width-10,
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: NetworkImage(widget.imgUrl)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 80,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Center(
                                child: Text(
                                  nam,
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Center(
                                child: Text(
                                  "Total Carbs "+ c.toString()+ " per 100 (g)",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            BeautyTextfield(
                              width: double.maxFinite,
                              height: 60,
                              duration: Duration(milliseconds: 300),
                              inputType: TextInputType.text,
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(Icons.remove_red_eye),
                              placeholder: "Enter weight of food (grams)",

                              onChanged: (data) {

                                setState(() {
                                  if(data==null){
                                    setState(() {
                                      fdata=calcarbs(0);}
                                    );}
                                  else{
                                    setState(() {
                                      fdata=calcarbs(double.parse(data));
                                    });

                                  }

                                });
                              },
                              onSubmitted: (data) {
                                print(calcarbs(double.parse(data)));
                                setState(() {
                                  if(data==null){
                                    setState(() {
                                      fdata=calcarbs(0);}
                                    );}
                                  else{
                                    setState(() {
                                      fdata=calcarbs(double.parse(data));
                                    });

                                  }

                                });
                              },
                            ),
                            SizedBox(height: 20,),
                            Container(
                              child: Center(
                                  child:Text(
                                    "This is "+fdata.toString().substring(0,3)+ " carbs",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ]));
  }


}


import 'package:diabeteshelper/Widget/applogo.dart';
import 'package:flutter/material.dart';
import 'package:diabeteshelper/pages/urusole.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class insulincal extends StatefulWidget {
  final String imgUrl;
  final double carbs;
  final String name;


  const insulincal({ this.imgUrl, this.carbs, this.name});



  @override
  _insulincalState createState() => _insulincalState();
}

class _insulincalState extends State<insulincal> {
  AdmobBannerSize bannerSize;
  double unitdata;

  String finalUrl ;
  double c,ins,ca;
  String nam;
  double fdata=0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;



  }
  _launchArticleURL1( String ur) async {

    if (await canLaunch(ur)) {
      await launch(ur);
    } else {
      throw 'Could not launch $ur';
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Text(" if you take a total of 25 units of insulin in a  typical day, each unit of insulin should cover approximately 20 grams of carbohydrate (500 ÷ 25 = 20). If you take 60 units  daily, your I:C ratio would be 1  unit per 8 grams of carb (500 ÷ 60 ≅ 8)."),








              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double insulinratio(double insulin, double carbs){
    if(insulin==null|| carbs==null){
      return 0.0;
    }
    else{
      return carbs/insulin;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppLogo(),
          actions: [

          ],
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
                      CarouselPage(),
                      SizedBox(height: 10,),

                      Column(
                        children: [

                          Center(
                            child: GestureDetector(
                              onTap: () => {

                                _launchArticleURL1("https://www.nhs.uk/conditions/Diabetes/")

                              },
                              child: Container(
                                margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                                //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Center(
                                    child: Text(
                                      'Diabetes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'CircularB',
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                height: 60.0,
                                width: MediaQuery.of(context).size.width ,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue,
                                  image: DecorationImage(
                                    image: NetworkImage("https://images.unsplash.com/photo-1463367620918-d4824d05ce0e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1952&q=80"),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          GestureDetector(
                            onTap: () => {
                              _launchArticleURL1("https://www.diabetes.co.uk/forum")

                            },
                            child: Container(
                              margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                  child: Text(
                                    'Global Diabetes community ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'CircularB',
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              height: 60.0,
                              width: MediaQuery.of(context).size.width ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: NetworkImage("https://images.unsplash.com/photo-1573883430697-4c3479aae6b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          GestureDetector(
                            onTap: () => {


                              _launchArticleURL1("https://forum.diabetes.org.uk/boards/")
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                  child: Text(
                                    'Diabetes UK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'CircularB',
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              height: 60.0,
                              width: MediaQuery.of(context).size.width ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: NetworkImage("https://images.unsplash.com/photo-1542736667-069246bdbc6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          GestureDetector(
                            onTap: () => {

                              _launchArticleURL1("https://www.diabetes.org.uk/diabetes-the-basics/diabetes-symptoms")
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                              //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                  child: Text(
                                    'Diabetes Symptoms',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'CircularB',
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              height: 60.0,
                              width: MediaQuery.of(context).size.width ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),

                                color: Colors.blue,

                                image: DecorationImage(
                                  image: NetworkImage("https://images.unsplash.com/photo-1583604310111-9cd137d6ffe5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),




                      SizedBox(height: 20,),

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

                        adUnitId: "ca-app-pub-6099843304230476/1857444409",
                        adSize: bannerSize,


                      ),
                    ),
                  ),
                ],
              ),

            ]));
  }


}

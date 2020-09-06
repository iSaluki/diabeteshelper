
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CarouselPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        boxFit: BoxFit.cover,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 4000),
        dotSize: 6.0,
        dotIncreasedColor: Colors.white,
        dotColor: Colors.grey,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://images.unsplash.com/photo-1562245376-3f9dae9f0e73?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        'Helpful Resources',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28,
                          color: Colors.white,),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Find some resources here to help you manage your diabetes ', style: TextStyle(fontSize: 21,
                            color: Colors.white,
                        fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 60),
                      //   RaisedButton(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(2.0),
                      //     side: BorderSide(color: Colors.white)),
                      //   onPressed: () {},
                      //   color: Colors.white.withOpacity(0),
                      //   textColor: Colors.white,
                      //   child: Text("köp här".toUpperCase(),
                      //     style: TextStyle(fontSize: 20)),
                      // ),

                      SizedBox(height: 30)
                    ]),
              ]
          ),
          Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  fit: BoxFit.cover,
                  image:NetworkImage('https://images.unsplash.com/photo-1593491205049-7f032d28cf5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        ' Connect with others',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Find forums and communities to help you with your questions', style: TextStyle(fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 60),
                      //   RaisedButton(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(2.0),
                      //     side: BorderSide(color: Colors.white)),
                      //   onPressed: () {},
                      //   color: Colors.white.withOpacity(0),
                      //   textColor: Colors.white,
                      //   child: Text("köp här".toUpperCase(),
                      //     style: TextStyle(fontSize: 20)),
                      // ),

                      SizedBox(height: 30)
                    ]),
              ]
          ),
          Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  fit: BoxFit.cover,
                  image:  NetworkImage('https://images.unsplash.com/photo-1576169210859-6796c4b93c32?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        'Expand your knowledge',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28,
                          color: Colors.black,),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Learn more about diabetes, managing it, and the effects it has on your body.', style: TextStyle(fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 60),
                      //   RaisedButton(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(2.0),
                      //     side: BorderSide(color: Colors.white)),
                      //   onPressed: () {},
                      //   color: Colors.white.withOpacity(0),
                      //   textColor: Colors.white,
                      //   child: Text("köp här".toUpperCase(),
                      //     style: TextStyle(fontSize: 20)),
                      // ),

                      SizedBox(height: 30)
                    ]),
              ]
          ),
        ],
      ),
    );
  }
}
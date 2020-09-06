import 'package:diabeteshelper/Widget/applogo.dart';

import 'package:diabeteshelper/database/database.dart';
import 'package:diabeteshelper/models/logbookmodel.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:diabeteshelper/pages/add_editclient.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:data_tables/data_tables.dart';


class logbook extends StatefulWidget {
  @override
  _logbookState createState() => _logbookState();
}


class _logbookState extends State<logbook> {
  static Database _db;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var dbName = "client.db";
  var path, dbPath, dir;
  AdmobBannerSize bannerSize;
  @override
  void didUpdateWidget(logbook oldWidget) {

    setState(() {
      super.didUpdateWidget(oldWidget);
    });
  }


  @override
  void initState() {

    bannerSize = AdmobBannerSize.BANNER;
setState(() {

});
super.initState();
DatabaseProvider.db.getAllClients();
    getPermission();
  }
  getPermission() async {
    await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage)
        .then((status) {
      if (status == PermissionStatus.denied) {
        requestPermission();
      }
    });
  }


  requestPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
  Future<void> _showMyDialog(String data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(data),

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: (){
              DatabaseProvider.db.excel().then((value){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("saved in "+value),
                ));
              });
              setState(() {
              });
            },
            child: Text('Export Data',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,

                    color: Colors.black
                )
            ),
          )
        ],
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),

      body:Stack(
        children: [

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

              padding: EdgeInsets.symmetric(vertical:  5, horizontal: 15),
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [Colors.green[900], Colors.black45],

                      ),
                      border: Border.all(

                          width: 2.0,
                          style: BorderStyle.solid
                      ),

                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Date Time",
                              style: TextStyle(
                                fontSize: 18,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Carbs (g)",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("BG level",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Activity",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Insulin",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                              )
                            ],
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Notes",style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),
                            )
                          ],
                        ),
                      ),



                      ],
                    ),
                  ),
                        SizedBox(height: 10,),
                  FutureBuilder<List<logmodel>>(
                    //we call the method, which is in the folder db file database.dart
                    future: DatabaseProvider.db.getAllClients(),
                    builder: (BuildContext context, AsyncSnapshot<List<logmodel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          //Count all records
                          itemCount: snapshot.data.length,
                          //all the records that are in the client table are passed to an item Client item = snapshot.data [index];
                          itemBuilder: (BuildContext context, int index){
                            logmodel item = snapshot.data[index];
                            //delete one register for id
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddEdit(
                                      true,
                                      //Here is the record that we want to edit
                                      client: item,
                                    )

                                )
                                );
                                setState(() {

                                });
                              },
                              onLongPress: (){
                                DatabaseProvider.db.deleteClientWithId(item.id);
                                setState(() {

                                });
                              },
                              child: Container(

                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    colors: [Colors.green[900], Colors.black45],

                                  ),
                                  border: Border.all(

                                      width: 2.0,
                                      style: BorderStyle.solid
                                  ),

                                ),
                                child: Row(

                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("Date: "+item.dtetime.toString().substring(0,10),
                                            style: TextStyle(
                                                color: Colors.white
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(item.carbs,
                                          style: TextStyle(
                                      color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(item.bglocouse,
                                            style: TextStyle(
                                                color: Colors.white
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(item.activity,style: TextStyle(
                                              color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(item.insulin,
                                            style: TextStyle(
                                                color: Colors.white
                                            ),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(

                                        children: [
                                          InkWell(

                                            child: Text("View Notes",
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                            onTap: (){
                                              _showMyDialog(item.notes==null?" no note data":item.notes);
                                            },
                                          )
                                        ],
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }else {
                        return Center(child: CircularProgressIndicator(


                        ));
                      }
                    },
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

                    adUnitId: "ca-app-pub-6099843304230476/2978954383",
                    adSize: bannerSize,


                  ),
                ),
              ),
            ],
          ),
          //This button takes us to the method add new register, which is in the file add_editclient.dart

        ],

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEdit(false)));
          setState(() {

          });
        },
      ),

    );
  }
}



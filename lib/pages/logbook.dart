import 'dart:io';

import 'package:diabeteshelper/Widget/applogo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:diabeteshelper/database/database.dart';
import 'package:diabeteshelper/models/logbookmodel.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';


class logbook extends StatefulWidget {

  @override
  _logbookState createState() => _logbookState();
}


class _logbookState extends State<logbook> {

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

  TextEditingController activtyEditingController = TextEditingController();
  TextEditingController insulinEditingController = TextEditingController();
  TextEditingController bgEditingController = TextEditingController();
  TextEditingController carbsEditingController = TextEditingController();
  TextEditingController notesEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   bool edit=false;
String ac="";
String t =DateTime.now().toString();

logmodel clint;
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
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<String> activit = [
    "Breakfast", "Lunch", "Dinner", "Walking", "Cycling"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: (){

              DatabaseProvider.db.excel().then((value) async {

                ShareExtend.share(value, "report");


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
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.white,
                          width: 1.0,

                          style: BorderStyle.solid
                      ),
                      

                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Container(),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Date & Time",
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
                    future: DatabaseProvider.db.search("carbs", "2"),
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
                                print("ye data"+snapshot.data[index].activity);
                                  Alert(
                                      context: context,
                                      title: "Enter logs",
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            DropDownField(
                                                value:  snapshot.data[index].activity,
                                                icon: Icon(Icons.local_activity),
                                                required: false,
                                                hintText: 'Choose a activity',
                                                labelText: 'Activity',
                                                items: activit,
                                                strict: false,
                                                onValueChanged: (dynamic newValue) {

                                                  ac=newValue  ;



                                                }),
                                            DateTimePicker(
                                                type: DateTimePickerType.dateTime,
                                                dateMask: 'd MMM, yyyy',
                                                initialValue:snapshot.data[index].dtetime,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                                icon: Icon(Icons.event),
                                                dateLabelText: 'Date',
                                                timeLabelText: "Hour",
                                                selectableDayPredicate: (date) {

                                                  return true;
                                                },

                                                onChanged: (val) {
                                                  t=val;
                                                },
                                                validator: (val) {
                                                  print(val);
                                                  t=val;
                                                },

                                                onSaved: (val) {
                                                  t=val;
                                                }),
                                            textFormFieldinsulin(insulinEditingController, snapshot.data[index].insulin, "insulin",
                                              Icons.category, snapshot.data[index].insulin),
                                            textFormFieldcarbs(carbsEditingController, snapshot.data[index].carbs, "carbs",
                                              Icons.fastfood, snapshot.data[index].carbs,),
                                            textFormFieldbg(bgEditingController, snapshot.data[index].bglocouse, "bg",
                                              Icons.battery_alert, snapshot.data[index].bglocouse),
                                            textFormFieldnotes(notesEditingController, snapshot.data[index].notes, "notes",
                                              Icons.note,snapshot.data[index].notes),
                                          ],
                                        ),
                                      ),
                                      buttons: [
                                        DialogButton(

                                          onPressed: () async {
                                            print(snapshot.data[index].activity+ "--------------" + activtyEditingController.text);
                                            DatabaseProvider.db.updateClient(new logmodel(
                                                activity: ac==""?snapshot.data[index].activity:ac.toString(),
                                                bglocouse: bgEditingController.text.length==0?snapshot.data[index].bglocouse: bgEditingController.text,
                                                carbs: carbsEditingController.text.length==0?snapshot.data[index].carbs:carbsEditingController.text,
                                                dtetime: DateTime.now().toString(),
                                                insulin: insulinEditingController.text.length==0?snapshot.data[index].insulin:insulinEditingController.text,
                                                id: item.id,
                                                notes: notesEditingController.text.length==0?snapshot.data[index].notes:notesEditingController.text
                                            ));
                                            setState(() {
                                              _formKey.currentState.reset();
                                              Navigator.pop(context);
                                              setState(() {

                                              });
                                            });
                                          },
                                          color: Colors.green,
                                          child: Text(
                                            "Save",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        )
                                      ]).show();


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
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                        color: Colors.white,
                                      width: 1.0,
                                      style: BorderStyle.solid
                                  ),

                                ),
                                child: Row(

                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(item.dtetime.toString(),
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

          Alert(
              context: context,
              title: "Enter log",
              content: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    DropDownField(
                        value:  ac.toString(),
                        icon: Icon(Icons.local_activity),
                        required: false,
                        hintText: 'Choose a activity',
                        labelText: 'Activity',
                        items: activit,
                        strict: false,
                        onValueChanged: (dynamic newValue) {

                          ac=newValue  ;



                        }),

            DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              selectableDayPredicate: (date) {

                return true;
              },

              onChanged: (val) {
                t=val;
              },
              validator: (val) {
                print(val);
                t=val;
              },

              onSaved: (val) {
                t=val;
              }),

                    // textFormactivity(activtyEditingController, "activity", "activity",
                    //     Icons.local_activity, "activity"),
                    textFormFieldinsulin(insulinEditingController, "insulin", "insulin",
                      Icons.category,  "insulin",),
                    textFormFieldcarbs(carbsEditingController, "carbs", "carbs",
                      Icons.fastfood,"carbs",),
                    textFormFieldbg(bgEditingController, "bg", "bg",
                      Icons.battery_alert,   "bg",),
                    textFormFieldnotes(notesEditingController, "notes", "notes",
                      Icons.note, "notes",),
                  ],
                ),
              ),
              buttons: [
                DialogButton(
                  onPressed: () async {

                      await DatabaseProvider.db.addClientToDatabase(new logmodel(
                          activity: ac.toString(),
                          bglocouse: bgEditingController.text,
                          carbs: carbsEditingController.text,
                          dtetime: t.toString(),
                          insulin: insulinEditingController.text,
                          notes: notesEditingController.text

                      ));
                      setState(() {
                        _formKey.currentState.reset();
                        Navigator.pop(context);
                        setState(() {

                        });
                      });

                  },
                  color: Colors.green,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
      ),

    );
  }
}


textFormactivity(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
    ),
    child: TextFormField(

//          validator: (value){
//            if (value.isEmpty) {
//              return 'Please enter some text';
//            }
//          },
      controller: t,
      //keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
  );
}

textFormFieldinsulin(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,

    ),
    child: TextFormField(
//          validator: (value){
//            if (value.isEmpty) {
//              return 'Please enter some text';
//            }
//          },
      controller: t,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
  );
}

textFormFieldbg(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
    ),
    child: TextFormField(
//        validator: (value){
//          if (value.isEmpty) {
//            return 'Please enter some text';
//          }
//        },
      controller: t,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
  );
}
textFormFieldcarbs(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
    ),
    child: TextFormField(
//        validator: (value){
//          if (value.isEmpty) {
//            return 'Please enter some text';
//          }
//        },
      controller: t,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
  );
}
textFormFieldnotes(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
    ),
    child: TextFormField(
//        validator: (value){
//          if (value.isEmpty) {
//            return 'Please enter some text';
//          }
//        },
      controller: t,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
    ),
  );
}


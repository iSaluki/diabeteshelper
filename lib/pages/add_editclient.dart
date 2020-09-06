import 'package:diabeteshelper/Widget/applogo.dart';
import 'package:diabeteshelper/database/database.dart';
import 'package:diabeteshelper/models/logbookmodel.dart';
import 'package:diabeteshelper/pages/logbook.dart';
import 'package:flutter/material.dart';





class AddEdit extends StatefulWidget {
  final bool edit;
  final logmodel client;
  logbook g = logbook();
  AddEdit(this.edit, {this.client})
  : assert(edit == true || client ==null);


  @override
  _AddEditState createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  TextEditingController activtyEditingController = TextEditingController();
  TextEditingController insulinEditingController = TextEditingController();
  TextEditingController bgEditingController = TextEditingController();
  TextEditingController carbsEditingController = TextEditingController();
  TextEditingController notesEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {    
    super.initState();

    if(widget.edit == true){
      activtyEditingController.text = widget.client.activity;
      insulinEditingController.text = widget.client.insulin;
      bgEditingController.text = widget.client.bglocouse;
      carbsEditingController.text = widget.client.carbs;
      notesEditingController.text = widget.client.notes;

    }
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
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    textFormactivity(activtyEditingController, "activity", "activity",
                        Icons.local_activity, widget.edit ? widget.client.activity : "activity"),
                    textFormFieldinsulin(insulinEditingController, "insulin", "insulin",
                      Icons.category, widget.edit ? widget.client.insulin : "insulin",),
                    textFormFieldcarbs(carbsEditingController, "carbs", "carbs",
                      Icons.fastfood, widget.edit ? widget.client.carbs : "carbs",),
                    textFormFieldbg(bgEditingController, "bg", "bg",
                      Icons.battery_alert, widget.edit ? widget.client.bglocouse : "bg",),
                    textFormFieldnotes(notesEditingController, "notes", "notes",
                      Icons.note, widget.edit ? widget.client.notes : "notes",),



                    RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('Save',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white
                        ),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState.validate()){

                          setState(() {
                           logbook();
                          });
                        }else if (widget.edit == true) {

                          setState(() {
                            DatabaseProvider.db.updateClient(new logmodel(
                                activity: activtyEditingController.text,
                                bglocouse: bgEditingController.text,
                                carbs: carbsEditingController.text,
                                dtetime: DateTime.now().toString(),
                                insulin: insulinEditingController.text,
                                id: widget.client.id ,
                              notes: notesEditingController.text
                            ));
                            setState(() {
                              Navigator.pop(context);
                              setState(() {

                              });
                            });
                          });

                        } else {
                          await DatabaseProvider.db.addClientToDatabase(new logmodel(
                            activity: activtyEditingController.text,
                            bglocouse: bgEditingController.text,
                            carbs: carbsEditingController.text,
                            dtetime: DateTime.now().toString(),
                            insulin: insulinEditingController.text,
                            notes: notesEditingController.text
                          ));
                          setState(() {
                            Navigator.pop(context);
                            setState(() {

                            });
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
  
    );
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



}
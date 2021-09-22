import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/DialogBox/errorDialog.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:user_tiffin/Widgets/customTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ctitle = TextEditingController();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatNumber = TextEditingController();
  final carea = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  Widget _builddialog(BuildContext context, String msg) {
    return AlertDialog(
      content: Text(msg),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Center(
            child: Text(AppLocalizations.of(context).ok),
          ),
        ),
      ],
    );
  }

  addaddresstodatabase() async {
    await Firestore.instance
        .collection('Users')
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection('address')
        .document(ctitle.text)
        .setData({
      "title": ctitle.text.trim(),
      "name": cName.text.trim(),
      "phone no": cPhoneNumber.text.trim(),
      "flatnumber": cFlatNumber.text.trim(),
      "area": carea.text.trim(),
      "city": cCity.text.trim(),
      "state": cState.text.trim(),
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).newaddressadded),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
          AppLocalizations.of(context).newaddress,
          style: TextStyle(color: valhalla),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: solitude),
          child: Column(
            children: [
              CustomTextField(
                controller: ctitle,
                hintText: AppLocalizations.of(context).title,
                isObsecure: false,
                data: Icons.title,
              ),
              CustomTextField(
                  controller: cName,
                  hintText: AppLocalizations.of(context).name,
                  isObsecure: false,
                  data: Icons.person),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cPhoneNumber,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  obscureText: false,
                  cursorColor: valhalla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: valhalla,
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    hintText: AppLocalizations.of(context).phone,
                  ),
                ),
              ),
              CustomTextField(
                  controller: cFlatNumber,
                  hintText: AppLocalizations.of(context).flatnumber,
                  isObsecure: false,
                  data: Icons.home),
              CustomTextField(
                  controller: carea,
                  hintText: AppLocalizations.of(context).area,
                  isObsecure: false,
                  data: Icons.zoom_out_map),
              CustomTextField(
                  controller: cCity,
                  hintText: AppLocalizations.of(context).city,
                  isObsecure: false,
                  data: Icons.location_city),
              CustomTextField(
                  controller: cState,
                  hintText: AppLocalizations.of(context).state,
                  isObsecure: false,
                  data: Icons.map),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenwidth - 100.0,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () {
                      cCity.text.isNotEmpty &&
                              cFlatNumber.text.isNotEmpty &&
                              cName.text.isNotEmpty &&
                              cPhoneNumber.text.isNotEmpty &&
                              cState.text.isNotEmpty &&
                              carea.text.isNotEmpty &&
                              ctitle.text.isNotEmpty
                          ? cPhoneNumber.text.length == 10
                              ? addaddresstodatabase()
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(AppLocalizations.of(context)
                                      .plswritephnnumber),
                                ))
                          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  AppLocalizations.of(context).pleasefillinfo),
                            ));
                    },
                    child: Text(
                      AppLocalizations.of(context).addaddress,
                      style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/DialogBox/errorDialog.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:user_tiffin/Widgets/customTextField.dart';
import 'package:user_tiffin/Widgets/mydrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldpasswordtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  updatepassword() async {
    await Firestore.instance
        .collection("Users")
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail))
        .updateData({
      "password": _passwordtextEditingController.text,
    });
    EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userpassword, _passwordtextEditingController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).passupdated),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).changepass,
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: screenheight,
          decoration: BoxDecoration(color: solitude),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _oldpasswordtextEditingController,
                        data: Icons.vpn_key_rounded,
                        isObsecure: true,
                        hintText: AppLocalizations.of(context).oldpass,
                      ),
                      CustomTextField(
                        controller: _passwordtextEditingController,
                        data: Icons.vpn_key,
                        isObsecure: true,
                        hintText: AppLocalizations.of(context).newpassword,
                      ),
                      CustomTextField(
                        controller: _cpasswordtextEditingController,
                        data: Icons.vpn_key_outlined,
                        isObsecure: true,
                        hintText: AppLocalizations.of(context).confirmpass,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: screenwidth - 100.0,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () {
                      _oldpasswordtextEditingController.text.isNotEmpty &&
                              _passwordtextEditingController.text.isNotEmpty &&
                              _cpasswordtextEditingController.text.isNotEmpty
                          ? _cpasswordtextEditingController.text ==
                                  _passwordtextEditingController.text
                              ? _passwordtextEditingController.text.length > 5
                                  ? _oldpasswordtextEditingController.text ==
                                          EcommerceApp.sharedPreferences
                                              .getString(
                                                  EcommerceApp.userpassword)
                                      ? updatepassword()
                                      : displayDialog(
                                          AppLocalizations.of(context)
                                              .oldpasswordwrong)
                                  : displayDialog(AppLocalizations.of(context)
                                      .passwordshouldatleastcontainletter)
                              : displayDialog(
                                  AppLocalizations.of(context).passwordnotmatch)
                          : displayDialog(
                              AppLocalizations.of(context).pleasefillinfo);
                    },
                    child: Text(
                      AppLocalizations.of(context).apply,
                      style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

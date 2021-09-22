import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Screen/myorders.dart';
import 'package:user_tiffin/Screen/profile.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:user_tiffin/Widgets/mydrawer.dart';
import 'package:user_tiffin/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

enum Tongue { english, hindi, gujarati }

class _LanguageState extends State<Language> {
  Tongue _tongue;

  @override
  void initState() {
    // TODO: implement initState
    if (EcommerceApp.sharedPreferences.getString(EcommerceApp.language) ==
        "English") {
      _tongue = Tongue.english;
    } else if (EcommerceApp.sharedPreferences
            .getString(EcommerceApp.language) ==
        "Hindi") {
      _tongue = Tongue.hindi;
    } else {
      _tongue = Tongue.gujarati;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).language,
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  AppLocalizations.of(context).selectyourlanguage,
                  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: screenwidth / 6,
                    child: Radio<Tongue>(
                      value: Tongue.english,
                      autofocus: true,
                      activeColor: tyrianPurple,
                      groupValue: _tongue,
                      onChanged: (Tongue value) {
                        setState(() {
                          _tongue = value;
                          EcommerceApp.sharedPreferences
                              .setString(EcommerceApp.language, "English");
                        });
                      },
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).english,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenwidth / 6,
                    child: Radio<Tongue>(
                      value: Tongue.hindi,
                      autofocus: true,
                      activeColor: tyrianPurple,
                      groupValue: _tongue,
                      onChanged: (Tongue value) {
                        setState(() {
                          _tongue = value;
                          EcommerceApp.sharedPreferences
                              .setString(EcommerceApp.language, "Hindi");
                        });
                      },
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).hindi,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenwidth / 6,
                    child: Radio<Tongue>(
                      value: Tongue.gujarati,
                      autofocus: true,
                      activeColor: tyrianPurple,
                      groupValue: _tongue,
                      onChanged: (Tongue value) {
                        setState(() {
                          _tongue = value;
                          EcommerceApp.sharedPreferences
                              .setString(EcommerceApp.language, "Gujarati");
                        });
                      },
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).gujrati,
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenwidth - 100.0,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () {
                      if (_tongue == Tongue.english) {
                        MyApp.of(context)
                            .setLocale(Locale.fromSubtags(languageCode: 'en'));
                      } else if (_tongue == Tongue.hindi) {
                        MyApp.of(context)
                            .setLocale(Locale.fromSubtags(languageCode: 'hi'));
                      } else {
                        MyApp.of(context)
                            .setLocale(Locale.fromSubtags(languageCode: 'gu'));
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).apply,
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

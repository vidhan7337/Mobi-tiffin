import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Screen/changepassword.dart';
import 'package:user_tiffin/Screen/contactus.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Screen/language.dart';
import 'package:user_tiffin/Screen/myorders.dart';
import 'package:user_tiffin/Screen/profile.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Image.network(
            "https://i.pinimg.com/736x/27/9f/bf/279fbf90a26a2c8c73b3dec0db1692cb.jpg",
            fit: BoxFit.cover,
          )),
          ListTile(
            leading: Icon(
              Icons.home,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).home),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).profile),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profie()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.food_bank,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).myorders),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyOrder()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).language),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Language()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.lock,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).changepass),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).contactus),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: valhalla,
            ),
            title: Text(AppLocalizations.of(context).logout),
            onTap: () async {
              await EcommerceApp.sharedPreferences
                  .setString(EcommerceApp.userUID, null);
              await EcommerceApp.sharedPreferences
                  .setString(EcommerceApp.userEmail, null);
              await EcommerceApp.sharedPreferences
                  .setString(EcommerceApp.userpassword, null);
              await EcommerceApp.sharedPreferences
                  .setString(EcommerceApp.userName, null);
              await EcommerceApp.sharedPreferences
                  .setString(EcommerceApp.userAvatarUrl, null);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/auth', (Route<dynamic> route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context).logoutsuccesfully),
              ));
            },
          ),
        ],
      ),
    );
  }
}

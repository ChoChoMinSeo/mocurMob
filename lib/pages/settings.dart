import 'package:flutter/material.dart';
import 'package:mocur/pages/loginpage.dart';
import 'package:mocur/widgets/back.dart';
import 'package:mocur/widgets/bottombar.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        Column(
          children: [
            apptitle(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    settingButton(Icon(Icons.logout),'로그아웃',(){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      LogingPage()), (Route<dynamic> route) => false);
                    })
                ],),
              )),
            bottombar(context,2)
        ]),
      ),
    );
  }
}
Widget settingButton(Icon icon, String name, VoidCallback action ){
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.black))
    ),
    width: double.maxFinite,
    child: GestureDetector(
      onTap: action,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        icon,
        const SizedBox(width: 10),
        Text(name, style: const TextStyle(fontSize: 20),)
      ]),
    ),
  );
}
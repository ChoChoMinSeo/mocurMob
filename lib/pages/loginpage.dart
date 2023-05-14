import 'package:flutter/material.dart';
import 'package:mocur/data.dart';
import 'package:mocur/pages/homepage.dart';

class LogingPage extends StatefulWidget {
  const LogingPage({super.key});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  String googleLogin(){
    return 'id';
  }
  Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
               //return false when click on "NO"
              child:Text('No'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true), 
              //return true when click on "Yes"
              child:Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          body: SafeArea(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
            gradient: LinearGradient(
                        colors: [
                          const Color(0x00BCE3EA).withOpacity(1),
                          const Color(0x00C6DAED).withOpacity(1),
                          const Color(0x00ACF3E5).withOpacity(1),
                        ],
                        begin: const FractionalOffset(0.0,0.3),
                        end: const FractionalOffset(1.0,0.7),
                        stops: const [0.0,0.4,1.0],
                    )
          ),
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/10,MediaQuery.of(context).size.width/10,10,MediaQuery.of(context).size.width/8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("MOCUR", style: TextStyle(
                        fontFamily: 'Pretend',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 40
                      ),),
                      const Text('모두의 커리큘럼',style: TextStyle(
                        fontFamily: 'Pretend',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20
                      ),),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/4,
                      ),
                      Row(
                        children: [
                          const Expanded(flex:2, child: SizedBox()),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                                SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white.withOpacity(0.8)
                                    ),
                                    onPressed: ()async{
                                      String userId = googleLogin();
                                      // everyData = await getEveryData(userId);
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                    }, 
                                    child: Row(
                                      children: const[
                                        Icon(Icons.g_mobiledata, color: Colors.black,size: 40,),
                                        Text('google login', 
                                        style: TextStyle(
                                          fontFamily: 'Pretend',
                                          color: Colors.black,
                                          fontSize: 25
                                          ),
                                          ),
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ]),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
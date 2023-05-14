import 'package:flutter/material.dart';
import 'package:mocur/pages/homepage.dart';
import 'package:mocur/pages/myStudy.dart';
import 'package:mocur/pages/settings.dart';
import 'package:mocur/pages/studyList.dart';

Widget apptitle(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
     ),
    width: double.maxFinite,
    height: 50,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(13.0,10,0,8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('MOCUR',style: TextStyle(fontSize: 27,fontWeight: FontWeight.w700),),
          Row(
            children: const [
              Text('모두의 ',style: TextStyle(fontSize: 15),),
              Text('커리큘럼', style: TextStyle(fontWeight: FontWeight.w700, fontSize:15 ),)
              ],)
        ]
        ),
    ),
  );
}
Widget bottomIconButton(Icon icon, String name, VoidCallback fn){
  return GestureDetector(
    onTap: fn,
    child: SizedBox(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(name,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)
        ],
      ),
    ),
  );
}
Widget bottombar(BuildContext context, int pagenum){
  return SizedBox(
    width: double.maxFinite,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      bottomIconButton(Icon(Icons.home,size: 30 ,
        color: pagenum==0? const Color(0x005A688A).withOpacity(1): Colors.grey), '홈',(){
        if(pagenum==0){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }
      }),
      bottomIconButton(Icon(Icons.add_business,size: 30 ,
        color: pagenum==1? const Color(0x005A688A).withOpacity(1): Colors.grey), '내 스터디',(){
        if(pagenum==1){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStudyListPage()));
          }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStudyListPage()));
        }
      }),
      bottomIconButton(Icon(Icons.settings,size: 30 ,
        color: pagenum==2? const Color(0x005A688A).withOpacity(1): Colors.grey), '설정',(){
        if(pagenum==2){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
          }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
        }
      }),
    ]),
  );
}

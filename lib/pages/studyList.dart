import 'package:flutter/material.dart';
import 'package:mocur/data.dart';
import 'package:mocur/pages/myStudy.dart';
import 'package:mocur/widgets/back.dart';
import 'package:mocur/widgets/bottombar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyStudyListPage extends StatefulWidget {
  const MyStudyListPage({super.key});

  @override
  State<MyStudyListPage> createState() => _MyStudyListPageState();
}

class _MyStudyListPageState extends State<MyStudyListPage> {
  List studyList=['백엔드 완성하기', 'pytorch로 ML!','중국어 길라잡이'];
  List progresses = [70,60,10];
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     everyData.keys.forEach((key){
  //     studyList.add(key);
  //   });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        Container(
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
          child: Column(
            children: [
              apptitle(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('현재 진행중인 커리큘럼', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: studyList.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStudy(treeId: 'asdf')));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.9,
                                    height: MediaQuery.of(context).size.height/4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withOpacity(1),
                                      boxShadow: [BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 7.0,
                                        offset: const Offset(2, 5),)]
                                      ),
                                      child: Padding(padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                              Text(studyList[index], style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                                              const SizedBox(height: 5,),
                                              Text('해당 커리큘럼은 어떤걸 배우기 위한 과정이고 학습기간은 3개월정도로 보고있습니다. 열심히 참가해 주셔서 같이 공부해봐요!', style: TextStyle(fontSize: 20),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                            ],)),
                                            const SizedBox(width: 10,),
                                            Expanded(
                                              flex: 3,
                                              child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Column(
                                                children: [
                                                  const Text('진행도', style: TextStyle(fontSize: 20),),
                                                  const SizedBox(height: 10,),
                                                  CircularPercentIndicator(
                                                    progressColor: const Color(0x006E85B7).withOpacity(1),
                                                    backgroundColor: Colors.white.withOpacity(0.8),
                                                    percent: progresses[index]/100,
                                                    lineWidth: 15,
                                                    radius: MediaQuery.of(context).size.height/14,
                                                    center: Text('${progresses[index]}%', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                              )
                                      ]),),
                                  ),
                                  const SizedBox(height: 25)
                                ],
                              ),
                            );
                          })
                          ),
                      ),
                    )
                  ]),
                  )
              ),
              bottombar(context, 1),
            ],
          ),
        )
      ),
    );
  }
}
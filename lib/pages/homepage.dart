import 'package:flutter/material.dart';
import 'package:mocur/widgets/back.dart';
import 'package:mocur/widgets/bottombar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('앱 종료'),
          content: Text('정말로 종료하시겠습니까?'),
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
  int percent = 36;
  List<double> dataList=[0, 5, 11];
  List<MonthlyData> data = [MonthlyData('1월', 12),MonthlyData('2월', 50),MonthlyData('3월', 72)];
  List<String> titles = ['백엔드 완성하기', 'pytorch로 ML!', '중국어 길라잡이'];
  List<String> tasks=['REST API기초 익히기', 'MNIST 데이터 불러오기','중국어의 성조'];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
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
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('내 달성도', 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.height/5,
                              child: CircularPercentIndicator(
                                progressColor: const Color(0x006E85B7).withOpacity(1),
                                backgroundColor: Colors.white.withOpacity(0.8),
                                percent: percent/100,
                                lineWidth: 20,
                                radius: MediaQuery.of(context).size.height/10,
                                center: Text('$percent%', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                                ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('오늘 할 일을 추천드릴께요.',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index){
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          decoration: BoxDecoration(
                                            boxShadow: [BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 7.0,
                                        offset: const Offset(2, 4),)],
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white.withOpacity(0.6),
                                            ),
                                            child: Padding(padding: EdgeInsets.symmetric(horizontal:14.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              Text(titles[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                                              Text('해당 커리큘럼은 어떤걸 배우기 위한 과정이고 학습과저은 3개월정도로 보고있습니다. 열심히 참가해 주셔서 같이 공부해봐요!',
                                              style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                              Row(
                                                children: [
                                                  Checkbox(value: false, onChanged: (v){}),
                                                  Text(tasks[index])
                                                ],
                                              )
                                            ]),),
                                        ),
                                      ),
                                      const SizedBox(width: 30)
                                    ],
                                  );
                                }
                                ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Text('내 달성률 추이',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/5,
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(isVisible: true, borderColor: Colors.black),
                              primaryYAxis: NumericAxis(maximum: 100,minimum: 0,interval: 50, isVisible: false),
                              series:<LineSeries<MonthlyData, String>> [
                                LineSeries(
                                  color: const Color(0x006E85B7).withOpacity(1),
                                  width: 2.5,
                                  dataSource: data, 
                                  xValueMapper: (MonthlyData data, _) => data.month, 
                                  yValueMapper: (MonthlyData data, _) => data.progress, 
                                  )
                              ],
                            ),
                          )
                        ]),
                    ),
                  ),
                  bottombar(context,0),
                ],
                ),
            )
        ),
      ),
    );
  }
}
class MonthlyData {
  MonthlyData(this.month, this.progress);
  final String month;
  final double progress;
}

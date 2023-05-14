import "package:flutter/material.dart";
import 'package:mocur/data.dart';
import 'package:mocur/widgets/back.dart';
import 'package:mocur/widgets/bottombar.dart';
import 'package:graphite/graphite.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cp949/cp949.dart' as cp949;
class MyStudy extends StatefulWidget {
  final String treeId;
  const MyStudy({super.key, required this.treeId});

  @override
  State<MyStudy> createState() => _MyStudyState();
}

class _MyStudyState extends State<MyStudy> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double percent=50;
  String techtree = '['
    '{"id":"A","next":[{"outcome":"B"}]},'
    '{"id":"B","next":[{"outcome":"C"},{"outcome":"D"},{"outcome":"E"}]},'
    '{"id":"C","next":[{"outcome":"F"}]},'
    '{"id":"D","next":[{"outcome":"J"}]},{"id":"E","next":[{"outcome":"J"}]},'
    '{"id":"J","next":[{"outcome":"I"}]},'
    '{"id":"I","next":[{"outcome":"H"}]},{"id":"F","next":[{"outcome":"K"}]},'
    '{"id":"K","next":[{"outcome":"L"}]},'
    '{"id":"H","next":[{"outcome":"L"}]},{"id":"L","next":[{"outcome":"P"}]},'
    '{"id":"P","next":[{"outcome":"M"},{"outcome":"N"}]},'
    '{"id":"M","next":[]},{"id":"N","next":[]}'
    ']';
  String techExplain = 'explanation';
  int rating=5;
  List<String> treeNameList=[];
  List<List<Map>> treeCheckList=[];//node 당 체크리스트 갯수 세는용[[{'content':'chek1','isChecked':false}, {'content':'chek2','isChecked':false}]]
  String title='Title';
  bool isLoaded=false;
  List<Map> techTreeMap = [];//[{'id':title,'next':[{'outcome':'title2'}, {'outcome':title3} ---]}]
  Future<int> getTreeInfo()async{
    final url = Uri.parse("http://ec2-15-164-94-71.ap-northeast-2.compute.amazonaws.com:8000/trees/28");
    // final url = Uri.parse("http://15.164.94.71:8000/trees/1");
    Map<String, String> requestHeaders = {
       'Content-Type': 'application/json; charset=utf-8',
       'Accept': 'application/json',
     };
    if(!isLoaded){
      http.Response res = await http.get(url, headers: requestHeaders);
    // print(res.body);
    // String character = String.from(res.bodyBytes)
    // final temp = jsonDecode(res.body);
    // final temp = jsonDecode('${res.body}');
    
    // final temp = jsonDecode(utf8.decode(jsonDecode(res.bodyBytes)));
    // print(cp949.decode(res.bodyBytes));
    final temp = jsonDecode(utf8.decode(res.bodyBytes));
    // print(temp);
    // final temp = jsonDecode(res.body);
    try{
      List<dynamic> nodes = temp['nodes'];
    List<dynamic> edges = temp['edges'];
    List<Map> edgeData=[];
    for(int i=0;i<edges.length;i++){
        edgeData.add(edges[i]);
    }
    for(int i=0;i<nodes.length;i++){
        treeNameList.add(nodes[i]['title']);
        techTreeMap.add({"id": nodes[i]['title'],"next":[]});
        List<Map> tempChecks=[];
        for(int j=0;j<nodes[i]['checklist'].length;j++){
          tempChecks.add({'content':nodes[i]['checklist'][j]['content'],'isChecked':false});
        }
        treeCheckList.add(tempChecks);
    }
    for(int i=0;i<edges.length;i++){
      techTreeMap[edges[i]["source"]-1]["next"].add({"outcome":techTreeMap[edges[i]['target']-1]["id"]});
    }
    setState(() {
      rating = temp['rating'];
      title = temp['title'];
      techtree = json.encode(techTreeMap);
      isLoaded = true;
    });
    }
    catch(e){
      print('error');
    }
    }
    return 0;
  }
  void treeDialog(String treeName){
    int index = -1;
    index = treeNameList.indexOf(treeName);
    if (index!=-1){
      showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(treeName, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          content: SizedBox(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width*0.9,
            child: Column(
              children: [
                // Text(curTree!.treeExplanation, style: const TextStyle(fontSize: 20),),
                for(int i=0; i<treeCheckList[index].length;i++)
                Row(children: [
                  Checkbox(
                    activeColor: const Color(0x00099270).withOpacity(1),
                    value: treeCheckList[index][i]['isChecked'], 
                    onChanged: (v){
                      setState(() {
                        treeCheckList[index][i]['isChecked'] = v!;
                      });
                    //update method
                    }),
                  Text(treeCheckList[index][i]['content'], style: const TextStyle(fontSize: 20),)
                ],)
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x00099270).withOpacity(1),
              ),
              onPressed: (){
                Navigator.pop(context);
                }, 
              child: const Text('닫기',style: TextStyle(fontFamily: "Pretend", fontSize: 15),))
          ],
          );
      }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: double.maxFinite,
                          width: 15.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 1.0
                            ),
                            onPressed: (){
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: Center(child: Container(width: 5,height: 30,color: Colors.black,))
                              ),
                        ),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('내 진행도: $percent%', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),),
                                    SizedBox(
                                      height: 40,
                                      width: double.maxFinite,
                                      child: LinearPercentIndicator(
                                        lineHeight: 15,
                                        linearGradient: LinearGradient(
                                          begin: const FractionalOffset(0.0,0.0),
                                          end: const FractionalOffset(1.0,1.0),
                                          stops: const [0.0,1.0],
                                          colors: [const Color(0x00B9C2D1).withOpacity(1),const Color(0x008F96D1).withOpacity(1)]),
                                        percent: percent/100,               
                                      ),
                                  ),
                                  ],
                                ),
                              ),
                                Expanded(
                                  child: FutureBuilder(
                                    future: getTreeInfo(),
                                    builder:(context,snapshot){
                                      if(snapshot.hasData){
                                        return InteractiveViewer(
                                         constrained: false,
                                          child: DirectGraph(
                                          nodeBuilder: (context, node) {
                                            return GestureDetector(
                                              onTap: (){
                                                treeDialog(node.id);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [BoxShadow(
                                                  color: Colors.grey.withOpacity(0.7),
                                                  spreadRadius: 0,
                                                  blurRadius: 5.0,
                                                  offset: const Offset(0, 3),)]
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(node.id, style: const TextStyle(fontSize: 20),),
                                                      // Expanded(
                                                      //   child: 
                                                      //     Text(getTreeExplain(node.id), 
                                                      //     style: const TextStyle(fontSize: 15),
                                                      //     overflow: TextOverflow.ellipsis,
                                                      //     maxLines: 3,
                                                      //     ))
                                                  ]),
                                                ),
                                              ),
                                            );
                                          },
                                          list: nodeInputFromJson(techtree),
                                          defaultCellSize: const Size(150.0, 120.0),
                                          cellPadding: const EdgeInsets.all(20),
                                          orientation: MatrixOrientation.Vertical,
                                          ),
                                                                          );
                                      }else{
                                        return const SizedBox(child: Text('loading'),);
                                      }
                                    },
                                    ),)
                            ],
                          ),
                        ),
                  
                      ],
                      ),
                  )
                ),
                bottombar(context,1)
              ],
            ),
          )
      ),
      drawer: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0)
          ),
          margin: const EdgeInsets.only(top:50),
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
                  Text(techExplain, style: const TextStyle(fontSize: 20 ),),
                  Row(children: [
                    const Text('난이도: ', style: TextStyle(fontSize: 20),),
                    for(int i=0; i<rating;i++)
                      const Icon(Icons.star, color: Colors.yellow,),
                    ],),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: techTreeMap.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              treeDialog(techTreeMap[index]['id']);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(techTreeMap[index]['id'], style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
                                for(int i=0;i<treeCheckList[index].length;i++)
                                Row(
                                  children: [
                                    const Icon(Icons.circle,size: 10,),
                                    const SizedBox(width: 5),
                                    Text(treeCheckList[index][i]['content'],style: const TextStyle(fontSize: 20,decoration: TextDecoration.underline),),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        }
                        )
                      ),
                  )  
                ]
                ),
            ),
          ),
        ),
      ),
    );
  }
}

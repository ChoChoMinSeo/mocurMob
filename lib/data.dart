import 'dart:convert';

import 'package:http/http.dart' as http;
class GroupInfo{
  GroupInfo(this.treeId, this.groupName);
  final String treeId;
  final String groupName;
}
class TreeInfos{
  TreeInfos(this.treeId,this.treeTitle, this.rating, this.checkList,);
  final String treeId;
  final String treeTitle;
  final int rating;
  final CheckInfo checkList;
}
class CheckInfo{
  CheckInfo(this.checkListList, this.isChecked);
  final List<String> checkListList;
  final List<bool> isChecked;
}

Future<List<String>> getUserGroups(String userId)async{ //전부다 로그인 한 순간 호출
  Uri url = Uri.parse('host/users/{$userId}/groups');
  http.Response res = await http.get(url,headers: requestHeaders);
  final temp = jsonDecode(res.body);
  List<String> groupIds = [];
  for(int i=0; i<temp['id'].length;i++){
    groupIds.add(temp['id'][i]);
  }
  return groupIds;
}
Future<GroupInfo> getGroupInfos(String groupId)async {
  Uri url = Uri.parse('https://{host}/groups/{$groupId}');
  http.Response res = await http.get(url,headers: requestHeaders);
  final temp = jsonDecode(res.body);
  return GroupInfo(temp['tree'], temp['title']);
}
Future<TreeInfos> getTreeInfos(String treeId) async{
  Uri url = Uri.parse('https://{host}/trees/{$treeId}');
  http.Response res = await http.get(url,headers: requestHeaders);
  final temp = jsonDecode(res.body);
  TreeInfos cur = TreeInfos(treeId, temp['title'], temp['rating'], CheckInfo(temp['checklist'],temp['ischecked']));
  return cur;
}
Future<Map<String,TreeInfos>> getEveryData(String userId)async{
  List<String> groupIds = await getUserGroups(userId);
  List<GroupInfo> groupList = [];
  Map<String,TreeInfos> treeList = {};
  for(String groupId in groupIds){
    groupList.add(await getGroupInfos(groupId));
  }
  for(GroupInfo group in groupList){
    treeList[group.treeId]=(await getTreeInfos(group.treeId)); 
  }
  return treeList;
}
Map<String,TreeInfos> everyData={};
//{'treeId1':{ 'title': ,'rating',''}
//}
Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json',
     };
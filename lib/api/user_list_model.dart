import 'dart:convert';
import 'package:http/http.dart' as http;

class UserList {
  String id;
  String name;

  UserList({this.id, this.name});
  factory UserList.createUserList(Map<String, dynamic> object) {
    return UserList(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name']);
  }

  static Future<List<UserList>> getListUser(String page) async {
    String apiURL = 'https://reqres.in/api/users?page=' + page;
    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];
    List<UserList> users = [];
    for (int i = 0; i < listUser.length; i++)
      users.add(UserList.createUserList(listUser[i]));

    return users;
  }
}

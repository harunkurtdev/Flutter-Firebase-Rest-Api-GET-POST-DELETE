import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:todo_project/api/model/model.dart';


class ApiService{
  String _baseURL;

  static ApiService _instance=ApiService._privateConstructor();
  
     ApiService._privateConstructor() {
      _baseURL="https://todo-9ac25.firebaseio.com/";
    }

    static ApiService getInstance(){
      if (_instance==null) {
        return ApiService._privateConstructor();
        
      }

      return _instance;
    }

    Future<List<Post>> getposts() async {

      final response = await http.get("$_baseURL"+"posts.json");

      final jsonResponse=jsonDecode(response.body);

      switch(response.statusCode){

        case HttpStatus.ok:
          final postsList=PostList.fromJsonList(jsonResponse);
          return postsList.posts;
        break;
        case HttpStatus.unauthorized:
            throw Exception('Bir hata olustu ${response.statusCode}');
        break;
      }
    }

  Future<void> addposts(Post post) async {

    final jsonBody =jsonEncode(post.toJson());

    final response = await http.post("$_baseURL"+"posts.json",body:jsonBody);

    final jsonResponse= jsonDecode(response.body);

    switch(response.statusCode){

        case HttpStatus.ok:
          return Future.value(true);
        break;
        case HttpStatus.unauthorized:
            throw Exception('Bir hata olustu ${response.statusCode}');
        break;
      }

    return Future.error(jsonResponse);

  }

  Future<void> removeposts(String key) async {

    final response = await http.delete("$_baseURL"+"posts/$key.json");

    final jsonResponse= jsonDecode(response.body);

    switch(response.statusCode){

        case HttpStatus.ok:
          return Future.value(true);
        break;
        case HttpStatus.unauthorized:
            throw Exception('Bir hata olustu ${response.statusCode}');
        break;
      }

    return Future.error(jsonResponse);

  }



}
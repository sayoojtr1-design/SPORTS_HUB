import 'dart:convert';

import 'package:e_store/sample_api/todo_model.dart';
import 'package:http/http.dart'as http;




class TodoService {

  Future<List<ToDoModel>> fetchTodos() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
    );
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);

      return data.map((e)=> ToDoModel.fromJson(e)).toList();

    }
    else{
      throw Exception("failed to load todos");
    }
  }
}
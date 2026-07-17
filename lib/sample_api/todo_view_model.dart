
import 'package:e_store/sample_api/todo_model.dart';
import 'package:e_store/sample_api/todo_service.dart';
import 'package:flutter/cupertino.dart';

class TodoViewModel extends ChangeNotifier{
  final TodoService service = TodoService();
  List<ToDoModel> todos = [];
  bool isLoading = false;
  String? errors;
  Future<void> fetchTodos() async{
    isLoading = true;
    errors= null;
    notifyListeners();
    try{
      todos = await service.fetchTodos();
    }catch(e){
      errors = e.toString();
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}

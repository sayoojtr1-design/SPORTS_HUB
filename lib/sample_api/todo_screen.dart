import 'package:e_store/sample_api/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<TodoViewModel>().fetchTodos();

    });
  }
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<TodoViewModel>(context);

    return Scaffold(  appBar: AppBar(),
      body: Builder(builder: (context){
        if(provider.todos.isEmpty){
          return Center(
            child: Text("No Todos"),
          );
        }
        if(provider.isLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(provider.errors != null){
          return Center(child: Text(provider.errors!),);
        }
        return ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index){
              final todo = provider.todos[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(todo.id.toString()),
                  ),
                  title: Text(todo.title!),
                ),
              );
            });
      }),



    );
  }
}

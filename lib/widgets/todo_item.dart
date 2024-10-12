import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(fontSize: 18, color: tdBlack),
        ),
        trailing: todo.isDone == true
            ? Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: tdRed, borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  iconSize: 20,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  // color: Colors.white,
                  onPressed: () {
                    // print("Deleted Item");
                    onDeleteItem(todo.id);
                  },
                ),
              )
            : null,
      ),
    );
  }
}

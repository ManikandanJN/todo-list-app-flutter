import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> searchItem = [];
  List<ToDo> results = [];
  bool _textEmptyOrNot = false;

  @override
  void initState() {
    searchItem = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _builtAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBox(),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const Text(
                      "All ToDos",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                      child: results.length > 0
                          ? ListView(
                              children: [
                                for (ToDo todoo in searchItem.reversed)
                                  ToDoItem(
                                    todo: todoo,
                                    onToDoChange: handleOnChange,
                                    onDeleteItem: handleOnDelete,
                                  ),
                              ],
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 140, top: 40),
                              child: const Text(
                                "No List",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 10, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: "Add new item",
                          border: InputBorder.none,
                          errorText:
                              _textEmptyOrNot ? 'Value Can\'t Be Empty' : null),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        handleAddItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10),
                      child: const Text(
                        "+",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void handleOnChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void handleOnDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void handleAddItem(String toDo) {
    if (_todoController.text.isEmpty) {
      setState(() {
        _textEmptyOrNot = true;
      });
    } else {
      _textEmptyOrNot = false;
      setState(() {
        todosList.add(ToDo(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            todoText: toDo));
      });
      _todoController.clear();
    }
  }

  void handleSearchItem(String searchData) {
    if (searchData.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(searchData.toLowerCase()))
          .toList();
    }
    setState(() {
      searchItem = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => handleSearchItem(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 40, minWidth: 45),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGray)),
      ),
    );
  }

  _builtAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdMenuColor, size: 30),
          const Text(
            "ToDo List",
            style: TextStyle(color: tdBlack),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/icon1.png'),
            ),
          )
        ],
      ),
    );
  }
}

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Item check 1'),
      ToDo(id: '2', todoText: 'Item check 2'),
      ToDo(id: '3', todoText: 'Item check 3'),
      ToDo(id: '4', todoText: 'Item check 4'),
      ToDo(id: '5', todoText: 'Item check 5'),
      ToDo(id: '6', todoText: 'Item check 6'),
      ToDo(id: '7', todoText: 'Item check 5'),
      ToDo(id: '8', todoText: 'Item check 6'),
    ];
  }
}

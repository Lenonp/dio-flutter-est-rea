import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lista de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoItems = [
    'Tarefa 1',
    'Tarefa 2',
    'Tarefa 3',
    'Tarefa 4',
    'Tarefa 5',
    'Tarefa 6',
    'Tarefa 7',
    'Tarefa 8',
    'Tarefa 9',
    'Tarefa 10'
  ];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
        title: Text(todoText),
        leading: Checkbox(
          value: false,
          onChanged: (bool? newValue) {},
        ),
        trailing: Wrap(
          spacing: -10.0,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _promptRemoveTodoItem(index),
            ),
          ],
        ));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Marcar "${_todoItems[index]}" como concluído?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Concluir'),
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Adicionar tarefa',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Adicionar uma nova tarefa')),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: 'Digite algo para fazer...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _removeAllTodoitem() {
    setState(() => {
      _todoItems = []
    });
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
          ),
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20.0),
            child: Card(
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _addTodoItem(val);
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                    hintText: 'Enter something todo',
                    contentPadding: EdgeInsets.all(16.0)),
              ),
            ),
          ));
    }));
  }

  void _prompRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('This ${_todoItems[index]} Done?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _prompRemoveAllTodoItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('All Done?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _removeAllTodoitem();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
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
      title: Text(
        todoText,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold
        ),
      ),
      onTap: () => _prompRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Card(
          child: _buildTodoList(),
          color: Colors.teal[50],
          margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          elevation: 24,
        ),
        alignment: Alignment.center,
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add task',
      //   child: Icon(Icons.add),
      //   onPressed: _pushAddTodoScreen,
      // ),
      bottomSheet: Container(
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Add Task'),
              color: Colors.amberAccent,
              onPressed: _pushAddTodoScreen,
            ),
            FlatButton(
              child: Text('All Done'),
              onPressed: _prompRemoveAllTodoItem,
            )
          ],
        ),
      ),
    );
  }
}

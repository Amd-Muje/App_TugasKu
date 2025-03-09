import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tugasku/models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();aaa

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        toolbarHeight: _deviceHeight * 0.1,
        title: const Text(
          'Tugasku',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.connectionState == ConnectionState.done) {
          _box = _snapshot.data;
          return _taskList();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _taskList() {
    // Task _newTask = Task(content: "Go to Gym", timestamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box?.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style:TextStyle(
              decoration: task.done ? null : TextDecoration.lineThrough),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
        );
      },
      );
    
    
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: Icon(
        Icons.add,
      ),
      backgroundColor: Colors.indigoAccent,
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text("Add New Task"),
            content: TextField(
              onSubmitted: (_value) {},
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}

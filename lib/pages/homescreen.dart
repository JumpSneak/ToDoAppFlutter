import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/main.dart';

double taskcounter = 0.0;
double donecounter = 0.0;
double _progress = 0.0;
_ProgressState? p = null;
List<Widget> tasklist = [Tasktodo(label: "~~~")];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<String> templist = List.from(tasklisttexts);
    tasklisttexts = [];
    print("templist $templist");
    print("tasklisttext $tasklisttexts");
    tasklist = [Tasktodo(label: "~~~")];
    for(int i = 0; i < templist.length; i++){
      print(tasklisttexts.length);
      tasklist.add(Tasktodo(label: templist[i]));
    }
    final taskbox = Hive.box("mybox");
    taskbox.put('text', tasklisttexts);

    taskcounter = tasklist.length.toDouble() - 1.0;
    if (taskcounter != 0) _progress = donecounter / taskcounter;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO-List"),
        centerTitle: true,
        backgroundColor: Colors.red[500],
        elevation: 3,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.pushNamed(context, "/create");
          setState(() {
            taskcounter = tasklist.length.toDouble() - 1.0;
            if (taskcounter != 0) _progress = donecounter / taskcounter;
            print(_progress);
            print(donecounter);
            print(taskcounter);
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        Progress(),
        TaskList(),
      ]),
    );
  }
}

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => p = _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.red[500],
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "You are this far with your progress",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 30,
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        children: tasklist,
        // Tasktodo(label: "Learn Flutter"),
        // Tasktodo(label: "Eat something"),
        // Tasktodo(label: "Play some games"),
        // Tasktodo(label: "Go to tube"),
      ),
    );
  }
}

class Tasktodo extends StatefulWidget {
  final String label;

  Tasktodo({Key? key, required this.label}) : super(key: key){
    if(this.label != "~~~") {
      tasklisttexts.add(this.label);
    }
  }


  @override
  State<Tasktodo> createState() => _TasktodoState();

}

class _TasktodoState extends State<Tasktodo> {
  bool? _value = false;

  String get_label() {
    return "label";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.label == "~~~") {
      return SizedBox(height: 6);
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              value: _value,
              onChanged: (new_value) => setState(() {
                    _value = new_value;
                    if (_value == true) {
                      donecounter++;
                    } else {
                      donecounter--;
                    }
                    if (taskcounter != 0) {
                      _progress = donecounter / taskcounter;
                      p?.setState(() {});
                    }
                    //print(tasklist[0].get_label());
                  })),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 17, 0, 16),
              child: Text(widget.label),
            ),
          ),
        ],
      ),
    );
  }
}

void increase_taskcounter() {
  taskcounter++;
}

double get_donetasks() {
  return donecounter / taskcounter;
}

void increase_donecounter() {
  donecounter++;
}

void decrease_donecounter() {
  donecounter--;
}

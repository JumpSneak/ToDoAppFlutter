import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist/pages/homescreen.dart';
import 'package:todolist/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();

  // final taskbox = Hive.box("mybox");

  @override
  Widget build(BuildContext context) {
    TextEditingController textinput = TextEditingController();
    TextEditingController nameinput = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new task"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextButton(
                  onPressed: () {
                    final taskbox = Hive.box("mybox");
                    taskbox.delete('text');
                    tasklisttexts = [];
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Icon(
                          Icons.delete_sweep,
                          color: Colors.white,
                          size: 20,
                        ),
                  ),
                ),
              ),
              SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("tasktestkljsdflkj ${tasklist[0].}");
                      tasklist.add(Tasktodo(label: textinput.text, id: tasklisttexts.length,)); ////////
                      donelist.add(true);
                      final taskbox = Hive.box("mybox");
                      taskbox.put('text', tasklisttexts);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a task",
                  ),
                  controller: textinput,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  validator: (value) {
                    return value!.length < 1 ? "Please enter a task" : null;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

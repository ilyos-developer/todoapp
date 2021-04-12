import 'package:flutter/material.dart';
import 'package:todo_app/service/fire_store.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _describeController = TextEditingController();

  bool _isValidate = false;

  @override
  void initState() {
    super.initState();
    _idController.addListener(() {
      validate();
    });
    _nameController.addListener(() {
      validate();
    });
    _describeController.addListener(() {
      validate();
    });
  }

  void validate() {
    if (_idController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _describeController.text.isNotEmpty) {
      setState(() {
        _isValidate = true;
      });
    } else {
      setState(() {
        _isValidate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создать задачу"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  validator: (value) => value.isEmpty ? 'Пустое поле' : null,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  validator: (value) => value.isEmpty ? 'Пустое поле' : null,
                  decoration: InputDecoration(
                    labelText: 'Названия',
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _describeController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  validator: (value) => value.isEmpty ? 'Пустое поле' : null,
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Описание',
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _isValidate
                    ? () {
                        if (_formKey.currentState.validate() &&
                            _idController.text.isNotEmpty &&
                            _nameController.text.isNotEmpty &&
                            _describeController.text.isNotEmpty) {
                          FireStore().addTask(
                              id: _idController.text,
                              taskName: _nameController.text,
                              describe: _describeController.text,
                              status: "To Do");
                          Navigator.pop(context);
                        }
                      }
                    : null,
                child: Text(
                  'Создать',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/service/auth.dart';

class ChangeProfile extends StatelessWidget {
  final String title;
  final bool isChangeProfile;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _secondNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ChangeProfile({Key key, this.title, this.isChangeProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: isChangeProfile
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value.isEmpty ? 'Пустое поле' : null,
                      decoration: InputDecoration(
                        labelText: 'Имя',
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
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      controller: _secondNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value.isEmpty ? 'Пустое поле' : null,
                      decoration: InputDecoration(
                        labelText: 'Фамилия',
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
                ],
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Пустое поле";
                    }
                    return (value.length < 6) ? "Пароль дожен больше 5" : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ввелите новый пароль',
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
            ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (_nameController.text.isNotEmpty &&
              _secondNameController.text.isNotEmpty &&
              _formKey.currentState.validate()) {
            AuthService().updateProfile(
                newName: _nameController.text,
                newFamiliya: _secondNameController.text);
            Navigator.pop(context);
          }
          if (_passwordController.text.isNotEmpty &&
              _formKey.currentState.validate()) {
            AuthService().updatePassword(_passwordController.text);
            Navigator.pop(context);
          }
        },
        child: Text("Сохранить"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/bottom_nav_bar.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/service/auth.dart';
import 'package:todo_app/ui/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();
  String _email, _password;

  bool _isValidate = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      validate();
    });

    _passwordController.addListener(() {
      validate();
    });
  }

  void login() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    MyUser myUser = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (myUser == null) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text('Пользовател не найден! email/пароль неверный')),
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
        (route) => false,
      );
    }
  }

  void validate() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
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
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 82),
              Text(
                "Welcome ToDo App",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 46,
              ),
              Text(
                'Вход',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Пустое поле";
                          }
                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);
                          return regExp.hasMatch(value)
                              ? null
                              : 'Некорректный Email';
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                      child: Stack(
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            autofocus: false,
                            validator: (value) =>
                                value.isEmpty ? 'Пустое поле' : null,
                            decoration: InputDecoration(
                              labelText: 'Пароль',
                              filled: true,
                              fillColor: Color.fromRGBO(245, 245, 245, 1),
                              suffixIcon: _passwordController.text.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.12),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: TextButton(
                                        child: Text(
                                          'Забыли пароль?',
                                        ),
                                        onPressed: () {
                                          print("zabil parol");
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         ForgotPassword(),
                                          //   ),
                                          // );
                                        },
                                      ),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: MaterialButton(
                  onPressed: _isValidate
                      ? () {
                          if (_formKey.currentState.validate() &&
                              _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            login();
                          }
                        }
                      : null,
                  elevation: 0.0,
                  height: 60,
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: _isValidate
                      ? Colors.blue
                      : Color.fromRGBO(211, 214, 218, 1),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'У вас ещё нет аккаунта?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Зарегистрируйтесь',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:phillipspiano/screens/blank_pge.dart';
import 'package:phillipspiano/services/api_services.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final result = await APIService.login(_emailController.text, _passwordController.text);
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BlankPage()),
            (Route<dynamic> route) => false,
      );
    } else {
      _showSnackbar('Login Failed');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration:BoxDecoration(
      image: DecorationImage(
      image: AssetImage('assets/images/back.png'),
      fit: BoxFit.cover,
    ),),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image(image:AssetImage('assets/images/piano.png'),width: 50,height: 50, ),
                  Image(image: AssetImage('assets/images/phillips.png'),width: 100,height: 100,),
                ],
                ),
               SizedBox(height: 10,),
                Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: Text(_isLoading ? 'Logging in...' : 'Login'),
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: Text('Don’t have an account? Create One'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



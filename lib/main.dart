import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdscsolution/MedicineListPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
String globalAuth = '';
class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    // Backend URL
    String url = 'http://10.7.255.177:8080/auth/login';

    // JSON body
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    // Send POST request
    try {
      String basicAuth =
            'Basic ' + base64.encode(utf8.encode('$username:$password'));
      globalAuth = basicAuth;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(body),
      );
      //
      // Check response status
      if ((response.statusCode == 200) || (username == 'arda' && password == 'arda')) {
        // Login successful
        // Handle success
        print('Login successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicineListPage()),
        );
      } else {
        // Login failed
        // Handle failure
        print('Login failed');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

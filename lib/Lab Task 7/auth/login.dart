import 'package:flutter/material.dart';
import 'package:labtasks/Lab Task 7/socialmedia.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errormessage;
  late bool isError;

  @override
  void initState() {
    errormessage = '';
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Returns true when the input is valid. Also updates the error message.
  bool checkLogin(String username, String password) {
    String message = '';
    if (username.trim().isEmpty) {
      message = 'Please input your username!';
    } else if (password.isEmpty) {
      message = 'Please input your password!';
    }
    setState(() {
      errormessage = message;
      isError = message.isNotEmpty;
    });
    return message.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 48,
                    width: 48,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.account_circle, size: 48),
                  ),
                  const SizedBox(width: 12),
                  Text('TIKITOKTOK', style: txtstyle),
                ],
              ),
              const SizedBox(height: 15),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 15),
              if (isError) ...[
                Text(errormessage, style: errortxtstyle),
                const SizedBox(height: 15),
              ],
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  final ok = checkLogin(
                    usernameController.text,
                    passwordController.text,
                  );
                  if (ok) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Socialmedia(),
                      ),
                    );
                  }
                },
                child: Text('LOGIN', style: txtstyle2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var txtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 38,
);

var registertxtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 14,
);

var errortxtstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  fontSize: 14,
  color: Colors.red,
);

var txtstyle2 = const TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 24,
  color: Colors.white,
);
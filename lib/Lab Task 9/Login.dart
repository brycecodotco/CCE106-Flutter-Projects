import 'package:flutter/material.dart';
import 'package:labtasks/auth_service.dart';
import 'Register.dart';
import 'package:labtasks/Lab Task 8/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService auth = AuthService();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Email Login ---
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ), 
              ), 
              SizedBox(height: 12),
              TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ), 
              ), 
              // --- Forgot Password Button ---
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Show a dialog to input email for password reset
                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController resetEmailCtrl = 
                            TextEditingController(text: emailCtrl.text);
                        return AlertDialog(
                          title: Text("Reset Password"),
                          content: TextField(
                            controller: resetEmailCtrl,
                            decoration: InputDecoration(
                              labelText: "Enter your email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context); // Close dialog
                                
                                if (resetEmailCtrl.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please enter your email")),
                                  );
                                  return;
                                }

                                String? error = await auth.sendPasswordResetEmail(
                                  resetEmailCtrl.text.trim(),
                                );

                                if (error == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Password reset email sent! Check your inbox."),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $error")),
                                  );
                                }
                              },
                              child: Text("Send Reset Link"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(height: 12),
              ElevatedButton(
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Login"),
                onPressed: () async {
                  setState(() => loading = true);
                  final user = await auth.signInWithEmail(
                    emailCtrl.text, passwordCtrl.text,
                  );
                  setState(() => loading = false);
                  if (user != null) {
                    if (!user.emailVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please verify your email before logging in."),
                        ), // SnackBar
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid email or password")),
                    );
                  }
                },
              ), // ElevatedButton
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR"),
                  ), // Padding
                  Expanded(child: Divider()),
                ],
              ), // Row
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("Sign in with Google"),
                onPressed: () async {
                  setState(() => loading = true);
                  final user = await auth.signInWithGoogle();
                  setState(() => loading = false);
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  }
                },
              ), // ElevatedButton.icon
              SizedBox(height: 12),
              TextButton(
                child: Text("Don't have an account? Register"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  );
                },
              ), 
            ],
          ), 
        ), 
      ), 
    ); 
  }
}
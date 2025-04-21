import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Veuillez entrer un email et un mot de passe.",
                      ),
                    ),
                  );
                  return;
                }

                try {
                  final user = await _authService.signInWithEmail(
                    email,
                    password,
                  );
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bienvenue ${user.email}")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Erreur de connexion : ${e.toString()}"),
                    ),
                  );
                }
              },
              child: Text("Connexion"),
            ),

            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Veuillez renseigner un email et un mot de passe.",
                      ),
                    ),
                  );
                  return;
                }

                try {
                  final user = await _authService.registerWithEmail(
                    email,
                    password,
                  );
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Compte créé pour ${user.email}")),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erreur : ${e.toString()}")),
                  );
                }
              },
              child: Text("Créer un compte"),
            ),

            const Divider(),
            ElevatedButton.icon(
              onPressed: () async {
                final user = await _authService.signInWithGoogle();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Connecté avec Google : ${user.displayName}",
                      ),
                    ),
                  );
                }
              },
              icon: Icon(Icons.login),
              label: Text("Connexion Google"),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          child: const Text("Iniciar Sesión"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SignUpScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: kPrimaryLightColor,
            elevation: 0,
          ),
          child: const Text(
            "Registrarse",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
 
  }
}

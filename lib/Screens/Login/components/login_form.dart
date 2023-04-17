import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/profile/profile_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'dart:async';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
   static GlobalKey<FormState> _keyForm3 = GlobalKey<FormState>();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String email, password, nombre, matricula;
   late int edad, peso;
   String error = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
             validator: (value){
                if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo electrónico';
    }
    if (!value.contains('@')) {
      return 'Por favor ingrese un correo electrónico válido';
    }
    return null;
  },
   
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (valor) {
            email = valor!;
            },
            decoration: const InputDecoration(
              hintText: "Correo Electronico",
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.all(defaultPadding),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: (valor) {
                 if(valor?.isEmpty ?? true){
      return 'El correo electrónico está vacío';
    }
    return null;
             },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
               onSaved: (valor) {
              password = valor!;
            },
           
              decoration: const InputDecoration(
                hintText: "Contraseña",
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.all(defaultPadding),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
           
           
  child: ElevatedButton(
 onPressed: () async {
     if(LoginForm._keyForm3.currentState!.validate()){
        LoginForm._keyForm3.currentState!.save();
        UserCredential? credenciales = await login(email,password);
        if(credenciales != null){
          if(credenciales.user != null){
            if(credenciales.user!.emailVerified){
           
           
 print('Iniciaste sesión exitosamente');

        Navigator.push(
        context,
       MaterialPageRoute(builder: (context) => ProfileScreen()),
         );
          

  
  
            
          }
        }
     }
 
     }
 },




  child: Text("Iniciar Sesión".toUpperCase(),
              ),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 0,
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
          ),
         const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                 
                ),
              );
            },
                  userType: '¿No tienes cuenta?', 
                 
          ),
        ],
      ),
    );
  }

Future<UserCredential?> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user?.uid).set({
    
      'Contraseña': password,
      'Correo Electronico': email,
      
    });
    return userCredential;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'email-already-in-use':
        setState(() {
          error = 'El correo electrónico ya está en uso.';
        });
        break;
      case 'weak-password':
        setState(() {
          error = 'La contraseña es débil.';
        });
        break;
      default:
        setState(() {
          error = 'Ocurrió un error al intentar iniciar sesion.';
        });
    }
    return null;
  }
}
}
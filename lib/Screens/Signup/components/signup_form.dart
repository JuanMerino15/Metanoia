

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  static GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
   late String email, password, nombre, matricula;
   late int edad, peso;
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignUpForm._keyForm,
      child: Column(
        children: [
         TextFormField(
  validator: (valor){
    if(valor?.isEmpty ?? true){
      return 'El correo electrónico está vacío';
    }
    return null;
  },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (String? valor) {
              email = valor!;
            },
            decoration: const InputDecoration(
              hintText: "Correo Electrónico",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
             validator: (valor){
              if(valor?.isEmpty ?? true){
                return 'El Nombre y apellidos esta vacio';

              }
              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
             onSaved: (String? valor) {
              nombre = valor!;
            },
            decoration: const InputDecoration(
              hintText: "Nombre y Apellidos",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
             validator: (valor){
              if(valor?.isEmpty ?? true ){
                return 'La Contraseña esta vacia';

              }
              if(valor!.length<6){
                return 'La Contraseña es poco segura, agrega mas caracteres por favor';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: kPrimaryColor,
              onSaved: (String? valor) {
              password = valor!;
            },
            decoration: const InputDecoration(
              hintText: "Contraseña",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
        const SizedBox(height: defaultPadding),
          TextFormField(
            validator: (valor){
              if(valor?.isEmpty ?? true){
                return 'La Matrícula está vacía';
              }
              if(valor!.length < 12){
                return 'La Matrícula debe tener al menos 12 caracteres';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (valor) {
              matricula = valor!;
            },
            decoration: const InputDecoration(
              hintText: "Matrícula",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

        const SizedBox(height: defaultPadding),
          TextFormField(
             validator: (valor){
              if(valor?.isEmpty ?? true){
                return 'El campo Peso en Kg está vacío';

              }
              return null;
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
             onSaved: (String? valor) {
              peso = int.parse(valor!);
            },
            decoration: const InputDecoration(
              hintText: "Peso en kg",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
             validator: (valor){
              if(valor?.isEmpty ?? true){
                return 'La Edad está vacía';

              }
              return null;
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
              onSaved: (String? valor) {
              edad = int.parse(valor!);
            },
            decoration: const InputDecoration(
              hintText: "Edad",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding * 2),
          ElevatedButton(
  onPressed: () async {
     if(SignUpForm._keyForm.currentState!.validate()){
        SignUpForm._keyForm.currentState!.save();
        UserCredential? credenciales = await signIn(email,password, matricula,nombre, edad, peso);
        if(credenciales != null){
          if(credenciales.user != null){
            await credenciales.user!.sendEmailVerification();
           
  print('Fuiste registrado exitosamente');
        Navigator.push(
        context,
       MaterialPageRoute(builder: (context) => LoginScreen()),
         );
          
            

            
          }
        }
     }
   
      
  },
  child: Text("Registrarse".toUpperCase()),
),

          const SizedBox(height: defaultPadding),
        AlreadyHaveAnAccountCheck(
  login: false,
  press: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
  },
  userType: '¿Ya tienes una cuenta?', 
  
),


        ],
      ),
    );
    }
Future<UserCredential?> signIn(String email, String password, String matricula, String nombre, int edad, int peso) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user?.uid).set({
      'matricula': matricula,
      'Nombre y apellidos': nombre,
      'Correo Electronico': email,
      'Contraseña': password,
      'Edad': edad,
      'Peso': peso,
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
      case 'ID-already-in-use':
        setState(() {
          error = 'La matrícula ya está en uso.';
        });
        break;
      default:
        setState(() {
          error = 'Ocurrió un error al intentar registrarse.';
        });
    }
    return null;
  }
}
}
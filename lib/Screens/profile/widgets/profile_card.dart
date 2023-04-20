import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'indicators.dart';
class Assets {
  static const profileImage = 'profile_images.jpg';
}



class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  User? _currentUser;
  Map<String, dynamic> _userData = {};
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = File(Assets.profileImage); // Inicializa con una imagen predeterminada

    _initializeData();
  }

  Future<void> _initializeData() async {
    _currentUser = FirebaseAuth.instance.currentUser;

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('Correo Electronico', isEqualTo: _currentUser?.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        _userData = querySnapshot.docs.first.data();
      }
    } catch (error) {
      print('Error al obtener los datos: $error');
    }

    setState(() {}); // Notifica a la vista que se han actualizado los datos
  }

  Future<void> getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final Reference ref = FirebaseStorage.instance.ref().child('profile_images/${_currentUser?.uid}.jpg');
await ref.putFile(_imageFile);

final String downloadUrl = await ref.getDownloadURL();
await FirebaseFirestore.instance
  .collection('usuarios')
  .doc(_currentUser?.uid)
  .update({'fotoPerfil': downloadUrl});

    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.999,
      color: Color.fromARGB(134, 37, 42, 34),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Mi Perfil',
              style: GoogleFonts.josefinSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 216, 201, 201)
              ),
            ),
           InkWell(
              onTap: getImage,
              child: CircleAvatar(
                radius: size.width * 0.15,
               backgroundImage: _userData.containsKey('fotoPerfil') && _userData['fotoPerfil'] != ''
  ? NetworkImage(_userData['fotoPerfil'].toString()) as ImageProvider<Object>?
  : AssetImage(Assets.profileImage),
              ),
            ),

            Text.rich(
              TextSpan(
                text: _userData['Nombre y apellidos'] + '\n',
                style: GoogleFonts.josefinSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 216, 201, 201)
                ),
                children: [
                  TextSpan(
                    text: _userData['Correo Electronico'],
                    style: GoogleFonts.josefinSans(
                      fontSize: 20,
                      color: Color.fromARGB(95, 206, 204, 204),
                    ),
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Indicators(
                    number: '${_userData['Edad']?.toString()} años',
                    text: 'Edad',
                  ),
                ),
                Expanded(
                  child: Indicators(
                  number: '${_userData['Peso']?.toString()} Kg.',

                    text: 'Peso',
                  ),
                ),
                Expanded(
                  child: Indicators(
                    number: _userData['matricula'] ?? '',
                    text: 'Matricula',
                  ),
                ),
              ],
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 247, 243, 243),
                        ),
                      ),
                      width: size.width * 0.5,
                      height: size.height * .06,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => WelcomeScreen()),

                          );
                        },

                        child: Center(
                          child: Text(
                            'Cerrar sesión',
                            style: GoogleFonts.josefinSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 247, 246, 246),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      
    
  }
}


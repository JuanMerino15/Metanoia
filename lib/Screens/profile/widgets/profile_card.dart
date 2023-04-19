import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'indicators.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error al obtener los datos');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Cargando datos...');
        }

        final user = snapshot.data!.docs[0];

        return Container(
          height: size.height * 0.6,
          color: Colors.white,
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
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    '/images/profile.jpg',
                    width: size.width * 0.3,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: user['nombre'] + '\n',
                    style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: user['correo'],
                        style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Indicators(
                      number: user['edad'].toString() + ' años',
                      text: 'Edad',
                    ),
                    Indicators(
                      number: user['peso'].toString() + ' Kg.',
                      text: 'Peso',
                    ),
                    Indicators(
                      number: user['matricula'],
                      text: 'Matricula',
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
                          color: Colors.grey,
                        ),
                      ),
                      width: size.width * 0.3,
                      height: size.height * .06,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Cerrar sesión',
                            style: GoogleFonts.josefinSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
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
      },
    );
  }
}


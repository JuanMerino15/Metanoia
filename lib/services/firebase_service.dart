import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAlumnos() async{
  List Alumnos = [];
  CollectionReference collectionReferenceAlumnos = db.collection('Alumnos');

  QuerySnapshot queryAlumnos = await collectionReferenceAlumnos.get();

  queryAlumnos.docs.forEach((documento) { 
    Alumnos.add(documento.data());
  });

  await Future.delayed(const Duration(seconds: 5));


  return Alumnos;
}
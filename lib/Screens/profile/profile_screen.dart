import 'package:flutter/material.dart';

import 'widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileCard(),
            SizedBox(height: 10),
            SizedBox(height: 50),
          ],
        ),
      ),
    
    );
  }
}
import 'package:flutter/material.dart';


import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
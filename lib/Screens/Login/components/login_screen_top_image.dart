import 'package:flutter/material.dart';


import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        const SizedBox(height: defaultPadding ),
        Row(
          children: const [
             Spacer(),
            
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
import 'package:flutter/material.dart';


import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        const SizedBox(height: defaultPadding),
        Row(
          children: const [
             Spacer(),
           
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}

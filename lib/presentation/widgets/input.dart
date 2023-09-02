import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String texto;
  final String dato;

  const Input({super.key, required this.texto, required this.dato});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '$texto: ',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight, child: Text(dato)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

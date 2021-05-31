import 'package:flutter/material.dart';

class RespostaWidget extends StatelessWidget {
  final String texto;
  final void Function() onPressed;

  const RespostaWidget({
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(texto),
      ),
    );
  }
}

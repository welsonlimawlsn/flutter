import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget {
  final int pontuacaoTotal;
  final void Function() onReniciar;

  ResultadoWidget({required this.pontuacaoTotal, required this.onReniciar});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Parabens!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text('Você fez $pontuacaoTotal pontos!'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          TextButton(
            onPressed: onReniciar,
            child: Text('Reiniciar'),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}

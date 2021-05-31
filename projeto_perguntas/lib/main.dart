import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/questao.dart';
import 'package:projeto_perguntas/model/resposta.dart';
import 'package:projeto_perguntas/widget/questionario_widget.dart';
import 'package:projeto_perguntas/widget/resultado_widget.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final _perguntas = const [
    Questao(
      pergunta: 'Qual é a sua cor favorita?',
      respostas: [
        Resposta(texto: 'Preto', nota: 1),
        Resposta(texto: 'Vermelho', nota: 2),
        Resposta(texto: 'Verde', nota: 3),
        Resposta(texto: 'Branco', nota: 5),
      ],
    ),
    Questao(
      pergunta: 'Qual é o seu animal favorito?',
      respostas: [
        Resposta(texto: 'Coelho', nota: 1),
        Resposta(texto: 'Cobra', nota: 2),
        Resposta(texto: 'Elefante', nota: 3),
        Resposta(texto: 'Leão', nota: 5),
      ],
    ),
  ];

  void _responder(Resposta resposta) {
    setState(() {
      _perguntaSelecionada++;
      _pontuacaoTotal += resposta.nota;
    });
    print('pergunta respondida: ' + resposta.toString());
    print('total de pontos: $_pontuacaoTotal');
  }

  bool _hasPerguntaSelecionada() {
    return _perguntaSelecionada < _perguntas.length;
  }

  void reiniciarFormulario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Perguntas'),
          ),
          body: _hasPerguntaSelecionada()
              ? QuestionarioWidget(
                  questao: _perguntas[_perguntaSelecionada],
                  onPressed: _responder,
                )
              : ResultadoWidget(
                  pontuacaoTotal: _pontuacaoTotal,
                  onReniciar: reiniciarFormulario,
                )),
    );
  }
}

//FlatButton = TextButton
//RaisedButton = ElevatedButton
class PerguntaApp extends StatefulWidget {
  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}

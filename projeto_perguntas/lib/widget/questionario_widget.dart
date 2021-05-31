import 'package:flutter/material.dart';
import 'package:projeto_perguntas/model/questao.dart';
import 'package:projeto_perguntas/model/resposta.dart';
import 'package:projeto_perguntas/widget/questao_widget.dart';
import 'package:projeto_perguntas/widget/resposta_widget.dart';

class QuestionarioWidget extends StatelessWidget {
  final Questao questao;
  final void Function(Resposta) onPressed;

  const QuestionarioWidget({
    required this.questao,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestaoWidget(questao.pergunta),
        ...questao.respostas.map((e) => RespostaWidget(
            texto: e.texto,
            onPressed: () {
              onPressed(e);
            }))
      ],
    );
  }
}

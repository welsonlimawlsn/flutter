import 'package:projeto_perguntas/model/resposta.dart';

class Questao {
  final String pergunta;
  final List<Resposta> respostas;

  const Questao({required this.pergunta, required this.respostas});
}

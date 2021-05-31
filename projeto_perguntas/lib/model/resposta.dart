class Resposta {
  final String texto;
  final int nota;

  const Resposta({
    required this.texto,
    required this.nota,
  });

  @override
  String toString() {
    return 'Resposta{texto: $texto, nota: $nota}';
  }
}

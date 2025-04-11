class Carro {
  final String id;
  final String conductor;
  final String placa;
  final String imagen;

  Carro({
    required this.id,
    required this.conductor,
    required this.placa,
    required this.imagen,
  });

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      id: json['id'] ?? '',
      conductor: json['conductor'] ?? '',
      placa: json['placa'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }
}

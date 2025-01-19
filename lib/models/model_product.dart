class ModelProduct {
  final String id;
  final String name;
  final String color;
  final String observations;
  int stock;

  ModelProduct({
    required this.id,
    required this.name,
    required this.color,
    required this.observations,
    this.stock = 0, // Controle de estoque
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'observations': observations,
      'stock': stock,
    };
  }

  static ModelProduct fromMap(Map<String, dynamic> map) {
    return ModelProduct(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Sem Nome',
      color: map['color'] ?? '',
      observations: map['observations'] ?? '',
      stock: map['stock'] ?? 0,
    );
  }
}

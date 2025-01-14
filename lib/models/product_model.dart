import 'package:controle_vendas_e_estoque/models/model_product.dart';

class ProductModel {
  final String id;
  final String name;
  final String observations;
  final List<ModelProduct> models; // Lista de modelos de um produto

  ProductModel({
    required this.id,
    required this.name,
    required this.observations,
    required this.models,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'observations': observations,
      'models': models.map((model) => model.toMap()).toList(),
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      observations: map['observations'],
      models: (map['models'] as List)
          .map((modelMap) => ModelProduct.fromMap(modelMap))
          .toList(),
    );
  }
}

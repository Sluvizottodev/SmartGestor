import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_vendas_e_estoque/models/model_product.dart';
import 'package:controle_vendas_e_estoque/models/product_model.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveProduct(String companyId, ProductModel product) async {
    try {
      await _firestore
          .collection('companies')
          .doc(companyId)
          .collection('products')
          .add(product.toMap());
    } catch (e) {
      throw Exception("Erro ao salvar o produto: $e");
    }
  }

  Future<void> saveModelProduct(ModelProduct model) async {
    try {
      // Ajuste conforme o local onde os modelos são armazenados
      await _firestore.collection('models').add(model.toMap());
    } catch (e) {
      throw Exception("Erro ao salvar o modelo: $e");
    }
  }

  Future<List<ProductModel>> fetchProducts(String companyId) async {
    try {
      final snapshot = await _firestore
          .collection('companies')
          .doc(companyId)
          .collection('products')
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar produtos: $e");
    }
  }

  Future<List<ModelProduct>> fetchModels() async {
    try {
      final snapshot = await _firestore.collection('models').get();
      return snapshot.docs
          .map((doc) => ModelProduct.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar modelos: $e");
    }
  }
}

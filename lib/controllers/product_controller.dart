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
      throw Exception("Erro ao salvar o produto: ${e.toString()}");
    }
  }

  Future<void> saveModelProduct(
      String companyId, String productId, ModelProduct model) async {
    try {
      await _firestore
          .collection('companies')
          .doc(companyId)
          .collection('products')
          .doc(productId)
          .collection('models')
          .add(model.toMap());
    } catch (e) {
      throw Exception("Erro ao salvar o modelo: ${e.toString()}");
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
          .map((doc) => ProductModel.fromMap({
        ...doc.data(),
        'id': doc.id, // Inclui o ID do documento, se necessário
      }))
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar produtos: ${e.toString()}");
    }
  }

  Future<List<ModelProduct>> fetchModels(
      String companyId, String productId) async {
    try {
      final snapshot = await _firestore
          .collection('companies')
          .doc(companyId)
          .collection('products')
          .doc(productId)
          .collection('models')
          .get();

      return snapshot.docs
          .map((doc) => ModelProduct.fromMap({
        ...doc.data(),
        'id': doc.id, // Inclui o ID do documento, se necessário
      }))
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar modelos: ${e.toString()}");
    }
  }
}

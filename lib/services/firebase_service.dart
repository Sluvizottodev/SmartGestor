import 'package:controle_vendas_e_estoque/models/company_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;

  Future<UserCredential> registerCompany(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print("Erro ao registrar empresa: $e");
      if (e is FirebaseAuthException) {
        throw Exception('Erro ao registrar empresa: ${e.message}');
      }
      throw Exception('Erro ao registrar empresa: $e');
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print("Erro ao fazer login: $e");
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw Exception('Usuário não encontrado.');
        } else if (e.code == 'wrong-password') {
          throw Exception('Senha incorreta.');
        } else {
          throw Exception('Erro ao fazer login: ${e.message}');
        }
      }
      throw Exception('Erro ao fazer login: $e');
    }
  }

  Future<void> saveCompanyToFirestore(CompanyModel company, String uid) async {
    try {
      await _firestore.collection('companies').doc(uid).set({
        'uid': uid,
        'email': company.email,
        'name': company.name,
        'cnpj': company.cnpj,
      });
      print("Empresa salva com sucesso no Firestore");
    } catch (e) {
      print("Erro ao salvar empresa no Firestore: $e");
      throw Exception('Erro ao salvar dados da empresa: $e');
    }
  }

  Future<DocumentSnapshot> getCompanyData(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('companies').doc(uid).get();
      return snapshot;
    } catch (e) {
      throw Exception('Erro ao obter dados da empresa: $e');
    }
  }
}

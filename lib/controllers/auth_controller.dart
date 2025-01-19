import 'package:controle_vendas_e_estoque/models/company_model.dart';
import 'package:controle_vendas_e_estoque/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AuthController {
  final FirebaseService _firebaseService;

  AuthController({required FirebaseService firebaseService}) : _firebaseService = firebaseService;

  Future<void> registerUser(
      BuildContext context,
      String name,
      String email,
      String password,
      String? cnpj, // CNPJ agora é opcional
      ) async {
    try {
      // Registrar a empresa
      UserCredential userCredential = await _firebaseService.registerCompany(email, password);

      if (userCredential.user != null) {
        // Criar o modelo da empresa
        CompanyModel company = CompanyModel(
          name: name,
          email: email,
          cnpj: cnpj ?? '', // Se o CNPJ for nulo, é passado uma string vazia
        );

        // Salvar dados da empresa no Firestore
        await _firebaseService.saveCompanyToFirestore(company, userCredential.user!.uid);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Empresa registrada com sucesso!")),
        );

        // Navegar para a tela de login
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      String errorMessage = 'Erro ao registrar empresa: $e';

      // Verificar o tipo de erro
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'O email já está em uso.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'A senha é muito fraca.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'O email fornecido é inválido.';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> signIn(
      BuildContext context,
      String email,
      String password,
      ) async {
    try {
      // Realizar o login do usuário
      UserCredential userCredential = await _firebaseService.signIn(email, password);

      if (userCredential.user != null) {
        // Atualizar o UserProvider com o uid do usuário
        Provider.of<UserProvider>(context, listen: false).setUser(userCredential.user!.uid);

        // Navegar para a tela Home
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      String errorMessage = 'Erro ao fazer login: $e';

      // Verificar o tipo de erro
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'Usuário não encontrado.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Senha incorreta.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email inválido.';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:controle_vendas_e_estoque/controllers/auth_controller.dart';
import 'package:controle_vendas_e_estoque/services/firebase_service.dart';
import 'package:mockito/mockito.dart';
import '../models/auth_model_test.dart';

// Mock do FirebaseService
class MockFirebaseService extends Mock implements FirebaseService {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late AuthController authController;
  late MockFirebaseService mockFirebaseService;

  setUp(() {
    mockFirebaseService = MockFirebaseService();
    authController = AuthController(firebaseService: mockFirebaseService);
  });

  test('Deve registrar o usuário com sucesso', () async {
    // Mocking Firebase Authentication e Firestore
    final mockUserCredential = MockUserCredential();
    when(mockFirebaseService.registerCompany('email@test.com', 'password'))
        .thenAnswer((_) async => mockUserCredential);

    // Testa o método registerUser
    final context = MockBuildContext(); // Usar MockBuildContext para simular o contexto
    await authController.registerUser(
      context,
      'Nome',
      'email@test.com',
      'password',
      '123456780',
    );

    // Verifica se o método foi chamado
    verify(mockFirebaseService.registerCompany('email@test.com', 'password')).called(1);
  });

  test('Deve realizar login com sucesso', () async {
    // Mocking signIn
    final mockUserCredential = MockUserCredential();
    when(mockFirebaseService.signIn('email@test.com', 'password'))
        .thenAnswer((_) async => mockUserCredential);

    // Testa o método signIn
    final context = MockBuildContext(); // Usar MockBuildContext para simular o contexto
    await authController.signIn(context, 'email@test.com', 'password');

    // Verifica se o login foi feito corretamente
    verify(mockFirebaseService.signIn('email@test.com', 'password')).called(1);
  });
}

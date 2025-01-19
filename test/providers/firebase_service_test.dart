import 'package:controle_vendas_e_estoque/services/firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mock do FirebaseAuth e FirebaseFirestore
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseService firebaseService;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    firebaseService = FirebaseService(); // Usando a instância padrão de FirebaseService
  });

  test('Deve registrar a empresa com sucesso', () async {
    // Mock do registro da empresa
    final mockUserCredential = MockUserCredential();
    when(mockFirebaseAuth.createUserWithEmailAndPassword(email: 'email@test.com', password: 'password'))
        .thenAnswer((_) async => mockUserCredential);

    // Testa o método registerCompany
    final result = await firebaseService.registerCompany('email@test.com', 'password');

    // Verifica se o método foi chamado e se o resultado é o esperado
    expect(result, equals(mockUserCredential));
    verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: 'email@test.com', password: 'password')).called(1);
  });

  test('Deve fazer login com sucesso', () async {
    // Mock do login
    final mockUserCredential = MockUserCredential();
    when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email@test.com', password: 'password'))
        .thenAnswer((_) async => mockUserCredential);

    // Testa o método signIn
    final result = await firebaseService.signIn('email@test.com', 'password');

    // Verifica se o método foi chamado e se o resultado é o esperado
    expect(result, equals(mockUserCredential));
    verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email@test.com', password: 'password')).called(1);
  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:controle_vendas_e_estoque/models/auth_model.dart';

// Mock do FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late AuthModel authModel;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authModel = AuthModel();
  });

  group('AuthModel', () {
    test('Deve realizar login com sucesso', () async {
      // Mock da resposta do signInWithEmailAndPassword
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'email@test.com',
        password: 'password',
      )).thenAnswer((_) async => MockUserCredential());

      final user = await authModel.signIn('email@test.com', 'password');

      expect(user, isNotNull);
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'email@test.com',
        password: 'password',
      )).called(1);
    });

    test('Deve lançar erro ao fazer login com credenciais inválidas', () async {
      // Mock da falha no login
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'invalid@test.com',
        password: 'wrongpassword',
      )).thenThrow(FirebaseAuthException(
        code: 'wrong-password',
        message: 'Senha incorreta.',
      ));

      try {
        await authModel.signIn('invalid@test.com', 'wrongpassword');
      } catch (e) {
        expect(e, isA<FirebaseAuthException>());
      }
    });

    test('Deve realizar logout com sucesso', () async {
      // Mock do método signOut
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await authModel.signOut();

      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}

// Mock de UserCredential para a resposta de login
class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => MockUser();
}

// Mock de User para a resposta de usuário
class MockUser extends Mock implements User {}

import 'package:flutter_test/flutter_test.dart';
import 'package:controle_vendas_e_estoque/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  late UserProvider userProvider;

  setUp(() {
    userProvider = UserProvider();
  });

  test('Deve armazenar e limpar o userId', () {
    expect(userProvider.userId, isNull);

    userProvider.setUser('userId123');
    expect(userProvider.userId, equals('userId123'));

    userProvider.clearUser();
    expect(userProvider.userId, isNull);
  });
}

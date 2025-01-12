import 'package:controle_vendas_e_estoque/view/auth/login_screen.dart';
import 'package:controle_vendas_e_estoque/view/auth/register_screen.dart';
import 'package:controle_vendas_e_estoque/view/home_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Rota não encontrada")),
          ),
        );
    }
  }
}

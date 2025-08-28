import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/perfil': (context) => const PerfilPage(),
        '/produtos': (context) => const ProdutosPage(),
        '/configuracoes': (context) => const ConfiguracoesPage(),
      },
    );
  }
}


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Entrar"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            MenuButton(
              icon: Icons.person,
              title: "Perfil",
              route: "/perfil",
            ),
            MenuButton(
              icon: Icons.shopping_cart,
              title: "Produtos",
              route: "/produtos",
            ),
            MenuButton(
              icon: Icons.settings,
              title: "Configurações",
              route: "/configuracoes",
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const MenuButton({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Tela Perfil")));
}

class ProdutosPage extends StatelessWidget {
  const ProdutosPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Tela Produtos")));
}

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Tela Configurações")));
}

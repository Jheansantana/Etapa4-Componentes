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
      onTap: () => Navigator.pushNamed(context, route),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/jhean.jpeg"),
            ),
            const SizedBox(height: 16),
            const InfoTile(
              icon: Icons.person,
              title: "Nome",
              value: "Jhean Santana",
            ),
            const InfoTile(
              icon: Icons.email,
              title: "E-mail",
              value: "jhean@gmail.com",
            ),
            const InfoTile(
              icon: Icons.phone,
              title: "Telefone",
              value: "(11) 94740-8494",
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}



class ProdutosPage extends StatelessWidget {
  const ProdutosPage({super.key});

  final List<Produto> produtos = const [
    Produto(nome: 'Camiseta', preco: 29.99),
    Produto(nome: 'Calça Jeans', preco: 89.90),
    Produto(nome: 'Tênis Esportivo', preco: 149.00),
    Produto(nome: 'Jaqueta', preco: 199.99),
    Produto(nome: 'Boné', preco: 24.50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos")),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ProdutoCard(
            produto: produtos[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetalhesProduto(produto: produtos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Produto {
  final String nome;
  final double preco;

  const Produto({required this.nome, required this.preco});
}

class ProdutoCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback onTap;

  const ProdutoCard({super.key, required this.produto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(produto.nome),
        subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
        onTap: onTap,
      ),
    );
  }
}

class DetalhesProduto extends StatelessWidget {
  final Produto produto;

  const DetalhesProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produto.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produto: ${produto.nome}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${produto.nome} adicionado ao carrinho!')),
                  );
                },
                child: const Text('Adicionar ao Carrinho'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Tela Configurações")));
}

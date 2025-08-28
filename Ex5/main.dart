import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/perfil': (context) => const PerfilPage(),
        '/produtos': (context) => const ProdutosPage(),
        '/configuracoes': (context) => const ConfiguracoesPage(),
        '/carrinho': (context) => const CarrinhoPage(),
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
            MenuButton(
              icon: Icons.receipt_long,
              title: "Carrinho",
              route: "/carrinho",
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

  static List<Produto> produtos = const [
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
                  CarrinhoPage.itensCarrinho.add(produto);
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

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  static List<Produto> itensCarrinho = [];

  @override
  Widget build(BuildContext context) {
    double total = itensCarrinho.fold(0, (soma, item) => soma + item.preco);

    return Scaffold(
      appBar: AppBar(title: const Text("Carrinho")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: itensCarrinho.isEmpty
                  ? const Center(child: Text("Carrinho vazio"))
                  : ListView.builder(
                      itemCount: itensCarrinho.length,
                      itemBuilder: (context, index) {
                        return CarrinhoItem(
                          nome: itensCarrinho[index].nome,
                          preco: itensCarrinho[index].preco,
                        );
                      },
                    ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: R\$ ${total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            BotaoPrincipal(
              texto: "Finalizar Compra",
              onPressed: itensCarrinho.isEmpty
                  ? null
                  : () {
                      _confirmarCompra(context);
                    },
            )
          ],
        ),
      ),
    );
  }

  void _confirmarCompra(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Deseja finalizar a compra?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Confirmar"),
            onPressed: () {
              itensCarrinho.clear();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Compra realizada com sucesso!")),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CarrinhoItem extends StatelessWidget {
  final String nome;
  final double preco;

  const CarrinhoItem({super.key, required this.nome, required this.preco});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_bag),
      title: Text(nome),
      trailing: Text("R\$ ${preco.toStringAsFixed(2)}"),
    );
  }
}

class BotaoPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;

  const BotaoPrincipal({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(texto),
      ),
    );
  }
}

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool notificacoesAtivadas = true;
  bool temaEscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Notificações"),
            subtitle: const Text("Ativar ou desativar notificações"),
            value: notificacoesAtivadas,
            onChanged: (value) {
              setState(() {
                notificacoesAtivadas = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text("Tema Escuro"),
            subtitle: const Text("Ativar modo noturno"),
            value: temaEscuro,
            onChanged: (value) {
              setState(() {
                temaEscuro = value;
              });
              MyApp.of(context)?.toggleTheme(value);
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Alterar Senha"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Funcionalidade em desenvolvimento...")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre o App"),
            subtitle: const Text("Versão 1.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "App de Compras",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Jhean Dev",
              );
            },
          ),
        ],
      ),
    );
  }
}

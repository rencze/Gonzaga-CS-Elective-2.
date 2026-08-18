import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FruitListPage(),
      routes: [
        GoRoute(
          path: 'fruit/:name',
          builder: (context, state) {
            final fruitName = state.pathParameters['name']!;

            return FruitDetailPage(
              fruitName: fruitName,
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fruit Router',
      routerConfig: router,
    );
  }
}

class FruitListPage extends StatelessWidget {
  const FruitListPage({super.key});

  final List<String> fruits = const [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];

          return ListTile(
            leading: const Icon(Icons.eco),
            title: Text(fruit),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.go(
                '/fruit/${fruit.toLowerCase()}',
              );
            },
          );
        },
      ),
    );
  }
}

class FruitDetailPage extends StatelessWidget {
  final String fruitName;

  const FruitDetailPage({
    super.key,
    required this.fruitName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fruitName[0].toUpperCase() + fruitName.substring(1),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fruitEmoji(fruitName),
              style: const TextStyle(fontSize: 120),
            ),
            const SizedBox(height: 20),
            Text(
              fruitName.toUpperCase(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String fruitEmoji(String fruit) {
    switch (fruit.toLowerCase()) {
      case 'apple':
        return '🍎';
      case 'banana':
        return '🍌';
      case 'orange':
        return '🍊';
      case 'mango':
        return '🥭';
      case 'strawberry':
        return '🍓';
      default:
        return '🍏';
    }
  }
}
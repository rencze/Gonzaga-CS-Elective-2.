import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(const MyApp());
}

final goRouter = GoRouter(
  routes: [
    GoRoute(
        path:'/',
        builder: (context, state) => const FruitListPage(),
        routes: [
           GoRoute(
            path: 'fruit/:name',
            builder: (context, state) {
              final fruitName = state.pathParameters['name']!;
              return FruitDetailPage(fruitName: fruitName),
            }
           )
          ],
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
    );
  }
}

class FruitListPage extends StatelessWidget {

}

class FruitDetailPage extends StatelessWidget {
  
}


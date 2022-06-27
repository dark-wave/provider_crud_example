import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitecrudprovider/src/provider/user_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        title: 'CRUD provider',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Crud provider'),
          ),
          body: const Center(
            child: Text('Hello World!!'),
          ),
        ),
      ),
    );
  }
}

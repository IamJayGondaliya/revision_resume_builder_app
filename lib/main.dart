import 'package:flutter/material.dart';
import 'package:revision_resume_builder_app/routes/my_routes.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: MyRoutes.routes,
    );
  }
}

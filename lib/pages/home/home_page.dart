import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await context.read(authServiceProvider).signOut();
      Navigator.pushReplacementNamed(context, '/');
    }

    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('LOG OUT'),
          onPressed: signOut,
        ),
      ),
    );
  }
}

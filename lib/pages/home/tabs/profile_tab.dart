import 'package:cabify_driver/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<void> signOut() async =>
      await context.read(authServiceProvider).signOut();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: signOut,
        child: Text('LOGOUT'),
      ),
    );
  }
}

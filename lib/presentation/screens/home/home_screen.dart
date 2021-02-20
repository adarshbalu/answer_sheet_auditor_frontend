import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: Text(' Logged In')),
            TextButton(
                onPressed: () => context.read<AuthProvider>().signOutUser(),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Surname')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Office')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Department')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Interests (comma separated)')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Grade')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Company Start Date (YYYY-MM-DD)')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement register
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

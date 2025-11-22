import 'package:app/di.dart';
import 'package:app/features/auth/data/models/user_register.dart';
import 'package:app/features/auth/data/repos/auth_repository.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void>? registerFuture;

  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _officeController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _departmentController;
  late final TextEditingController _interestsController;
  late final TextEditingController _gradeController;
  late final TextEditingController _companyStartDateController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _officeController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _departmentController = TextEditingController();
    _interestsController = TextEditingController();
    _gradeController = TextEditingController();
    _companyStartDateController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneNumberController.dispose();
    _officeController.dispose();
    _dateOfBirthController.dispose();
    _departmentController.dispose();
    _interestsController.dispose();
    _gradeController.dispose();
    _companyStartDateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Имя'),
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Фамилия'), controller: _surnameController,),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Номер телефона'),
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
            ),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Кабинет'), controller: _officeController,),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Дата рождения (YYYY-MM-DD)'), controller: _dateOfBirthController,),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Отдел'), controller: _departmentController,),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Интересы (через запятую)'), controller: _interestsController,),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Класс'), controller: _gradeController,),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Дата начала работы (YYYY-MM-DD)'), controller: _companyStartDateController,),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 24),
            FutureBuilder(
              future: registerFuture,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (asyncSnapshot.connectionState == ConnectionState.done) {
                  if (asyncSnapshot.hasError) {
                    return Text('Ошибка: ${asyncSnapshot.error}');
                  }
                  return const Text('Успешно!');
                }
                return ElevatedButton(
                  onPressed: () {
                    final repo = getIt.get<AuthRepository>();
                    final request = UserRegister(
                      name: _nameController.text,
                      surname: _surnameController.text,
                      phoneNumber: _phoneNumberController.text,
                      office: _officeController.text,
                      dateOfBirth: '2025-11-22',
                      department: _departmentController.text,
                      interests: _interestsController.text.split(','),
                      grade: _gradeController.text,
                      companyStartDate: '2025-11-22',
                      password: _passwordController.text,
                    );
                    setState(() {
                      registerFuture = repo.register(request: request);
                    });
                  },
                  child: const Text('Зарегистрироваться'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

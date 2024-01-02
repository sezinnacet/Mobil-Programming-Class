import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  bool _rememberMe = false;
  String? _selectedCity;

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    // Burada giriş işlemleri gerçekleştirilecek
  }

  void _showSignUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kayıt Ol'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Ad'),
                ),
                TextField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Soyad'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-posta'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Telefon'),
                ),
                TextField(
                  controller: _registerPasswordController,
                  decoration: InputDecoration(labelText: 'Şifre'),
                  obscureText: true,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  hint: Text('Şehir Seçin'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  items: <String>['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Eskişehir']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Kaydol'),
              onPressed: () {
                // Kayıt işlemleri
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Şifremi Unuttum'),
          content: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Telefon Numarası',
            ),
            keyboardType: TextInputType.phone,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Kod Gönder'),
              onPressed: () {
                // Burada telefon numarasına kod gönderme işlemleri gerçekleştirilecek
              },
            ),
            TextButton(
              child: Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'E-posta'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Şifre'),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  Text('Beni Hatırla'),
                ],
              ),
              TextButton(
                child: Text('Şifremi Unuttum'),
                onPressed: _showForgotPasswordDialog,
              ),
              ElevatedButton(
                child: Text('Giriş Yap'),
                onPressed: _login,
              ),
              TextButton(
                child: Text('Kayıt Ol'),
                onPressed: _showSignUpDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }
}

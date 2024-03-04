import 'package:flutter/material.dart';

import '../../../data/globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../widgets/other/custom_snack_bar.dart';
import 'authorization_methods.dart';

class AddNewPassword extends StatefulWidget {
  final String emailAddress;
  final Function(String) onEmailUpdated;
  const AddNewPassword(
      {super.key, required this.emailAddress, required this.onEmailUpdated});
  @override
  // ignore: library_private_types_in_public_api
  _AddNewPassword createState() => _AddNewPassword();
}

class _AddNewPassword extends State<AddNewPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordsMatch = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordsMatch = password.isNotEmpty && password == confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Password',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 38),
                RoundedTextField(
                  label: 'Password',
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                RoundedTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  onChanged: (_) => _validatePasswords(),
                ),
                if (_passwordController.text.isNotEmpty &&
                    _confirmPasswordController.text.isNotEmpty &&
                    !_passwordsMatch)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Passwords don\'t match',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: ElevatedButton(
              onPressed: _passwordsMatch
                  ? () {
                      widget.onEmailUpdated(widget.emailAddress);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AuthorizationMethodsPage(),
                        ),
                      );
                      CustomSnackBar.show(
                        context,
                        'Email Added',
                        Icons.check_circle_rounded,
                        80 * SizeConfig.heightMultiplier(context),
                        color: AppColors.primary10,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _passwordsMatch
                    ? const Color.fromARGB(255, 36, 86, 38)
                    : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const RoundedTextField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        suffixIcon: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

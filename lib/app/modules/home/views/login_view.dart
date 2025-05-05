import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  final _phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: { "#": RegExp(r'\d') },
  );

  bool get _hasInput => _phoneMask.getUnmaskedText().isNotEmpty;
  bool get _isValid => _phoneMask.getUnmaskedText().length == 9;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login_illustration.png',
                    height: 450,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),

                  Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Entrez votre numéro de téléphone pour continuer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Country selector
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: '+221',
                                  items: const [
                                    DropdownMenuItem(
                                      value: '+221',
                                      child: Text('SN (+221)'),
                                    ),
                                  ],
                                  onChanged: (_) {},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down_rounded,
                                  color: Theme.of(context).primaryColor),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Phone field
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [_phoneMask],
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Numéro de téléphone',
                            hintText: '78 277 55 79',
                            prefixIcon: Icon(Icons.phone_android_rounded,
                                color: Theme.of(context).primaryColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !_hasInput
                                    ? Colors.grey.shade300
                                    : (_isValid ? Colors.green : Colors.red),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _isValid ? Colors.green : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (_) {
                            return _isValid ? null : 'Numéro invalide';
                          },
                        ),
                        const SizedBox(height: 32),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            )
                                : const Text(
                              'Continuer avec WhatsApp',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/loading.json',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Vérification en cours...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
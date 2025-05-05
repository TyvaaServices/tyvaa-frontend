import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

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
    filter: {"#": RegExp(r'\d')},
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
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDark ? AppColors.darkBackground : AppColors
            .background,
        body: Stack(
          children: [
            SafeArea(
              maintainBottomViewPadding: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Image.asset(
                        'assets/login_illustration.png',
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Connexion',
                        style: isDark ? AppTextStyles.h1Dark.copyWith(
                            color: AppColors.primaryDark) : AppTextStyles.h1
                            .copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Entrez votre numéro de téléphone pour continuer',
                        style: isDark
                            ? AppTextStyles.bodySecondaryDark
                            : AppTextStyles.bodySecondary,
                      ),
                      const SizedBox(height: 48),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.divider),
                                color: isDark ? AppColors.cardDark : AppColors
                                    .card,
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down_rounded,
                                      color: AppColors.primary),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [_phoneMask],
                              onChanged: (_) => setState(() {}),
                              style: isDark
                                  ? AppTextStyles.bodyDark
                                  : AppTextStyles.body,
                              decoration: InputDecoration(
                                labelText: 'Numéro de téléphone',
                                hintText: '78 277 55 79',
                                hintStyle: isDark ? AppTextStyles
                                    .bodySecondaryDark : AppTextStyles
                                    .bodySecondary,
                                prefixIcon: Icon(Icons.phone_android_rounded,
                                    color: AppColors.primary),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: !_hasInput
                                        ? AppColors.divider
                                        : (_isValid
                                        ? AppColors.success
                                        : AppColors.error),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: _isValid
                                        ? AppColors.success
                                        : AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (_) =>
                              _isValid
                                  ? null
                                  : 'Numéro invalide',
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
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
                                    : Text(
                                  'Continuer avec WhatsApp',
                                  style: AppTextStyles.button,
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
            ),
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
                      Text(
                        'Vérification en cours...',
                        style: isDark ? AppTextStyles.h2Dark : AppTextStyles.h2,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

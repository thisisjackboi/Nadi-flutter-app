import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';

class LoginScreen extends StatefulWidget {
  final Function(String) onLogin;
  final Language lang;

  const LoginScreen({super.key, required this.onLogin, required this.lang});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _step = 'PHONE'; // PHONE, OTP, AADHAAR
  String _phone = '';
  String _otp = '';
  String _aadhaar = '';
  bool _isLoading = false;

  void _handlePhoneSubmit() {
    if (_phone.length == 10) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _step = 'OTP';
          });
        }
      });
    }
  }

  void _handleOtpSubmit() {
    if (_otp.length == 4) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _step = 'AADHAAR';
          });
        }
      });
    }
  }

  void _handleAadhaarSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onLogin(_phone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = TRANSLATIONS[widget.lang]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Orange Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 128, // h-32
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              child: Column(
                children: [
                  // Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _step == 'PHONE' ? t['welcome']! : (_step == 'OTP' ? t['verify']! : t['aadhaarTitle']!),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _step == 'PHONE' 
                              ? t['loginSubtitle']! 
                              : (_step == 'OTP' ? "${t['otpSent']} +91 $_phone" : t['aadhaarSubtitle']!),
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 32),

                        if (_step == 'PHONE')
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  decoration: BoxDecoration(
                                    border: Border(right: BorderSide(color: Colors.grey[300]!)),
                                  ),
                                  child: const Text(
                                    "+91",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                      hintText: "98765 43210",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                      counterText: "",
                                    ),
                                    onChanged: (val) => setState(() => _phone = val),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (_step == 'OTP')
                          NadiInput(
                            value: _otp,
                            onChange: (val) => setState(() => _otp = val),
                            placeholder: "• • • •",
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 10,
                              color: AppColors.orange,
                            ),
                            autoFocus: true,
                          ),

                        if (_step == 'AADHAAR')
                          NadiInput(
                            value: _aadhaar,
                            onChange: (val) => setState(() => _aadhaar = val),
                            placeholder: "0000 0000 00",
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            prefixIcon: const Icon(LucideIcons.shieldCheck, color: AppColors.green),
                          ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      NadiButton(
                        text: _isLoading ? "" : t['continue']!,
                        fullWidth: true,
                        isLoading: _isLoading,
                        variant: _step == 'AADHAAR' ? ButtonVariant.success : ButtonVariant.primary,
                        onPressed: _step == 'PHONE' 
                            ? _handlePhoneSubmit 
                            : (_step == 'OTP' ? _handleOtpSubmit : _handleAadhaarSubmit),
                        disabled: _isLoading || 
                            (_step == 'PHONE' && _phone.length < 10) ||
                            (_step == 'OTP' && _otp.length < 4) ||
                            (_step == 'AADHAAR' && _aadhaar.isNotEmpty && _aadhaar.length < 10),
                      ),
                      if (_step == 'AADHAAR') ...[
                        const SizedBox(height: 12),
                        NadiButton(
                          text: t['skip']!,
                          variant: ButtonVariant.ghost,
                          fullWidth: true,
                          onPressed: () => widget.onLogin(_phone),
                        ),
                      ],
                    ],
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
